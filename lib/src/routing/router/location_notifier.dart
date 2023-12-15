import 'package:flutter_boolean_template/src/routing/router/router.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final locationProvider =
    NotifierProvider<LocationNotifier, String>(LocationNotifier.new);

/// Source: @cgestes https://github.com/flutter/flutter/issues/115353#issuecomment-1675808675
class LocationNotifier extends Notifier<String> {
  @override
  String build() {
    final router = ref.read(routerProvider);
    router.routeInformationProvider
        .addListener(onRouteInformationProviderChange);
    router.routerDelegate.addListener(onRouterDelegateChange);
    ref.onDispose(() {
      router.routeInformationProvider
          .removeListener(onRouteInformationProviderChange);
      router.routerDelegate.removeListener(onRouterDelegateChange);
    });
    return router.location;
  }

  void onRouteInformationProviderChange() {
    final routeInformationProvider =
        ref.read(routerProvider).routeInformationProvider;
    print('onRouteInformationProviderChange');
    state = routeInformationProvider.value.uri.path;
  }

  void onRouterDelegateChange() {
    final routerDelegate = ref.read(routerProvider).routerDelegate;
    print('onRouterDelegateChange');
    state = routerDelegate.location;
  }
}

extension GoRouterExtension on GoRouter {
  /// Source: GoRouter 9.0.0 Migration Guide
  ///
  /// https://docs.google.com/document/d/16plvWc9ablQsUs7w6bWDpTZ7PwMP4YUhV-qMQ3iljE0/edit
  String get location => routerDelegate.location;
}

extension GoRouterDelegateExtension on GoRouterDelegate {
  /// Source: GoRouter 9.0.0 Migration Guide
  ///
  /// https://docs.google.com/document/d/16plvWc9ablQsUs7w6bWDpTZ7PwMP4YUhV-qMQ3iljE0/edit
  String get location {
    final RouteMatch lastMatch = currentConfiguration.last;
    final RouteMatchList matchList = lastMatch is ImperativeRouteMatch
        ? lastMatch.matches
        : currentConfiguration;
    return matchList.uri.toString();
  }
}
