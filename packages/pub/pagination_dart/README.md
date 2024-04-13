<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages). 
-->

A simple way to implement paginated results in Dart applications, see also
[pagination](/packages/pub/pagination/README.md).

## Features

### Paginated Result

Implement a `PaginatedResult` for your API response. This result can then be used
anywhere a `PaginatedResult` is expected, such as with [PaginatedView](/packages/pub/pagination/lib/src/paginated_view.dart).

```dart
@MappableClass()
class MyPaginatedResult<T> with MyPaginatedResultMappable<T>
    implements PaginatedResult<T> {
  const MyPaginatedResult({
    required this.results,
    this.itemsPerPage = 0,
    this.totalResults = 0,
    this.totalPages = 0,
    this.currentPage = 0,
  });

  @override
  final List<T> results;
  @override
  final int totalResults;
  @override
  final int totalPages;
  @override
  final int currentPage;
  @override
  final int itemsPerPage;

  static const fromMap = MyPaginatedResultMapper.fromMap;
  static const fromJson = MyPaginatedResultMapper.fromJson;
}
```

### Keep Alive Duration

Keeps an `autoDispose Provider` alive for a given `Duration` even if
the provider is no longer used.

```dart
keepAliveDuration<T>(
  AutoDisposeRef<T> ref, [
  Duration duration = const Duration(seconds: 30),
])
```

## Resources

- [Andrea's Pagination article](https://codewithandrea.com/articles/flutter-riverpod-pagination/)
