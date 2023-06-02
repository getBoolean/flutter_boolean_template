import 'package:assets/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logs/logs.dart';

import 'router/app_router.dart';
import 'ui/app_scaffold.dart';
// Source: https://codewithandrea.com/articles/flutter-bottom-navigation-bar-nested-routes-gorouter-beamer/

// Keep in mind that the navigation position of each page won't be preserved until StatefulShellRoute from
// https://github.com/flutter/packages/pull/2650 is merged
final routerProvider = Provider.autoDispose<AppRouter>((ref) {
  final log = ref.watch(logProvider('routerProvider'));
  return AppRouter(log: log);
});
