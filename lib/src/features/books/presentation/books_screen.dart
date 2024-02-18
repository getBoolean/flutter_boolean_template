import 'package:flutter/material.dart';
import 'package:flutter_boolean_template/src/features/connectivity/presentation/offline_warning_widget.dart';
import 'package:flutter_boolean_template/src/routing/router/router.dart';
import 'package:go_router/go_router.dart';

class BooksScreen extends StatelessWidget {
  const BooksScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Add a new book',
        child: const Icon(Icons.add),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const OfflineWarningBanner(),
          Expanded(
            child: ColoredBox(
              color: Colors.blue,
              child: Center(
                child: FilledButton(
                  key: const ValueKey('button'),
                  onPressed: () async {
                    const String id = '1';
                    context.goNamed(
                      RouteName.bookDetails.name,
                      pathParameters: {'id': id},
                    );
                  },
                  child: const Text('Push Details'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
