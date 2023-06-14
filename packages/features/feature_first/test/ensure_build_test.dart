@TestOn('vm')
@Tags(['presubmit-only'])
@Timeout(Duration(seconds: 120))
import 'package:build_verify/build_verify.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'ensure_build',
    () => expectBuildClean(
      packageRelativeDirectory: 'packages/features/feature_first',
    ),
  );
}
