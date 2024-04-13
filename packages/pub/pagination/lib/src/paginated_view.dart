import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pagination_dart/pagination_dart.dart';
import 'package:super_sliver_list/super_sliver_list.dart';

final _pageBucket = PageStorageBucket();

// TODO: Add a "scroll to top" button when scrolled
class PaginatedView<T> extends ConsumerWidget {
  const PaginatedView({
    required this.itemsProviderBuilder,
    required this.invalidateItemsProvider,
    required this.invalidateItemPageProvider,
    required this.itemBuilder,
    required this.loadingItemBuilder,
    required this.refreshItemPageProvider,
    this.errorItemBuilder,
    this.pageSize = 20,
    this.shrinkWrap = false,
    this.transitionDuration = const Duration(milliseconds: 650),
    this.transitionCurve = Curves.easeInOut,
    this.reverseTransitionCurve,
    this.restorationId,
    super.key,
  });

  /// Watch your API and return a list of items for a page.
  ///
  /// If not using riverpod for the API call, you need to handle
  /// caching yourself as this is called for every index in the page.
  final AsyncValue<PaginatedResult<T>> Function(int page) itemsProviderBuilder;
  final void Function(int page) invalidateItemPageProvider;
  final void Function() invalidateItemsProvider;
  final Future<PaginatedResult<T>> Function(int page) refreshItemPageProvider;
  final int pageSize;
  final Widget Function(BuildContext context, T item, int indexInPage)
      itemBuilder;
  final Widget Function(BuildContext context, int page, int indexInPage)
      loadingItemBuilder;
  final Widget Function(
    BuildContext context,
    int page,
    int indexInPage,
    Object error,
    StackTrace stack,
  )? errorItemBuilder;
  final bool shrinkWrap;
  final Duration transitionDuration;
  final Curve transitionCurve;
  final Curve? reverseTransitionCurve;
  final String? restorationId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final responseAsync = itemsProviderBuilder(1);
    final totalResults = responseAsync.valueOrNull?.totalResults;
    return PageStorage(
      bucket: _pageBucket,
      child: RefreshIndicator(
        onRefresh: () async {
          invalidateItemsProvider();
          try {
            await refreshItemPageProvider(1);
          } catch (e) {
            // fail silently as the provider error state is handled inside the ListView
          }
        },
        child: SuperListView.builder(
          key: PageStorageKey(restorationId),
          shrinkWrap: shrinkWrap,
          itemCount: totalResults,
          restorationId: restorationId,
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          itemBuilder: (context, index) {
            final page = index ~/ pageSize + 1;
            final indexInPage = index % pageSize;
            final AsyncValue<PaginatedResult<T>> responseAsync =
                itemsProviderBuilder(page);
            return AnimatedSwitcher(
              key: ValueKey('item-$page-$indexInPage'),
              duration: transitionDuration,
              switchInCurve: transitionCurve,
              switchOutCurve: reverseTransitionCurve ?? transitionCurve,
              child: responseAsync.when(
                error: (err, stack) => KeyedSubtree(
                  key: ValueKey('error-$page-$indexInPage-$err'),
                  child: indexInPage == 0
                      ? errorItemBuilder?.call(
                            context,
                            page,
                            indexInPage,
                            err,
                            stack,
                          ) ??
                          _ListTileError<T>(
                            page: page,
                            indexInPage: indexInPage,
                            error: 'Could not load page $page',
                            itemsProviderBuilder: itemsProviderBuilder,
                            invalidateItemPageProvider:
                                invalidateItemPageProvider,
                            refreshItemPageProvider: refreshItemPageProvider,
                          )
                      : const SizedBox.shrink(),
                ),
                loading: () => KeyedSubtree(
                  key: ValueKey('loading-$page-$indexInPage'),
                  child: loadingItemBuilder(context, page, indexInPage),
                ),
                data: (response) {
                  // This condition only happens if a null itemCount is given
                  if (indexInPage >= response.results.length) {
                    return null;
                  }
                  final movie = response.results[indexInPage];
                  return KeyedSubtree.wrap(
                    itemBuilder(context, movie, indexInPage),
                    index,
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

class _ListTileError<T> extends ConsumerStatefulWidget {
  const _ListTileError({
    required this.page,
    required this.indexInPage,
    required this.error,
    required this.itemsProviderBuilder,
    required this.invalidateItemPageProvider,
    required this.refreshItemPageProvider,
    super.key,
  });
  final int page;
  final int indexInPage;
  final String error;
  final AsyncValue<PaginatedResult<T>> Function(int page) itemsProviderBuilder;
  final void Function(int page) invalidateItemPageProvider;
  final Future<PaginatedResult<T>> Function(int page) refreshItemPageProvider;

  @override
  ConsumerState<_ListTileError<T>> createState() => _ListTileErrorState<T>();
}

class _ListTileErrorState<T> extends ConsumerState<_ListTileError<T>> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    // * Only show error on the first item of the page
    return widget.indexInPage == 0
        ? Padding(
            padding: const EdgeInsetsDirectional.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.error),
                ElevatedButton(
                  onPressed: isLoading
                      ? null
                      : () async {
                          widget.invalidateItemPageProvider(widget.page);
                          // wait until the page is loaded again
                          setState(() => isLoading = true);
                          await widget.refreshItemPageProvider(widget.page);
                          setState(() => isLoading = false);
                        },
                  child: isLoading
                      ? const Padding(
                          padding: EdgeInsetsDirectional.all(8.0),
                          child: CircularProgressIndicator(),
                        )
                      : const Text('Retry'),
                ),
              ],
            ),
          )
        : const SizedBox.shrink();
  }
}
