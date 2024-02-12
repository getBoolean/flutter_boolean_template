import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boolean_template/src/common_widgets/animated_fade_switcher.dart';
import 'package:flutter_boolean_template/src/features/connectivity/presentation/offline_warning_widget.dart';
import 'package:flutter_boolean_template/utils/utils.dart';
import 'package:go_router/go_router.dart';

class BooksScreen extends StatelessWidget {
  const BooksScreen({
    super.key,
    this.id,
  });

  final String? id;

  @override
  Widget build(BuildContext context) {
    final deviceForm = $deviceForm(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Add a new book',
        child: const Icon(Icons.add),
      ),
      body: AnimatedFadeSwitcher(
        shouldSwitch: deviceForm.isNotSmall && id != null,
        secondChild: Column(
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
                      context.go('/books/details-${id ?? "1"}');
                      // context.go('/profile/details');
                    },
                    child: const Text('Push Details'),
                  ),
                ),
              ),
            ),
          ],
        ),
        child: Row(
          children: [
            const Flexible(
              child: ColoredBox(
                color: Colors.blue,
                child: Center(
                  child: Text('Books List'),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: ColoredBox(
                color: Colors.orange,
                child: Center(
                  child: Text(
                    'Book $id',
                    key: const ValueKey('text'),
                    style: context.textStyles.titleLarge,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
