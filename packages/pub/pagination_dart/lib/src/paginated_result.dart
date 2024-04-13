/// Extend this interface to create a paginated response class for your API.
abstract class PaginatedResult<T> {
  List<T> get results;
  int get totalResults;
  int get totalPages;
  int get currentPage;
  int get itemsPerPage;

  factory PaginatedResult.empty() => const _EmptyPaginatedResult();
}

final class _EmptyPaginatedResult<T> implements PaginatedResult<T> {
  const _EmptyPaginatedResult();

  @override
  List<T> get results => [];

  @override
  int get totalResults => 0;

  @override
  int get totalPages => 0;

  @override
  int get currentPage => 0;

  @override
  int get itemsPerPage => 0;
}
