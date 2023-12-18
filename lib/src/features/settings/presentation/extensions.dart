import 'package:flutter/material.dart';
import 'package:flutter_boolean_template/src/features/settings/data/dto/settings.dart';

extension BuildContextSettings on BuildContext {
  Settings get settings => AppSettings.of(this);
}

class AppSettings extends InheritedModel<String> {
  const AppSettings({
    super.key,
    required this.settings,
    required super.child,
  });

  final Settings settings;

  static Settings? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppSettings>()?.settings;
  }

  static Settings of(BuildContext context) {
    final Settings? result = maybeOf(context);
    assert(result != null, 'No FrogColor found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(AppSettings oldWidget) =>
      settings != oldWidget.settings;

  @override
  bool updateShouldNotifyDependent(
      AppSettings oldWidget, Set<String> dependencies) {
    return settings != oldWidget.settings && dependencies.contains('settings');
  }
}
