import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pagination_dart/pagination_dart.dart';
import 'package:super_sliver_list/super_sliver_list.dart';

final _pageBucket = PageStorageBucket();

class PaginatedView<T> extends ConsumerWidget {
  const PaginatedView({
    required this.pageItemsProvider,
    required this.provider,
    required this.itemBuilder,
    required this.loadingItemBuilder,
    this.errorItemBuilder,
    this.pageSize = 20,
    this.transitionDuration = const Duration(milliseconds: 650),
    this.transitionCurve = Curves.easeInOut,
    this.reverseTransitionCurve,
    this.restorationId,
    this.controller,
    this.scrollDirection = Axis.vertical,
    this.reverse = false,
    this.shrinkWrap = false,
    this.primary,
    this.physics,
    this.padding,
    this.cacheExtent,
    this.dragStartBehavior = DragStartBehavior.start,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.onDrag,
    this.clipBehavior = Clip.hardEdge,
    this.listController,
    this.extentEstimation,
    this.extentPrecalculationPolicy,
    this.delayPopulatingCacheArea = false,
    this.findChildIndexCallback,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
    super.key,
  });

  /// Watch your API and return a list of items for a page.
  ///
  /// If not using riverpod for the API call, you need to handle
  /// caching yourself as this is called for every index in the page.
  final AutoDisposeFutureProvider<PaginatedResult<T>> Function(int page)
      pageItemsProvider;
  final ProviderOrFamily provider;
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
  final Duration transitionDuration;
  final Curve transitionCurve;
  final Curve? reverseTransitionCurve;

  // ScrollView
  final Axis scrollDirection;
  final bool reverse;
  final ScrollController? controller;
  final bool? primary;
  final ScrollPhysics? physics;
  final bool shrinkWrap;
  final double? cacheExtent;
  final DragStartBehavior dragStartBehavior;
  final ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;
  final String? restorationId;
  final Clip clipBehavior;

  // BoxScrollView
  final EdgeInsetsGeometry? padding;

  // ListView
  final ListController? listController;
  final ExtentEstimationProvider? extentEstimation;
  final ExtentPrecalculationPolicy? extentPrecalculationPolicy;
  final bool delayPopulatingCacheArea;
  final ChildIndexGetter? findChildIndexCallback;
  final bool addAutomaticKeepAlives;
  final bool addRepaintBoundaries;
  final bool addSemanticIndexes;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final responseAsync = ref.watch(pageItemsProvider(1));
    final totalResults = responseAsync.valueOrNull?.totalResults;
    return PageStorage(
      bucket: _pageBucket,
      child: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(provider);
          try {
            await ref.watch(pageItemsProvider(1).future);
          } catch (e) {
            // fail silently as the provider error state is handled inside the ListView
          }
        },
        child: SuperListView.builder(
          key: PageStorageKey(restorationId),
          scrollDirection: scrollDirection,
          reverse: reverse,
          controller: controller,
          primary: primary,
          physics: physics,
          shrinkWrap: shrinkWrap,
          cacheExtent: cacheExtent,
          dragStartBehavior: dragStartBehavior,
          keyboardDismissBehavior: keyboardDismissBehavior,
          restorationId: restorationId,
          clipBehavior: clipBehavior,
          padding: padding,
          listController: listController,
          extentEstimation: extentEstimation,
          extentPrecalculationPolicy: extentPrecalculationPolicy,
          delayPopulatingCacheArea: delayPopulatingCacheArea,
          itemCount: totalResults,
          findChildIndexCallback: findChildIndexCallback,
          addAutomaticKeepAlives: addAutomaticKeepAlives,
          addRepaintBoundaries: addRepaintBoundaries,
          addSemanticIndexes: addSemanticIndexes,
          itemBuilder: (context, index) {
            final page = index ~/ pageSize + 1;
            final indexInPage = index % pageSize;
            final AsyncValue<PaginatedResult<T>> responseAsync =
                ref.watch(pageItemsProvider(page));
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
                            itemsProviderBuilder: pageItemsProvider,
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
    super.key,
  });
  final int page;
  final int indexInPage;
  final String error;
  final AutoDisposeFutureProvider<PaginatedResult<T>> Function(int page)
      itemsProviderBuilder;

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
                          ref.invalidate(
                              widget.itemsProviderBuilder(widget.page));
                          // wait until the page is loaded again
                          setState(() => isLoading = true);
                          await ref.watch(
                              widget.itemsProviderBuilder(widget.page).future);
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
