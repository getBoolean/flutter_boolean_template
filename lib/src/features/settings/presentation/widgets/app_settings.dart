import 'package:flutter/material.dart';
import 'package:flutter_boolean_template/src/features/settings/data/dto/settings.dart';

class AppSettings extends InheritedModel<String> {
  const AppSettings({
    required this.settings,
    required super.child,
    super.key,
  });

  final Settings settings;

  static Settings? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppSettings>()?.settings;
  }

  static Settings of(BuildContext context) {
    final Settings? result = maybeOf(context);
    assert(result != null, 'No AppSettings found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(AppSettings oldWidget) =>
      settings != oldWidget.settings;

  @override
  bool updateShouldNotifyDependent(
    AppSettings oldWidget,
    Set<String> dependencies,
  ) {
    return settings != oldWidget.settings && dependencies.contains('settings');
  }
}
