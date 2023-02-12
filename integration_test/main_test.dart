import 'package:app_workspace/main.dart' as app;
import 'package:app_workspace/src/app.dart';
import 'package:convenient_test/convenient_test.dart';
import 'package:convenient_test_dev/convenient_test_dev.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

/// See `convenient_test`'s [full example](https://github.com/fzyzcjy/flutter_convenient_test/blob/master/packages/convenient_test/example/integration_test/main_test.dart)
///
/// Running `convenient_test` tests:
///   https://github.com/fzyzcjy/flutter_convenient_test#getting-started
///
/// Use the [Mark] widget so widgets can be found and tested using [find]`.get`
void main() {
  convenientTestMain(MyConvenientTestSlot(), () {
    tTestWidgets('custom commands', (t) async {
      await t.myCustomCommand();
      // await find.get(ZoomPageMark.palette).should(matchesGoldenFile('goldens/zoom_page_drag_before.png'));
    });
  });
}

class MyConvenientTestSlot extends ConvenientTestSlot {
  @override
  Future<void> appMain(AppMainExecuteMode mode) async => app.main();

  @override
  BuildContext? getNavContext(ConvenientTest t) =>
      App.navigatorKey.currentContext;
}

extension on ConvenientTest {
  Future<void> myCustomCommand() async {
    // Do anything you like... This is just a normal function
    debugPrint('Hello, world!');
  }
}
