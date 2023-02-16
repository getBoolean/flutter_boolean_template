import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:routing/src/routes.dart';

part 'router_provider.g.dart';

// TODO: Replace GoRouterBuilder with GoRouter or Beamer

@riverpod
RouterConfig<Object> router(RouterRef ref) {
  return GoRouter(routes: $appRoutes);
}
