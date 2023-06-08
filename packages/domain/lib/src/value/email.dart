import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:modddels_annotation_fpdart/modddels_annotation_fpdart.dart';

part 'email.freezed.dart';
part 'email.modddel.dart';

@Modddel(validationSteps: [
  ValidationStep([
    Validation('format', FailureType<EmailFormatFailure>()),
    Validation('available', FailureType<EmailAvailableFailure>()),
  ], name: 'Value'),
])
class Email extends SingleValueObject<InvalidEmail, ValidEmail> with _$Email {
  const Email._();

  factory Email(String value) => _$Email._create(value: value);

  @override
  Option<EmailFormatFailure> validateFormat(email) {
    if (email.value.isEmpty) {
      // also check for valid email format
      return some(const EmailFormatFailure.invalid());
    }
    return none();
  }

  @override
  Option<EmailAvailableFailure> validateAvailable(email) {
    if (email.value == 'example_taken@gmail.com') {
      return some(const EmailAvailableFailure.taken());
    }
    return none();
  }
}

@freezed
class EmailAvailableFailure extends ValueFailure with _$EmailAvailableFailure {
  const factory EmailAvailableFailure.taken() = _Taken;
  const factory EmailAvailableFailure.reserved() = _Reserved;
  const factory EmailAvailableFailure.banned() = _Banned;
}

@freezed
class EmailFormatFailure extends ValueFailure with _$EmailFormatFailure {
  const factory EmailFormatFailure.invalid() = _Invalid;
}
