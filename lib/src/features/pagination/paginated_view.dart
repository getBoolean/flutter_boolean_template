import 'package:flutter/widgets.dart';
import 'package:flutter_boolean_template/src/features/pagination/paginated_response.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PaginatedView<T> extends ConsumerWidget {
  const PaginatedView({
    required this.itemsProviderBuilder,
    required this.itemBuilder,
    required this.loadingItemBuilder,
    required this.errorItemBuilder,
    this.pageSize = 20,
    this.shrinkWrap = false,
    super.key,
  });

  /// Watch your API and return a list of items for a page.
  ///
  /// If not using riverpod for the API call, you need to handle
  /// caching yourself as this is called for every index in the page.
  final AsyncValue<PaginatedResponse<T>> Function(int page)
      itemsProviderBuilder;
  final int pageSize;
  final Widget Function(BuildContext context, T item, int indexInPage)
      itemBuilder;
  final Widget Function(BuildContext context, int page, int indexInPage)
      loadingItemBuilder;
  final Widget Function(
    BuildContext context,
    int page,
    int indexInPage, [
    Object error,
    StackTrace stack,
  ]) errorItemBuilder;
  final bool shrinkWrap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final responseAsync = itemsProviderBuilder(1);
    final totalResults = responseAsync.valueOrNull?.totalResults;
    return ListView.builder(
      shrinkWrap: shrinkWrap,
      itemCount: totalResults,
      itemBuilder: (context, index) {
        final page = index ~/ pageSize + 1;
        final indexInPage = index % pageSize;
        final AsyncValue<PaginatedResponse<T>> responseAsync =
            itemsProviderBuilder(page);
        return responseAsync.when(
          error: (err, stack) => indexInPage == 0
              ? errorItemBuilder(context, page, indexInPage, err, stack)
              : const SizedBox.shrink(),
          loading: () => loadingItemBuilder(context, page, indexInPage),
          data: (response) {
            // This condition only happens if a null itemCount is given
            if (indexInPage >= response.results.length) {
              return null;
            }
            final movie = response.results[indexInPage];
            return itemBuilder(context, movie, indexInPage);
          },
        );
      },
    );
  }
}
