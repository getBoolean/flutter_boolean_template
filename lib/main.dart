import 'package:constants/constants.dart';
import 'package:env/env.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boolean_template/app.dart';
import 'package:flutter_boolean_template/src/features/initialization/presentation/app_startup_widget.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // * Register error handlers. For more info, see:
  // * https://docs.flutter.dev/testing/errors
  registerErrorHandlers();
  AppFlavor.initConfig();
  final env = EnvFlavor.instance;
  if (env.usePathUrlStrategy) {
    usePathUrlStrategy();
  }

  runApp(
    ProviderScope(
      child: AppStartupWidget(
        onLoaded: (context) => const App(),
      ),
    ),
  );
}

/// Source: Flutter Foundations course by CodeWithAndrea
void registerErrorHandlers() {
  // * Show some error UI if any uncaught exception happens
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
    debugPrint(details.toString());
  };
  // * Handle errors from the underlying platform/OS
  PlatformDispatcher.instance.onError = (Object error, StackTrace stackTrace) {
    debugPrint(error.toString());

    return true;
  };
  // * Show some error UI when any widget in teh app fails to build
  ErrorWidget.builder = (FlutterErrorDetails details) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('An error occurred'),
          backgroundColor: Colors.red,
        ),
        // Body with the error message and button to restart the app
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 16),
                Text(
                  details.exceptionAsString(),
                  style: const TextStyle(color: Colors.red),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Restart the app to continue.',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  };
}
