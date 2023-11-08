import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boolean_template/src/routing/ui/widgets/auto_app_bar.dart';

@RoutePage(name: 'BookDetailsRoute')
class BookDetailsScreen extends StatelessWidget {
  final int id;
  const BookDetailsScreen({
    super.key,
    @pathParam this.id = -1,
  });

  @override
  Widget build(BuildContext context) {
    // return const ColoredBox(color: Colors.blueAccent);
    return const Scaffold(
      appBar: AutoAppBar(),
      backgroundColor: Colors.blueAccent,
      body: Center(child: Text('Book Details Screen')),
    );
  }
}
