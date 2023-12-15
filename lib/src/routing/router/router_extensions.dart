import 'package:collection/collection.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

extension BuildContextGoBack on BuildContext {
  Uri get currentLocation => GoRouter.of(this).location;

  bool canGoBack() {
    return GoRouter.of(this).canGoBack();
  }

  bool goBack({bool stripQueryParameters = true}) {
    return GoRouter.of(this).goBack(stripQueryParameters: stripQueryParameters);
  }
}

extension GoRouterExtension on GoRouter {
  Uri get location => routerDelegate.location;

  bool canGoBack() {
    return routerDelegate.location.pathSegments.length > 1;
  }

  bool goBack({bool stripQueryParameters = true}) {
    if (!canPop()) {
      return false;
    }

    final location = routerDelegate.location;
    final length = routerDelegate.location.pathSegments.length;
    final pathSegments = location.pathSegments.slice(0, length - 1).toList();
    final newLoc = location.replace(path: '/${pathSegments.join(' / ')}');
    go(stripQueryParameters ? newLoc.path : newLoc.toString());

    return true;
  }
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
