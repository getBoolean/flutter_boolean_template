import 'package:flutter/widgets.dart';
import '../localization.dart';

extension LocalizedBuildContext on BuildContext {
  AppLocalizations get loc => AppLocalizations.of(this);
}
