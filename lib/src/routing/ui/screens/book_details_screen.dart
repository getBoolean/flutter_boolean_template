import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class BookDetailsScreen extends StatelessWidget {
  const BookDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // return const ColoredBox(color: Colors.blueAccent);
    return const Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Center(child: Text('Book Details Screen')),
    );
  }
}
