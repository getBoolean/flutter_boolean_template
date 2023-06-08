library app;

import 'package:auth_example/auth/auth.dart';
import 'package:domain/domain.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:localization/localization.dart';
import 'package:routing/routing.dart';

/// The main app widget at the root of the widget tree.
class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    UserAccount(
      name: Name(firstName: 'John', lastName: 'Doe'),
      email: Email('test@gmail.com'),
      id: Id('5646532'),
    ).mapValidity(
        valid: (validUser) => debugPrint(validUser.toString()),
        invalid: (invalidUser) => debugPrint(invalidUser.toString()));

    final String auth = ref.watch(authProvider);
    debugPrint(auth);

    final AppRouter router = ref.watch(routerProvider);
    return MaterialApp.router(
      onGenerateTitle: (context) => context.loc.appTitle,
      routerConfig: router.config(),
      restorationScopeId: 'app',
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: FlexThemeData.light(
        scheme: FlexScheme.mandyRed,
        useMaterial3: true,
      ),
      darkTheme:
          FlexThemeData.dark(scheme: FlexScheme.mandyRed, useMaterial3: true),
      themeMode: ThemeMode.system,
    );
  }
}
