import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boolean_template/src/features/connectivity/presentation/connectivity_builder.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class OfflineWarningBanner extends ConsumerWidget {
  const OfflineWarningBanner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return ConnectivityBuilder(
      builder: (context, connectivity, child) =>
          connectivity != ConnectivityResult.none
              ? const SizedBox.shrink()
              : child ?? const SizedBox.shrink(),
      child: ColoredBox(
        color: theme.colorScheme.onError,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Text(
              'No internet connection',
              style: TextStyle(color: theme.colorScheme.error),
            ),
          ),
        ),
      ),
    );
  }
}
