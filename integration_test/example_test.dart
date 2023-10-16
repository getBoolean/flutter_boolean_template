import 'package:flutter/material.dart';
import 'package:flutter_boolean_template/app.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:patrol/patrol.dart';

void main() {
  patrolTest(
    'counter state is the same after going to home and going back',
    // ignore: deprecated_member_use
    nativeAutomation: true,
    skip: true,
    ($) async {
      await $.pumpWidgetAndSettle(const ProviderScope(child: App()));

      await $(FloatingActionButton).tap();
      expect($(#counterText).text, '1');

      await $.native.pressHome();
      await $.native.pressDoubleRecentApps();

      expect($(#counterText).text, '1');
      await $(FloatingActionButton).tap();
      expect($(#counterText).text, '2');

      await $.native.openNotifications();
      await $.native.pressBack();
    },
  );
}
