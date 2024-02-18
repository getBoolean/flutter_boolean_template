import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:constants/constants.dart';
import 'package:flutter/material.dart';

/// Shows the current connectivity status if the user is offline
/// and the app does not have any data to show.
class ConnectivityBuilder extends StatefulWidget {
  const ConnectivityBuilder({
    required this.builder,
    this.child,
    super.key,
  });

  /// The widget to display if the user is online or the app has data to show.
  final Widget? child;

  final Widget Function(
    BuildContext context,
    ConnectivityResult? connectivity,
    Widget? child,
  ) builder;

  @override
  State<ConnectivityBuilder> createState() => _ConnectivityBuilderState();
}

class _ConnectivityBuilderState extends State<ConnectivityBuilder> {
  ConnectivityResult? _connectivityResult;
  late final StreamSubscription<ConnectivityResult> _connectivitySubscription;
  final _connectivity = Connectivity();

  @override
  void initState() {
    super.initState();
    _connectivity.checkConnectivity().then(_updateConnectionStatus);
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectivityResult = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, _connectivityResult, widget.child);
  }
}

class NoConnectivityScreen extends StatelessWidget {
  const NoConnectivityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.signal_wifi_off, size: 128),
          gap24,
          Text(
            'No internet connection',
            style: TextStyle(fontSize: theme.textTheme.titleLarge?.fontSize),
          ),
        ],
      ),
    );
  }
}
