import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boolean_template/src/routing/router/app_router.dart';
import 'package:flutter_boolean_template/src/routing/ui/widgets/sliver_auto_app_bar.dart';

@RoutePage()
class BooksScreen extends StatelessWidget {
  const BooksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [const SliverAutoAppBar()];
        },
        body: Center(
          child: FilledButton(
            onPressed: () {
              context.navigateTo(const BookDetailsRoute());
            },
            child: const Text('Push Details'),
          ),
        ),
      ),
    );
  }
}
