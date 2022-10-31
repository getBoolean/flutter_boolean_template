import 'package:convenient_test/convenient_test.dart';
import 'package:flutter/material.dart';

/// The main app widget at the root of the widget tree.
class App extends StatelessWidget {
  /// Creates the main app widget.
  const App({super.key});

  /// The navigator key for the entire app, used by `convenient_test`
  static final navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) => ConvenientTestWrapperWidget(
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          navigatorKey: App.navigatorKey,
          home: const MyHomePage(title: 'Flutter Demo Home Page'),
        ),
      );
}

/// Temporary home page widget.
class MyHomePage extends StatefulWidget {
  /// Creates the temporary home page widget.
  const MyHomePage({super.key, required this.title});

  /// The title of the page.
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
  Widget build(BuildContext context) => Scaffold(
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
                style: Theme.of(context).textTheme.headline4,
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
