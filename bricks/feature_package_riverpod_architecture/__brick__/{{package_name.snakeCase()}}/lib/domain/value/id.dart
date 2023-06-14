import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:modddels_annotation_fpdart/modddels_annotation_fpdart.dart';

part 'id.freezed.dart';
part 'id.modddel.dart';

@Modddel(validationSteps: [
  ValidationStep([
    Validation('allowed', FailureType<IdValidFailure>()),
  ], name: 'Value')
])
class Id extends SingleValueObject<InvalidId, ValidId> with _$Id {
  const Id._();

  factory Id(
    String value,
  ) =>
      _$Id._create(value: value);

  @override
  Option<IdValidFailure> validateAllowed(id) {
    if (id.value.isEmpty) {
      // also check for valid email format
      return some(const IdValidFailure.invalid());
    }

    return none();
  }
}

@freezed
class IdValidFailure extends ValueFailure with _$IdValidFailure {
  const factory IdValidFailure.invalid() = _Invalid;
}
