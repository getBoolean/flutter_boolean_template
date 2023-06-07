// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, prefer_void_to_null, invalid_use_of_protected_member, unnecessary_brace_in_string_interps, unnecessary_cast, unnecessary_null_comparison

part of 'person.dart';

// **************************************************************************
// ModddelsGenerator
// **************************************************************************

final _$unimplementedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`, or you tried to access an instance member from within the annotated class.');

class _$CopyWithDefault {
  const _$CopyWithDefault();
}

const _$copyWithDefault = _$CopyWithDefault();

mixin _$Age {
  static Age _$instance() => Age._();

  static Age _create({required int value}) {
    final $ageValueHolder = _$AgeValueHolder(value: value);

    return _verifyValueStep($ageValueHolder)
        .fold((invalidAgeValue) => invalidAgeValue, (validAge) => validAge);
  }

  static Either<InvalidAgeValue, ValidAge> _verifyValueStep(
      _$AgeValueHolder $ageValueHolder) {
    // ignore: unused_local_variable
    final $ageInstance = _$instance();

    final legalFailure = $ageInstance
        .validateLegal($ageValueHolder.toLegalSubholder())
        .toNullable();

    if (legalFailure == null) {
      return right<InvalidAgeValue, ValidAge>(
        ValidAge._(value: $ageValueHolder.value),
      );
    }

    return left<InvalidAgeValue, ValidAge>(
      InvalidAgeValue._(
          value: $ageValueHolder.value, legalFailure: legalFailure),
    );
  }

  TResult map<TResult extends Object?>(
      {required TResult Function(ValidAge validAge) valid,
      required TResult Function(InvalidAgeValue invalidAgeValue)
          invalidValue}) {
    return maybeMap(
        valid: valid,
        invalidValue: invalidValue,
        orElse: () => throw UnreachableError());
  }

  TResult maybeMap<TResult extends Object?>(
          {TResult Function(ValidAge validAge)? valid,
          TResult Function(InvalidAgeValue invalidAgeValue)? invalidValue,
          required TResult Function() orElse}) =>
      throw _$unimplementedError;

  TResult? mapOrNull<TResult extends Object?>(
      {TResult Function(ValidAge validAge)? valid,
      TResult Function(InvalidAgeValue invalidAgeValue)? invalidValue}) {
    return maybeMap(
        valid: valid, invalidValue: invalidValue, orElse: () => null);
  }

  TResult mapValidity<TResult extends Object?>(
      {required TResult Function(ValidAge validAge) valid,
      required TResult Function(InvalidAge invalidAge) invalid}) {
    return maybeMap(valid: valid, orElse: () => invalid(this as InvalidAge));
  }

  TResult maybeMapValidity<TResult extends Object?>(
      {required TResult Function(ValidAge validAge) valid,
      TResult Function(InvalidAgeValue invalidAgeValue)? invalidValue,
      required TResult Function(InvalidAge invalidAge) orElse}) {
    return maybeMap(
        valid: valid,
        invalidValue: invalidValue,
        orElse: () => orElse(this as InvalidAge));
  }

  Age Function({int value}) get copyWith {
    return ({Object? value = _$copyWithDefault}) {
      final $copy$value = mapValidity(
          valid: (valid) => valid.value, invalid: (invalid) => invalid.value);

      return Age(value == _$copyWithDefault ? $copy$value : value as int);
    };
  }

  Option<AgeFailure> validateLegal(_ValidateAgeLegal age);

  List<Object?> get props => throw _$unimplementedError;
}

class ValidAge extends Age implements ValidValueObject {
  ValidAge._({required this.value}) : super._();

  final int value;

  @override
  TResult maybeMap<TResult extends Object?>(
      {TResult Function(ValidAge validAge)? valid,
      TResult Function(InvalidAgeValue invalidAgeValue)? invalidValue,
      required TResult Function() orElse}) {
    return valid != null ? valid(this) : orElse();
  }

  @override
  List<Object?> get props => [value];

  @override
  String toString() => 'ValidAge(value: $value)';
}

mixin InvalidAge implements Age, InvalidValueObject {
  int get value;

  TResult mapInvalid<TResult extends Object?>(
      {required TResult Function(InvalidAgeValue invalidAgeValue)
          invalidValue}) {
    return maybeMap(
        invalidValue: invalidValue, orElse: () => throw UnreachableError());
  }

  TResult maybeMapInvalid<TResult extends Object?>(
      {TResult Function(InvalidAgeValue invalidAgeValue)? invalidValue,
      required TResult Function() orElse}) {
    return maybeMap(invalidValue: invalidValue, orElse: orElse);
  }

  TResult? mapOrNullInvalid<TResult extends Object?>(
      {TResult Function(InvalidAgeValue invalidAgeValue)? invalidValue}) {
    return maybeMap(invalidValue: invalidValue, orElse: () => null);
  }

  TResult whenInvalid<TResult extends Object?>(
      {required TResult Function(AgeFailure legalFailure) valueFailures}) {
    return maybeWhenInvalid(
        valueFailures: valueFailures, orElse: () => throw UnreachableError());
  }

  TResult maybeWhenInvalid<TResult extends Object?>(
      {TResult Function(AgeFailure legalFailure)? valueFailures,
      required TResult Function() orElse}) {
    return maybeMap(
        invalidValue: valueFailures != null
            ? (invalidValue) => valueFailures(invalidValue.legalFailure)
            : null,
        orElse: orElse);
  }

  TResult? whenOrNullInvalid<TResult extends Object?>(
      {TResult Function(AgeFailure legalFailure)? valueFailures}) {
    return maybeWhenInvalid(valueFailures: valueFailures, orElse: () => null);
  }
}

class InvalidAgeValue extends Age with InvalidAge {
  InvalidAgeValue._({required this.value, required this.legalFailure})
      : super._();

  @override
  final int value;

  final AgeFailure legalFailure;

  @override
  List<ValueFailure> get failures => [legalFailure];

  @override
  List<Object?> get props => [value, legalFailure];

  @override
  TResult maybeMap<TResult extends Object?>(
      {TResult Function(ValidAge validAge)? valid,
      TResult Function(InvalidAgeValue invalidAgeValue)? invalidValue,
      required TResult Function() orElse}) {
    return invalidValue != null ? invalidValue(this) : orElse();
  }

  @override
  String toString() => 'InvalidAgeValue(failures: $failures, value: $value)';
}

class _$AgeValueHolder {
  _$AgeValueHolder({required this.value});

  final int value;

  _ValidateAgeLegal toLegalSubholder() {
    return _ValidateAgeLegal(value: value);
  }
}

class _ValidateAgeLegal {
  _ValidateAgeLegal({required this.value});

  final int value;
}
