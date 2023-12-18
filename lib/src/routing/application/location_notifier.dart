import 'package:flutter_boolean_template/src/routing/router/router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final locationProvider =
    NotifierProvider<LocationNotifier, Uri>(LocationNotifier.new);

/// Source: @cgestes https://github.com/flutter/flutter/issues/115353#issuecomment-1675808675
class LocationNotifier extends Notifier<Uri> {
  @override
  Uri build() {
    final router = ref.read(routerProvider);
    router.routerDelegate.addListener(onRouterDelegateChange);
    ref.onDispose(() {
      router.routerDelegate.removeListener(onRouterDelegateChange);
    });
    return router.locationUri;
  }

  void onRouterDelegateChange() {
    final routerDelegate = ref.read(routerProvider).routerDelegate;
    state = routerDelegate.locationUri;
  }
}
