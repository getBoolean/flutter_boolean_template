import 'package:dart_mappable/dart_mappable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:modddels_annotation_fpdart/modddels_annotation_fpdart.dart';

part 'person.modddel.dart';
part 'person.mapper.dart';
part 'person.freezed.dart';

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
    Validation('legal', FailureType<AgeLegalFailure>()),
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
  Option<AgeLegalFailure> validateLegal(age) {
    if (age.value < 0) {
      return some(const AgeLegalFailure.invalid());
    }
    if (age.value < 18) {
      return some(const AgeLegalFailure.minor());
    }
    return none();
  }
}

@freezed
class AgeLegalFailure extends ValueFailure with _$AgeLegalFailure {
  const factory AgeLegalFailure.minor() = _Minor;
  const factory AgeLegalFailure.invalid() = _Invalid;
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
