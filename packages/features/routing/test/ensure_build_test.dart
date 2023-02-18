@TestOn('vm')
@Tags(['presubmit-only'])
import 'package:build_verify/build_verify.dart';
import 'package:flutter_test/flutter_test.dart';

const _kBuildCommand = ['dart', 'run', 'build_runner', 'build'];

void main() {
  test('ensure_build', () => expectBuildClean(customCommand: _kBuildCommand));
}
