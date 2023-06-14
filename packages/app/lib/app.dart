library app;

import 'package:feature_first/domain/entity/user_account.dart';
import 'package:feature_first/domain/value/email.dart';
import 'package:feature_first/domain/value/id.dart';
import 'package:feature_first/domain/value/name.dart';
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
    final userJohnDoe = UserAccount(
      name: Name(firstName: 'John', lastName: 'Doe'),
      email: Email('test@gmail.com'),
      id: Id('5646532'),
    );
    final userJohnDeer =
        userJohnDoe.copyWith(name: Name(firstName: 'John', lastName: 'Deer'));
    userJohnDoe.mapValidity(
        valid: (validUser) => debugPrint(validUser.toString()),
        invalid: (invalidUser) => debugPrint(invalidUser.toString()));
    userJohnDeer.mapValidity(
        valid: (validUser) => debugPrint(validUser.toString()),
        invalid: (invalidUser) => debugPrint(invalidUser.toString()));

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
