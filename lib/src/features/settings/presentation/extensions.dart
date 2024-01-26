import 'package:flutter/material.dart';
import 'package:flutter_boolean_template/src/features/settings/data/dto/settings.dart';
import 'package:flutter_boolean_template/src/features/settings/presentation/utils.dart'
    as utils;
import 'package:flutter_boolean_template/src/features/settings/presentation/widgets/app_settings.dart';

extension BuildContextSettings on BuildContext {
  Settings get settings => AppSettings.of(this);
}

extension BuildContextModalExtensions on BuildContext {
  Future<ReturnT?> showOptionsMenu<ReturnT, OptionT>({
    required OptionT current,
    required List<OptionT> options,
    required String title,
    required String Function(
      BuildContext context,
      OptionT option,
    ) itemTitleBuilder,
  }) async {
    return await utils.showOptionsMenu<ReturnT, OptionT>(
      this,
      current: current,
      options: options,
      title: title,
      itemTitleBuilder: itemTitleBuilder,
    );
  }
}
