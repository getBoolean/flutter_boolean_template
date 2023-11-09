import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boolean_template/src/routing/router/app_router.dart';
import 'package:flutter_boolean_template/src/routing/ui/widgets/auto_update_title_state_mixin.dart';
import 'package:log/log.dart';

@RoutePage<String>()
class BooksScreen extends StatefulWidget {
  const BooksScreen({super.key});

  @override
  State<BooksScreen> createState() => _BooksScreenState();
}

class _BooksScreenState extends State<BooksScreen>
    with AutoUpdateTitleStateMixin<BooksScreen> {
  final log = Logger('BooksScreen');

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.blue,
      child: Center(
        child: FilledButton(
          onPressed: () async {
            await goTo(context, BookDetailsRoute(id: 1));
          },
          child: const Text('Push Details'),
        ),
      ),
    );
  }
}
