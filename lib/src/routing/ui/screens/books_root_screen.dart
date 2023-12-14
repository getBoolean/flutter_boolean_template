import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boolean_template/src/common_widgets/animated_fade_switcher.dart';
import 'package:flutter_boolean_template/utils/utils.dart';
import 'package:go_router/go_router.dart';
import 'package:log/log.dart';

class BooksRootScreen extends StatefulWidget {
  const BooksRootScreen({super.key, this.id});

  final String? id;

  @override
  State<BooksRootScreen> createState() => _BooksRootScreenState();
}

class _BooksRootScreenState extends State<BooksRootScreen> {
  final log = Logger('BooksScreen');

  @override
  Widget build(BuildContext context) {
    final deviceForm = $deviceForm(context);
    return ColoredBox(
      color: Colors.blue,
      child: Center(
        child: AnimatedFadeSwitcher(
          shouldSwitch: deviceForm.isNotSmall && widget.id != null,
          secondChild: FilledButton(
            key: const ValueKey('button'),
            onPressed: () async {
              context.go('/books/details?id=${widget.id ?? "1"}');
            },
            child: const Text('Push Details'),
          ),
          child: Text(
            'Book ${widget.id}',
            key: const ValueKey('text'),
            style: context.textStyles.titleLarge,
          ),
        ),
      ),
    );
  }
}
