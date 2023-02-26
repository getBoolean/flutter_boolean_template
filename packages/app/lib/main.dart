import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:leak_tracker/leak_tracker.dart';

import 'app.dart';

void main() async {
  // Leak tracking automatically disabled in release mode.
  enableLeakTracking();
  MemoryAllocations.instance
      .addListener((event) => dispatchObjectEvent(event.toMap()));

  runApp(const ProviderScope(child: App()));
}
