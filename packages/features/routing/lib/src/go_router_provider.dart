import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:routing/src/routes.dart';

part 'go_router_provider.g.dart';

@riverpod
GoRouter goRouter(GoRouterRef ref) {
  return GoRouter(routes: $appRoutes);
}
