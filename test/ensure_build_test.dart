@TestOn('vm')
@Tags(['presubmit-only'])
import 'package:build_verify/build_verify.dart';
import 'package:flutter_test/flutter_test.dart';

const _kDefaultCommand = ['flutter', 'pub', 'run', 'build_runner', 'build', '--delete-conflicting-outputs'];

void main() {
  test('ensure_build', () => expectBuildClean(customCommand: _kDefaultCommand));
}
