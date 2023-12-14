import 'package:flutter/material.dart';

class BookDetailsRootScreen extends StatefulWidget {
  final int id;
  const BookDetailsRootScreen({
    super.key,
    this.id = -1,
  });

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
