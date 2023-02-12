import 'package:convenient_test/convenient_test.dart';
import 'package:flutter/material.dart';
import 'package:models/models.dart';

/// The main app widget at the root of the widget tree.
class App extends StatelessWidget {
  /// Creates the main app widget.
  const App({super.key});

  /// The navigator key for the entire app, used by `convenient_test`
  static final navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    const person = Person(firstName: 'John', lastName: 'Doe', age: 42);

    return ConvenientTestWrapperWidget(
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        navigatorKey: App.navigatorKey,
        home: MyHomePage(title: '${person.firstName} ${person.lastName}'),
      ),
    );
  }
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
