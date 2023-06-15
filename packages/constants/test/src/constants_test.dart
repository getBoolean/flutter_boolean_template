// ignore_for_file: prefer_const_constructors

import 'package:constants/constants.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Constants', () {
    test('flavor can be accessed', () {
      // not an actual test
      expect(Constants.flavor, isNotNull);
    });
  });
}
