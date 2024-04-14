import 'dart:async';

import 'package:riverpod/riverpod.dart';

extension KeepAliveDurationExtension<T> on AutoDisposeRef<T> {
  /// Keeps a [Ref] alive for a given [duration].
  ///
  /// Any inflight requests will need to be cancelled separately during [onDispose].
  void keepAliveDuration([Duration duration = const Duration(seconds: 30)]) {
    // When a provider is no-longer used, keep it in the cache for some time
    final link = keepAlive();
    Timer? timer;

    onDispose(() {
      timer?.cancel();
    });

    onCancel(() {
      timer = Timer(duration, link.close);
    });

    onResume(() {
      timer?.cancel();
    });
  }
}
