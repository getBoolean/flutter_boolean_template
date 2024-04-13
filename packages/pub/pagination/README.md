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

A simple way to implement paginated results using riverpod providers

## Features

### Paginated View

A `StatelessWidget` that can be used to display a paginated list of items.

```dart
PaginatedView(
  itemsProviderBuilder: (int page) => ref.watch(itemsProviderBuilder(
    page: page,
  )),
  invalidateItemsProvider: () => ref.invalidate(itemsProviderBuilder),
  invalidateItemPageProvider: (int page) =>
      ref.invalidate(itemsProviderBuilder(
    page: page,
  )),
  refreshItemPageProvider: (int page) async =>
      await ref.watch(itemsProviderBuilder(
    page: page,
  )).future,
  itemBuilder: (BuildContext context, T item, int indexInPage) => ...,
  loadingItemBuilder: (BuildContext context, int page, int indexInPage) => ...,
  errorItemBuilder: (BuildContext context, int page, int indexInPage, Object error, StackTrace stack) => ...,
  shrinkWrap: true,
  transitionDuration: const Duration(milliseconds: 650),
  transitionCurve: Curves.easeInOut,
  reverseTransitionCurve: null,
  restorationId: null,
)
```

### Paginated Result

Implement a `PaginatedResult` for your API response. This result can then be used
anywhere a `PaginatedResult` is expected, such as with `PaginatedView`.

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
