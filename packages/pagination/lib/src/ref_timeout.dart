import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Keeps a [Ref] alive for a given [duration].
///
/// Any inflight requests will need to be cancelled separately.
void applyRefTimeout<T>(AutoDisposeRef<T> ref, Duration duration) {
  // When a page is no-longer used, keep it in the cache for some time
  final link = ref.keepAlive();
  Timer? timer;

  ref.onDispose(() {
    timer?.cancel();
  });

  ref.onCancel(() {
    timer = Timer(const Duration(seconds: 30), link.close);
  });

  ref.onResume(() {
    timer?.cancel();
  });
}
