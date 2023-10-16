// lookupAppLocalizations is defined here 👇
import 'dart:ui' as ui;

import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:localization/src/localization/app_localizations.dart';

// Source: https://codewithandrea.com/articles/app-localizations-outside-widgets-riverpod/

/// Provider used to access the [AppLocalizations] object for the current locale. This
/// allows for access to the localized strings without [BuildContext].
///
/// Callback example:
///
/// ```dart
/// // get the AppLocalizations object (read once)
/// final loc = ref.read(appLocalizationsProvider);
/// // read a property defined in the *.arb file
/// final error = loc.addToCartFailed;
/// ```
///
/// Provider example:
///
/// ```dart
/// // the corresponding provider
/// final cartServiceProvider = Provider<CartService>((ref) {
///   return CartService(
///     // pass the dependencies explicitly (using watch)
///     cartRepository: ref.watch(cartRepositoryProvider),
///     loc: ref.watch(appLocalizationsProvider),
///   );
/// });
/// ```
final appLocalizationsProvider = Provider<AppLocalizations>((ref) {
  // Initialize from the initial locale
  ref.state = lookupAppLocalizations(ui.PlatformDispatcher.instance.locale);
  // Create an observer to update the state
  final observer = _LocaleObserver((locales) {
    ref.state = lookupAppLocalizations(ui.PlatformDispatcher.instance.locale);
  });

  // Register the observer and dispose it when no longer needed
  final binding = WidgetsBinding.instance..addObserver(observer);
  ref.onDispose(() => binding.removeObserver(observer));

  return ref.state;
});

/// Observer used to notify the caller when the locale changes
class _LocaleObserver extends WidgetsBindingObserver {
  _LocaleObserver(this._didChangeLocales);

  final void Function(List<Locale>? locales) _didChangeLocales;

  @override
  void didChangeLocales(List<Locale>? locales) {
    _didChangeLocales(locales);
  }
}
