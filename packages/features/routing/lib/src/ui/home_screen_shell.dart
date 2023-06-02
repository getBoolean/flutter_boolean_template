import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:logs/logs.dart';

@RoutePage()
class HomeScreenShell extends StatelessWidget {
  const HomeScreenShell({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement HomeScreen widget to use instead of Placeholder
    return const LoggerWidget(child: Placeholder());
  }
}
