import 'package:collection/collection.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

extension BuildContextGoBack on BuildContext {
  Uri get currentLocation => GoRouter.of(this).locationUri;

  bool canGoBack() {
    return GoRouter.of(this).canGoBack();
  }

  bool goBack({bool stripQueryParameters = true}) {
    return GoRouter.of(this).goBack(stripQueryParameters: stripQueryParameters);
  }
}

extension GoRouterExtension on GoRouter {
  Uri get locationUri => routerDelegate.locationUri;

  bool canGoBack() {
    final location = routerDelegate.locationUri;
    return location.pathSegments.length > 1;
  }

  bool stripQueryParameters() {
    final location = routerDelegate.locationUri;
    final queryParameters = location.queryParameters;
    if (queryParameters.isEmpty) {
      return false;
    }

    final pathSegments = location.pathSegments;
    final newLoc = location.replace(path: '/${pathSegments.join(' / ')}');
    go(newLoc.path);

    return true;
  }

  bool goBack({bool stripQueryParameters = true}) {
    if (!canGoBack()) {
      return false;
    }

    final location = routerDelegate.locationUri;
    final length = routerDelegate.locationUri.pathSegments.length;
    final pathSegments = location.pathSegments.slice(0, length - 1).toList();
    final newLoc = location.replace(path: '/${pathSegments.join(' / ')}');
    go(stripQueryParameters ? newLoc.path : newLoc.toString());

    return true;
  }
}

extension GoRouterStateExtension on GoRouterState {
  bool get isRootRoute => matchedLocation.split('/').length <= 2;
}

extension GoRouterDelegateExtension on GoRouterDelegate {
  /// Source: GoRouter 9.0.0 Migration Guide
  ///
  /// https://docs.google.com/document/d/16plvWc9ablQsUs7w6bWDpTZ7PwMP4YUhV-qMQ3iljE0/edit
  Uri get locationUri {
    return matchList.uri;
  }

  RouteMatchList get matchList {
    final RouteMatch lastMatch = currentConfiguration.last;
    return lastMatch is ImperativeRouteMatch
        ? lastMatch.matches
        : currentConfiguration;
  }
}
