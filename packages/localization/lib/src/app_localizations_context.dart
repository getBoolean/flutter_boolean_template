import 'package:flutter/widgets.dart';
import 'package:localization/localization.dart';

extension LocalizedBuildContext on BuildContext {
  AppLocalizations get loc => AppLocalizations.of(this);
}
