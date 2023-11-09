import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boolean_template/src/routing/ui/widgets/auto_adaptive_router_scaffold.dart';

/// A mixin that automatically updates the title of the app bar.
///
/// This is required for [NavigationType.drawer] and [NavigationType.top]
/// to get the correct title.
mixin AutoUpdateTitleStateMixin<T extends StatefulWidget> on State<T>
    implements AutoRouteAware {
  AutoRouteObserver? _observer;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // RouterScope exposes the list of provided observers
    // including inherited observers
    _observer =
        RouterScope.of(context).firstObserverOfType<AutoRouteObserver>();
    if (_observer != null) {
      // we subscribe to the observer by passing our
      // AutoRouteAware state and the scoped routeData
      _observer!.subscribe(this, context.routeData);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _observer?.unsubscribe(this);
  }

  @override
  void didPush() {
    context
        .findAncestorStateOfType<AutoAdaptiveRouterScaffoldState>()
        ?.setAppBarTitle(context);
  }

  @override
  void didPopNext() {
    context
        .findAncestorStateOfType<AutoAdaptiveRouterScaffoldState>()
        ?.setAppBarTitle(context);
  }

  @override
  void didPop() {}

  @override
  void didPushNext() {}

  @override
  void didChangeTabRoute(TabPageRoute previousRoute) {}

  @override
  void didInitTabRoute(TabPageRoute? previousRoute) {}
}
