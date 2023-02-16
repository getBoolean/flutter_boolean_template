import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'app.dart';

void main() {
  runApp(const ProviderScope(child: App()));
}
