import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class BookDetailsScreen extends StatelessWidget {
  const BookDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // return const ColoredBox(color: Colors.blueAccent);
    return Scaffold(
      appBar: AppBar(
        title: Text(context.topRoute.name),
        leading: const AutoLeadingButton(),
      ),
      backgroundColor: Colors.blueAccent,
      body: const Center(child: Text('Book Details Screen')),
    );
  }
}
