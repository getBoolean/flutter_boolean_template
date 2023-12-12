import 'package:flutter/material.dart';
import 'package:flutter_boolean_template/src/routing/router/router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RouterWidget extends ConsumerWidget {
  const RouterWidget({super.key, required this.builder});

  final Widget Function(BuildContext, RouterConfig<Object>?) builder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    return builder(context, router);
  }
}
