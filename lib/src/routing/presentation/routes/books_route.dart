import 'package:flutter/material.dart';
import 'package:flutter_boolean_template/src/features/books/presentation/books_screen.dart';
import 'package:log/log.dart';

class BooksRoute extends StatefulWidget {
  const BooksRoute({super.key});

  @override
  State<BooksRoute> createState() => _BooksRouteState();
}

class _BooksRouteState extends State<BooksRoute> {
  final log = Logger('BooksScreen');

  @override
  Widget build(BuildContext context) {
    return const BooksScreen();
  }
}
