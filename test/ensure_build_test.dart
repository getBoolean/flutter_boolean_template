@TestOn('vm')
@Tags(['presubmit-only'])
@Timeout(Duration(seconds: 120))
import 'package:build_verify/build_verify.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'ensure_gen',
    expectBuildClean,
    // Skipped because build_verify package does not support flutter gen-l10n.
    skip: true,
  );
}
