import 'package:flutter/material.dart';

class BookDetailsScreen extends StatefulWidget {
  final int id;
  const BookDetailsScreen({
    super.key,
    this.id = -1,
  });

  @override
  State<BookDetailsScreen> createState() => _BookDetailsScreenState();
}

class _BookDetailsScreenState extends State<BookDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return const ColoredBox(
      color: Colors.blueAccent,
      child: Center(child: Text('Book Details Screen')),
    );
  }
}
