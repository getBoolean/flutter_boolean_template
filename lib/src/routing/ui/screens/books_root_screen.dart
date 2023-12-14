import 'package:flutter/material.dart';
import 'package:log/log.dart';

class BooksRootScreen extends StatefulWidget {
  const BooksRootScreen({super.key});

  @override
  State<BooksRootScreen> createState() => _BooksRootScreenState();
}

class _BooksRootScreenState extends State<BooksRootScreen> {
  final log = Logger('BooksScreen');

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.blue,
      child: Center(
        child: FilledButton(
          onPressed: () async {
            // await goTo(BookDetailsRoute(id: 1));
          },
          child: const Text('Push Details'),
        ),
      ),
    );
  }
}
