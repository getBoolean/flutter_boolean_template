import 'dart:async';

import 'package:riverpod/riverpod.dart';

/// Keeps a [Ref] alive for a given [duration].
///
/// Any inflight requests will need to be cancelled separately.
void applyRefTimeout<T>(
  AutoDisposeRef<T> ref, [
  Duration duration = const Duration(seconds: 30),
]) {
  // When a provider is no-longer used, keep it in the cache for some time
  final link = ref.keepAlive();
  Timer? timer;

  ref.onDispose(() {
    timer?.cancel();
  });

  ref.onCancel(() {
    timer = Timer(duration, link.close);
  });

  ref.onResume(() {
    timer?.cancel();
  });
}
