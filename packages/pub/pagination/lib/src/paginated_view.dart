import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pagination_dart/pagination_dart.dart';
import 'package:super_sliver_list/super_sliver_list.dart';

final _pageBucket = PageStorageBucket();

class PaginatedView<T> extends ConsumerStatefulWidget {
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
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PaginatedViewState<T>();
}

class _PaginatedViewState<T> extends ConsumerState<PaginatedView<T>> {
  late ScrollController _scrollController;
  @override
  void initState() {
    _scrollController = widget.controller ?? ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    if (widget.controller == null) {
      _scrollController.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    final responseAsync = ref.watch(widget.pageItemsProvider(1));
    final totalResults = responseAsync.valueOrNull?.totalResults;
    return PageStorage(
      bucket: _pageBucket,
      child: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(widget.provider);
          try {
            await ref.watch(widget.pageItemsProvider(1).future);
          } catch (e) {
            // fail silently as the provider error state is handled inside the ListView
          }
        },
        child: Scrollbar(
          controller: _scrollController,
          child: SuperListView.builder(
            key: PageStorageKey(widget.restorationId),
            scrollDirection: widget.scrollDirection,
            reverse: widget.reverse,
            controller: _scrollController,
            primary: widget.primary,
            physics: widget.physics,
            shrinkWrap: widget.shrinkWrap,
            cacheExtent: widget.cacheExtent,
            dragStartBehavior: widget.dragStartBehavior,
            keyboardDismissBehavior: widget.keyboardDismissBehavior,
            restorationId: widget.restorationId,
            clipBehavior: widget.clipBehavior,
            padding: widget.padding,
            listController: widget.listController,
            extentEstimation: widget.extentEstimation,
            extentPrecalculationPolicy: widget.extentPrecalculationPolicy,
            delayPopulatingCacheArea: widget.delayPopulatingCacheArea,
            itemCount: totalResults,
            findChildIndexCallback: widget.findChildIndexCallback,
            addAutomaticKeepAlives: widget.addAutomaticKeepAlives,
            addRepaintBoundaries: widget.addRepaintBoundaries,
            addSemanticIndexes: widget.addSemanticIndexes,
            itemBuilder: (context, index) {
              final page = index ~/ widget.pageSize + 1;
              final indexInPage = index % widget.pageSize;
              final AsyncValue<PaginatedResult<T>> responseAsync =
                  ref.watch(widget.pageItemsProvider(page));
              if (indexInPage >=
                  (responseAsync.valueOrNull?.results.length ?? 20)) {
                return null;
              }
              return AnimatedSwitcher(
                duration: widget.transitionDuration,
                switchInCurve: widget.transitionCurve,
                switchOutCurve:
                    widget.reverseTransitionCurve ?? widget.transitionCurve,
                child: responseAsync.when(
                  error: (err, stack) => indexInPage == 0
                      ? widget.errorItemBuilder?.call(
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
                            itemsProviderBuilder: widget.pageItemsProvider,
                          )
                      : const SizedBox.shrink(),
                  loading: () =>
                      widget.loadingItemBuilder(context, page, indexInPage),
                  data: (response) {
                    // This condition only happens if a null itemCount is given
                    if (indexInPage >= response.results.length) {
                      return null;
                    }
                    final movie = response.results[indexInPage];
                    return KeyedSubtree.wrap(
                      widget.itemBuilder(context, movie, indexInPage),
                      index,
                    );
                  },
                ),
              );
            },
          ),
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
