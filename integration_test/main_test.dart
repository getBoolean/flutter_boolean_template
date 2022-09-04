import 'package:convenient_test_dev/convenient_test_dev.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boolean_template/main.dart' as app;
import 'package:flutter_boolean_template/src/app.dart';

void main() {
  convenientTestMain(MyConvenientTestSlot(), () {});
}

class MyConvenientTestSlot extends ConvenientTestSlot {
  @override
  Future<void> appMain(AppMainExecuteMode mode) async => app.main();

  @override
  BuildContext? getNavContext(ConvenientTest t) =>
      App.navigatorKey.currentContext;
}
