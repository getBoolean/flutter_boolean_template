library app;

import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boolean_template/src/features/example_feature/domain/entity/user_account.dart';
import 'package:flutter_boolean_template/src/features/example_feature/domain/value/email.dart';
import 'package:flutter_boolean_template/src/features/example_feature/domain/value/id.dart';
import 'package:flutter_boolean_template/src/features/example_feature/domain/value/name.dart';
import 'package:flutter_boolean_template/src/routing/router/app_router.dart';
import 'package:flutter_boolean_template/src/routing/router_provider.dart';
import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:localization/localization.dart';

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

    // TODO: Button to hide banner
    return FlavorBanner(
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
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
      ),
    );
  }
}
