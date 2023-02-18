@TestOn('vm')
@Tags(['presubmit-only'])
import 'package:build_verify/build_verify.dart';
import 'package:flutter_test/flutter_test.dart';

const _kGenLocalizationCommand = ['flutter', 'gen-l10n'];

void main() {
  test(
    'ensure_loc_gen',
    () => expectBuildClean(customCommand: _kGenLocalizationCommand),
  );
}
