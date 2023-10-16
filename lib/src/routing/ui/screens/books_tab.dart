import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boolean_template/src/routing/router/app_router.dart';

@RoutePage()
class BooksScreen extends StatelessWidget {
  const BooksScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Books'),
        leading: const AutoLeadingButton(),
      ),
      backgroundColor: Colors.blue,
      body: Center(
        child: FilledButton(
          onPressed: () {
            context.pushRoute(const BookDetailsRoute());
          },
          child: const Text('Push Details'),
        ),
      ),
    );
  }
}
