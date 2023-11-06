import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boolean_template/src/routing/ui/widgets/auto_app_bar.dart';

@RoutePage()
class BookDetailsScreen extends StatelessWidget {
  const BookDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // return const ColoredBox(color: Colors.blueAccent);
    return Scaffold(
      appBar: AutoAppBar(
        title: Text(context.topRoute.name),
      ),
      backgroundColor: Colors.blueAccent,
      body: const Center(child: Text('Book Details Screen')),
    );
  }
}