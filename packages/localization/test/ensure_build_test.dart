@TestOn('vm')
@Tags(['presubmit-only'])
@Timeout(Duration(seconds: 120))
import 'package:build_verify/build_verify.dart';
import 'package:flutter_test/flutter_test.dart';

const _kGenLocalizationCommand = ['flutter', 'gen-l10n'];

void main() {
  test(
    'ensure_loc_gen',
    () => expectBuildClean(
      customCommand: _kGenLocalizationCommand,
      packageRelativeDirectory: 'packages/localization',
    ),
    // Skipped because build_verify package does not support flutter gen-l10n.
    skip: true,
  );
}
