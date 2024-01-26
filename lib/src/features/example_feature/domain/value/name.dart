import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:modddels_annotation_fpdart/modddels_annotation_fpdart.dart';

part 'name.freezed.dart';
part 'name.modddel.dart';

@Modddel(
  validationSteps: [
    ValidationStep(
      [
        Validation('allowed', FailureType<NameValidFailure>()),
      ],
      name: 'Value',
    ),
  ],
)
class Name extends MultiValueObject<InvalidName, ValidName> with _$Name {
  factory Name({
    required String firstName,
    required String lastName,
    String middleName = '',
  }) =>
      _$Name._create(
        firstName: firstName,
        lastName: lastName,
        middleName: middleName,
      );
  const Name._();

  @override
  Option<NameValidFailure> validateAllowed(_ValidateNameAllowed name) {
    if (name.firstName.isEmpty || name.lastName.isEmpty) {
      // also check for valid email format
      return some(const NameValidFailure.empty());
    }

    return none();
  }
}

@freezed
class NameValidFailure extends ValueFailure with _$NameValidFailure {
  const factory NameValidFailure.illegalCharacters() = _IllegalCharacters;
  const factory NameValidFailure.obscene() = _Obscene;
  const factory NameValidFailure.empty() = _Empty;
}
