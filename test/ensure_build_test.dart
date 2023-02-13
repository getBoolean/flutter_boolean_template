@TestOn('vm')
@Tags(['presubmit-only'])
import 'package:build_verify/build_verify.dart';
import 'package:flutter_test/flutter_test.dart';

const _kBuildCommand = ['melos', 'run', 'build'];
const _kGenLocalizationCommand = ['melos', 'run', 'loc'];

void main() {
  test('ensure_build', () => expectBuildClean(customCommand: _kBuildCommand));
  test('ensure_loc_gen',
      () => expectBuildClean(customCommand: _kGenLocalizationCommand));
}
