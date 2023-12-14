import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:log/log.dart';

class BooksRootScreen extends StatefulWidget {
  const BooksRootScreen({super.key, this.id});

  final String? id;

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
        child: widget.id == null
            ? FilledButton(
                onPressed: () async {
                  context.go('/books/details?id=${widget.id ?? "1"}');
                },
                child: const Text('Push Details'),
              )
            : Text('Book ${widget.id}', style: context.textStyles.titleLarge),
      ),
    );
  }
}
