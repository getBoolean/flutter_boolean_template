import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:modddels_annotation_fpdart/modddels_annotation_fpdart.dart';

import '../value/email.dart';
import '../value/id.dart';
import '../value/name.dart';

part 'user_account.freezed.dart';
part 'user_account.modddel.dart';

@Modddel(
  validationSteps: [
    ValidationStep([
      contentValidation,
    ]),
    ValidationStep([
      Validation('account', FailureType<UserAccountValidFailure>()),
    ], name: 'Value')
  ],
)
class UserAccount extends SimpleEntity<InvalidUserAccount, ValidUserAccount> with _$UserAccount {
  UserAccount._();
  
  factory UserAccount({
    required Id id,
    required Name name,
    required Email email,
  }) {
    return _$UserAccount._create(id: id, name: name, email: email);
  }

  @override
  Option<UserAccountValidFailure> validateAccount(userAccount) {
    return none();
  }
}

@freezed
class UserAccountValidFailure extends EntityFailure with _$UserAccountValidFailure {
  const factory UserAccountValidFailure.invalid() = _Invalid;
}
