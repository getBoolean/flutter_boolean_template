/// Extend this interface to create a paginated response class for your API.
abstract interface class PaginatedResponse<T> {
  List<T> get results;
  int get totalResults;
  int get totalPages;
}
