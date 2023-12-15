import 'package:flutter_boolean_template/src/routing/models/location_history.dart';
import 'package:flutter_boolean_template/src/routing/router/location_notifier.dart';
import 'package:flutter_boolean_template/src/routing/router/router.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Source: @cgestes https://github.com/flutter/flutter/issues/115353#issuecomment-1675808675
final locationHistoryProvider =
    NotifierProvider<LocationHistoryNotifier, LocationHistory>(
        LocationHistoryNotifier.new);

/// Source: @cgestes https://github.com/flutter/flutter/issues/115353#issuecomment-1675808675
class LocationHistoryNotifier extends Notifier<LocationHistory> {
  @override
  LocationHistory build() {
    ref.listen(locationProvider, (previous, next) {
      if (state.history.isNotEmpty && state.history.last == next) {
        return;
      }
      final history = [...state.history];
      final popped = [...state.popped];

      history.add(next);
      if (popped.isNotEmpty && popped.last == next) {
        popped.removeLast();
      } else {
        popped.clear();
      }
      state = state.copyWith(history: history, popped: popped);
    }, fireImmediately: true);
    return const LocationHistory();
  }

  /// Whether it is possible to [goBack],
  /// i.e. there is more than 1 entry in [state.history].
  bool canGoBack() {
    return state.hasBackward();
  }

  /// Whether it is possible to [goForward],
  /// i.e. [state.popped] is not empty.
  bool canGoForward() {
    return state.hasForward();
  }

  /// Goes to previous entry in history.
  /// and **removes** the last entry from history.
  ///
  /// If there is no previous entry, does nothing.
  ///
  /// Returns the success, whether [GoRouter.go] was executed.
  bool goBack() {
    if (!canGoBack()) {
      return false;
    }
    final GoRouter router = ref.read(routerProvider);
    final history = [...state.history];
    final popped = [...state.popped, history.removeLast()];
    final newLoc = history.last;
    state = state.copyWith(history: history, popped: popped);
    ref.read(routerProvider).go(newLoc);

    return true;
  }

  void goForward() {
    if (!canGoForward()) {
      return;
    }
    final history = [...state.history];
    final popped = [...state.popped];

    final newLoc = popped.removeLast();
    history.add(newLoc);
    state = state.copyWith(history: history, popped: popped);
    ref.read(routerProvider).go(newLoc);
  }
}
