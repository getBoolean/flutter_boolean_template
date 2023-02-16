library app;

import 'package:auth_example/auth/auth.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:localization/localization.dart';
import 'package:models/person.dart';
import 'package:routing/routing.dart';

/// The main app widget at the root of the widget tree.
class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const _ = Person(firstName: 'John', lastName: 'Doe', age: 42);
    final String auth = ref.watch(authProvider);
    debugPrint(auth);

    final router = ref.watch(routerProvider);
    return MaterialApp.router(
      onGenerateTitle: (context) => context.loc.appTitle,
      routerConfig: router,
      restorationScopeId: 'app',
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: FlexThemeData.light(
        scheme: FlexScheme.mandyRed,
        useMaterial3: true,
      ),
      darkTheme:
          FlexThemeData.dark(scheme: FlexScheme.mandyRed, useMaterial3: true),
      themeMode: ThemeMode.system,
    );
  }
}

/// Temporary home page widget.
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              context.loc.timesButtonPressed,
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: context.loc.increment,
        child: const Icon(Icons.add),
      ),
    );
  }
}
