import 'package:convenient_test/convenient_test.dart';
import 'package:features/auth/auth.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:models/models.dart';

/// The main app widget at the root of the widget tree.
class App extends ConsumerWidget {
  const App({super.key});

  /// The navigator key for the entire app, used by `convenient_test`
  static final navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const person = Person(firstName: 'John', lastName: 'Doe', age: 42);
    final String auth = ref.watch(authProvider);
    debugPrint(auth);

    return ConvenientTestWrapperWidget(
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: FlexThemeData.light(scheme: FlexScheme.mandyRed, useMaterial3: true),
        darkTheme: FlexThemeData.dark(scheme: FlexScheme.mandyRed, useMaterial3: true),
        themeMode: ThemeMode.system,
        navigatorKey: App.navigatorKey,
        home: MyHomePage(title: '${person.firstName} ${person.lastName}'),
      ),
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
            const Text(
              'You have pushed the button this many times:',
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
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
