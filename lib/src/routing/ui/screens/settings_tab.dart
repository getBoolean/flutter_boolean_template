import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boolean_template/src/features/settings/presentation/settings_widget.dart';
import 'package:flutter_boolean_template/src/routing/ui/widgets/sliver_auto_app_bar.dart';

@RoutePage()
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [const SliverAutoAppBar()];
        },
        body: const SettingsWidget(),
      ),
    );
  }
}
