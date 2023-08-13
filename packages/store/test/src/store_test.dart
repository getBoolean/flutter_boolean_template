// ignore_for_file: prefer_const_constructors
import 'package:store/store.dart';
import 'package:test/test.dart';

void main() {
  group('Store', () {
    test('can be instantiated', () {
      expect(Store(), isNotNull);
    });
  });
}
