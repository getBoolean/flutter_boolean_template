import 'app_localizations.dart';

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'flutter_boolean_template';

  @override
  String get timesButtonPressed =>
      'You have pushed the button this many times:';

  @override
  String get increment => 'Increment';
}
