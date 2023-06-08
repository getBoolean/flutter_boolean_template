import 'package:dart_mappable/dart_mappable.dart';
import 'package:modddels_annotation_fpdart/modddels_annotation_fpdart.dart';

part 'email.modddel.dart';
part 'email.mapper.dart';

@Modddel(validationSteps: [
  ValidationStep([
    Validation('format', FailureType<EmailFailure>()),
    Validation('available', FailureType<EmailFailure>()),
  ], name: 'Value'),
])
class Email extends SingleValueObject<InvalidEmail, ValidEmail> with _$Email {
  const Email._();

  factory Email(String value) {
    return _$Email._create(
      value: value,
    );
  }

  @override
  Option<EmailFailure> validateFormat(email) {
    if (email.value.isEmpty) {
      // also check for valid email format
      return some(const EmailFailure.invalid());
    }
    return none();
  }

  @override
  Option<EmailFailure> validateAvailable(email) {
    if (email.value == 'example_taken@gmail.com') {
      return some(const EmailFailure.taken());
    }
    return none();
  }
}

@MappableClass(discriminatorValue: 'email_failure_taken')
class EmailFailureTaken extends EmailFailure with EmailFailureTakenMappable {
  const EmailFailureTaken();
}

@MappableClass(discriminatorValue: 'email_failure_invalid')
class EmailFailureInvalid extends EmailFailure
    with EmailFailureInvalidMappable {
  const EmailFailureInvalid();
}

@MappableClass(discriminatorKey: 'email_failure_type')
abstract class EmailFailure extends ValueFailure with EmailFailureMappable {
  const EmailFailure();
  const factory EmailFailure.taken() = EmailFailureTaken;
  const factory EmailFailure.invalid() = EmailFailureInvalid;
}
