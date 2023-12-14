import 'package:flutter/material.dart';

class BookDetailsRootScreen extends StatefulWidget {
  const BookDetailsRootScreen({
    super.key,
    this.id,
  });
  final String? id;

  @override
  State<BookDetailsRootScreen> createState() => _BookDetailsRootScreenState();
}

class _BookDetailsRootScreenState extends State<BookDetailsRootScreen> {
  @override
  Widget build(BuildContext context) {
    return const ColoredBox(
      color: Colors.blueAccent,
      child: Center(child: Text('Book Details Screen')),
    );
  }
}
