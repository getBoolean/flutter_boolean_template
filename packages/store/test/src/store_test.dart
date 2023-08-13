// ignore_for_file: prefer_const_constructors
import 'package:test/test.dart';
import 'package:store/store.dart';

void main() {
  group('Store', () {
    test('can be instantiated', () {
      expect(Store(), isNotNull);
    });
  });
}
