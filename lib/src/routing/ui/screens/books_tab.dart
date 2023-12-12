import 'package:flutter/material.dart';
import 'package:log/log.dart';

class BooksScreen extends StatefulWidget {
  const BooksScreen({super.key});

  @override
  State<BooksScreen> createState() => _BooksScreenState();
}

class _BooksScreenState extends State<BooksScreen> {
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
