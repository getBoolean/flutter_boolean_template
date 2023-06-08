// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, prefer_void_to_null, invalid_use_of_protected_member, unnecessary_brace_in_string_interps, unnecessary_cast, unnecessary_null_comparison

part of 'id.dart';

// **************************************************************************
// ModddelsGenerator
// **************************************************************************

final _$unimplementedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`, or you tried to access an instance member from within the annotated class.');

class _$CopyWithDefault {
  const _$CopyWithDefault();
}

const _$copyWithDefault = _$CopyWithDefault();

mixin _$Id {
  static Id _$instance() => Id._();

  static Id _create({required String value}) {
    final $idValueHolder = _$IdValueHolder(value: value);

    return _verifyValueStep($idValueHolder)
        .fold((invalidIdValue) => invalidIdValue, (validId) => validId);
  }

  static Either<InvalidIdValue, ValidId> _verifyValueStep(
      _$IdValueHolder $idValueHolder) {
    // ignore: unused_local_variable
    final $idInstance = _$instance();

    final allowedFailure = $idInstance
        .validateAllowed($idValueHolder.toAllowedSubholder())
        .toNullable();

    if (allowedFailure == null) {
      return right<InvalidIdValue, ValidId>(
        ValidId._(value: $idValueHolder.value),
      );
    }

    return left<InvalidIdValue, ValidId>(
      InvalidIdValue._(
          value: $idValueHolder.value, allowedFailure: allowedFailure),
    );
  }

  TResult map<TResult extends Object?>(
      {required TResult Function(ValidId validId) valid,
      required TResult Function(InvalidIdValue invalidIdValue) invalidValue}) {
    return maybeMap(
        valid: valid,
        invalidValue: invalidValue,
        orElse: () => throw UnreachableError());
  }

  TResult maybeMap<TResult extends Object?>(
          {TResult Function(ValidId validId)? valid,
          TResult Function(InvalidIdValue invalidIdValue)? invalidValue,
          required TResult Function() orElse}) =>
      throw _$unimplementedError;

  TResult? mapOrNull<TResult extends Object?>(
      {TResult Function(ValidId validId)? valid,
      TResult Function(InvalidIdValue invalidIdValue)? invalidValue}) {
    return maybeMap(
        valid: valid, invalidValue: invalidValue, orElse: () => null);
  }

  TResult mapValidity<TResult extends Object?>(
      {required TResult Function(ValidId validId) valid,
      required TResult Function(InvalidId invalidId) invalid}) {
    return maybeMap(valid: valid, orElse: () => invalid(this as InvalidId));
  }

  TResult maybeMapValidity<TResult extends Object?>(
      {required TResult Function(ValidId validId) valid,
      TResult Function(InvalidIdValue invalidIdValue)? invalidValue,
      required TResult Function(InvalidId invalidId) orElse}) {
    return maybeMap(
        valid: valid,
        invalidValue: invalidValue,
        orElse: () => orElse(this as InvalidId));
  }

  Id Function({String value}) get copyWith {
    return ({Object? value = _$copyWithDefault}) {
      final $copy$value = mapValidity(
          valid: (valid) => valid.value, invalid: (invalid) => invalid.value);

      return Id(value == _$copyWithDefault ? $copy$value : value as String);
    };
  }

  Option<IdValidFailure> validateAllowed(_ValidateIdAllowed id);

  List<Object?> get props => throw _$unimplementedError;
}

class ValidId extends Id implements ValidValueObject {
  ValidId._({required this.value}) : super._();

  final String value;

  @override
  TResult maybeMap<TResult extends Object?>(
      {TResult Function(ValidId validId)? valid,
      TResult Function(InvalidIdValue invalidIdValue)? invalidValue,
      required TResult Function() orElse}) {
    return valid != null ? valid(this) : orElse();
  }

  @override
  List<Object?> get props => [value];

  @override
  String toString() => 'ValidId(value: $value)';
}

mixin InvalidId implements Id, InvalidValueObject {
  String get value;

  TResult mapInvalid<TResult extends Object?>(
      {required TResult Function(InvalidIdValue invalidIdValue) invalidValue}) {
    return maybeMap(
        invalidValue: invalidValue, orElse: () => throw UnreachableError());
  }

  TResult maybeMapInvalid<TResult extends Object?>(
      {TResult Function(InvalidIdValue invalidIdValue)? invalidValue,
      required TResult Function() orElse}) {
    return maybeMap(invalidValue: invalidValue, orElse: orElse);
  }

  TResult? mapOrNullInvalid<TResult extends Object?>(
      {TResult Function(InvalidIdValue invalidIdValue)? invalidValue}) {
    return maybeMap(invalidValue: invalidValue, orElse: () => null);
  }

  TResult whenInvalid<TResult extends Object?>(
      {required TResult Function(IdValidFailure allowedFailure)
          valueFailures}) {
    return maybeWhenInvalid(
        valueFailures: valueFailures, orElse: () => throw UnreachableError());
  }

  TResult maybeWhenInvalid<TResult extends Object?>(
      {TResult Function(IdValidFailure allowedFailure)? valueFailures,
      required TResult Function() orElse}) {
    return maybeMap(
        invalidValue: valueFailures != null
            ? (invalidValue) => valueFailures(invalidValue.allowedFailure)
            : null,
        orElse: orElse);
  }

  TResult? whenOrNullInvalid<TResult extends Object?>(
      {TResult Function(IdValidFailure allowedFailure)? valueFailures}) {
    return maybeWhenInvalid(valueFailures: valueFailures, orElse: () => null);
  }
}

class InvalidIdValue extends Id with InvalidId {
  InvalidIdValue._({required this.value, required this.allowedFailure})
      : super._();

  @override
  final String value;

  final IdValidFailure allowedFailure;

  @override
  List<ValueFailure> get failures => [allowedFailure];

  @override
  List<Object?> get props => [value, allowedFailure];

  @override
  TResult maybeMap<TResult extends Object?>(
      {TResult Function(ValidId validId)? valid,
      TResult Function(InvalidIdValue invalidIdValue)? invalidValue,
      required TResult Function() orElse}) {
    return invalidValue != null ? invalidValue(this) : orElse();
  }

  @override
  String toString() => 'InvalidIdValue(failures: $failures, value: $value)';
}

class _$IdValueHolder {
  _$IdValueHolder({required this.value});

  final String value;

  _ValidateIdAllowed toAllowedSubholder() {
    return _ValidateIdAllowed(value: value);
  }
}

class _ValidateIdAllowed {
  _ValidateIdAllowed({required this.value});

  final String value;
}
