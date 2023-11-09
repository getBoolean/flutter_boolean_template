import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boolean_template/src/routing/ui/widgets/auto_update_title_state_mixin.dart';

@RoutePage<String>(name: 'BookDetailsRoute')
class BookDetailsScreen extends StatefulWidget {
  final int id;
  const BookDetailsScreen({
    super.key,
    @pathParam this.id = -1,
  });

  @override
  State<BookDetailsScreen> createState() => _BookDetailsScreenState();
}

class _BookDetailsScreenState extends State<BookDetailsScreen>
    with AutoUpdateTitleStateMixin<BookDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return const ColoredBox(
      color: Colors.blueAccent,
      child: Center(child: Text('Book Details Screen')),
    );
  }
}
