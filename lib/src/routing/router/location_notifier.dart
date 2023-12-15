import 'package:collection/collection.dart';
import 'package:flutter_boolean_template/src/routing/router/router.dart';
import 'package:go_router/go_router.dart';
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
    return router.location;
  }

  void onRouterDelegateChange() {
    final routerDelegate = ref.read(routerProvider).routerDelegate;
    state = routerDelegate.location;
  }

  bool canPop() {
    return state.pathSegments.length > 1;
  }

  bool pop() {
    if (!canPop()) {
      return false;
    }
    final length = state.pathSegments.length;
    final pathSegments = state.pathSegments.slice(0, length - 1).toList();
    final newLoc = state.replace(path: '/${pathSegments.join(' / ')}');
    ref.read(routerProvider).go(newLoc.path);

    return true;
  }
}

extension GoRouterExtension on GoRouter {
  /// Source: GoRouter 9.0.0 Migration Guide
  ///
  /// https://docs.google.com/document/d/16plvWc9ablQsUs7w6bWDpTZ7PwMP4YUhV-qMQ3iljE0/edit
  Uri get location => routerDelegate.location;
}

extension GoRouterDelegateExtension on GoRouterDelegate {
  /// Source: GoRouter 9.0.0 Migration Guide
  ///
  /// https://docs.google.com/document/d/16plvWc9ablQsUs7w6bWDpTZ7PwMP4YUhV-qMQ3iljE0/edit
  Uri get location {
    final RouteMatch lastMatch = currentConfiguration.last;
    final RouteMatchList matchList = lastMatch is ImperativeRouteMatch
        ? lastMatch.matches
        : currentConfiguration;
    return matchList.uri;
  }
}
