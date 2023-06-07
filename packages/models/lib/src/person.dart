import 'package:dart_mappable/dart_mappable.dart';
import 'package:modddels_annotation_fpdart/modddels_annotation_fpdart.dart';

part 'person.modddel.dart';
part 'person.mapper.dart';

@MappableClass(includeCustomMappers: [AgeMapper()])
class Person with PersonMappable {
  const Person({
    required this.firstName,
    required this.lastName,
    required this.age,
  });

  factory Person.fromJson(String json) => PersonMapper.fromJson(json);

  factory Person.fromMap(Map<String, Object?> map) => PersonMapper.fromMap(map);

  final String firstName;
  final String lastName;
  final Age age;

  String testMethod() {
    return '$firstName $lastName says hello world';
  }
}

@Modddel(validationSteps: [
  ValidationStep([
    Validation('legal', FailureType<AgeFailure>()),
  ], name: 'Value'),
])
class Age extends SingleValueObject<InvalidAge, ValidAge> with _$Age {
  const Age._();

  factory Age(int value) {
    return _$Age._create(
      value: value,
    );
  }

  @override
  Option<AgeFailure> validateLegal(age) {
    if (age.value < 0) {
      return some(const AgeFailure.invalid());
    }
    if (age.value < 18) {
      return some(const AgeFailure.minor());
    }
    return none();
  }
}

@MappableClass(discriminatorValue: 'age_failure_minor')
class AgeFailureMinor extends AgeFailure with AgeFailureMinorMappable {
  const AgeFailureMinor();
}

@MappableClass(discriminatorValue: 'age_failure_invalid')
class AgeFailureInvalid extends AgeFailure with AgeFailureInvalidMappable {
  const AgeFailureInvalid();
}

@MappableClass(discriminatorKey: 'age_failure_type')
abstract class AgeFailure extends ValueFailure with AgeFailureMappable {
  const AgeFailure();
  const factory AgeFailure.minor() = AgeFailureMinor;
  const factory AgeFailure.invalid() = AgeFailureInvalid;
}

class SingleValueObjectHook extends MappingHook {
  const SingleValueObjectHook();

  @override
  Object? beforeEncode(Object? value) {
    if (value is SingleValueObject) {
      return value.mapValidity(
          valid: (validValue) => validValue, invalid: (_) => null);
    }
    return value;
  }

  @override
  Object? beforeDecode(Object? value) {
    return null;
  }
}

/// Maps an [Age] class to JSON for dart_mappable
class AgeMapper extends SimpleMapper<Age> {
  const AgeMapper();

  @override
  Age decode(Object? value) {
    if (value is int) {
      return Age(value);
    }

    // Invalid age
    return Age(-1);
  }

  @override
  dynamic encode(Age self) {
    return self.mapValidity(
      valid: (ValidAge validAge) => validAge.value,
      invalid: (InvalidAge invalidAge) => invalidAge,
    );
  }
}
