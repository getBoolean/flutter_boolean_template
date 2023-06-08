// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, prefer_void_to_null, invalid_use_of_protected_member, unnecessary_brace_in_string_interps, unnecessary_cast, unnecessary_null_comparison

part of 'email.dart';

// **************************************************************************
// ModddelsGenerator
// **************************************************************************

final _$unimplementedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`, or you tried to access an instance member from within the annotated class.');

class _$CopyWithDefault {
  const _$CopyWithDefault();
}

const _$copyWithDefault = _$CopyWithDefault();

mixin _$Email {
  static Email _$instance() => Email._();

  static Email _create({required String value}) {
    final $emailValueHolder = _$EmailValueHolder(value: value);

    return _verifyValueStep($emailValueHolder).fold(
        (invalidEmailValue) => invalidEmailValue, (validEmail) => validEmail);
  }

  static Either<InvalidEmailValue, ValidEmail> _verifyValueStep(
      _$EmailValueHolder $emailValueHolder) {
    // ignore: unused_local_variable
    final $emailInstance = _$instance();

    final formatFailure = $emailInstance
        .validateFormat($emailValueHolder.toFormatSubholder())
        .toNullable();

    final availableFailure = $emailInstance
        .validateAvailable($emailValueHolder.toAvailableSubholder())
        .toNullable();

    if (formatFailure == null && availableFailure == null) {
      return right<InvalidEmailValue, ValidEmail>(
        ValidEmail._(value: $emailValueHolder.value),
      );
    }

    return left<InvalidEmailValue, ValidEmail>(
      InvalidEmailValue._(
          value: $emailValueHolder.value,
          formatFailure: formatFailure,
          availableFailure: availableFailure),
    );
  }

  TResult map<TResult extends Object?>(
      {required TResult Function(ValidEmail validEmail) valid,
      required TResult Function(InvalidEmailValue invalidEmailValue)
          invalidValue}) {
    return maybeMap(
        valid: valid,
        invalidValue: invalidValue,
        orElse: () => throw UnreachableError());
  }

  TResult maybeMap<TResult extends Object?>(
          {TResult Function(ValidEmail validEmail)? valid,
          TResult Function(InvalidEmailValue invalidEmailValue)? invalidValue,
          required TResult Function() orElse}) =>
      throw _$unimplementedError;

  TResult? mapOrNull<TResult extends Object?>(
      {TResult Function(ValidEmail validEmail)? valid,
      TResult Function(InvalidEmailValue invalidEmailValue)? invalidValue}) {
    return maybeMap(
        valid: valid, invalidValue: invalidValue, orElse: () => null);
  }

  TResult mapValidity<TResult extends Object?>(
      {required TResult Function(ValidEmail validEmail) valid,
      required TResult Function(InvalidEmail invalidEmail) invalid}) {
    return maybeMap(valid: valid, orElse: () => invalid(this as InvalidEmail));
  }

  TResult maybeMapValidity<TResult extends Object?>(
      {required TResult Function(ValidEmail validEmail) valid,
      TResult Function(InvalidEmailValue invalidEmailValue)? invalidValue,
      required TResult Function(InvalidEmail invalidEmail) orElse}) {
    return maybeMap(
        valid: valid,
        invalidValue: invalidValue,
        orElse: () => orElse(this as InvalidEmail));
  }

  Email Function({String value}) get copyWith {
    return ({Object? value = _$copyWithDefault}) {
      final $copy$value = mapValidity(
          valid: (valid) => valid.value, invalid: (invalid) => invalid.value);

      return Email(value == _$copyWithDefault ? $copy$value : value as String);
    };
  }

  Option<EmailFormatFailure> validateFormat(_ValidateEmailFormat email);
  Option<EmailAvailableFailure> validateAvailable(
      _ValidateEmailAvailable email);

  List<Object?> get props => throw _$unimplementedError;
}

class ValidEmail extends Email implements ValidValueObject {
  ValidEmail._({required this.value}) : super._();

  final String value;

  @override
  TResult maybeMap<TResult extends Object?>(
      {TResult Function(ValidEmail validEmail)? valid,
      TResult Function(InvalidEmailValue invalidEmailValue)? invalidValue,
      required TResult Function() orElse}) {
    return valid != null ? valid(this) : orElse();
  }

  @override
  List<Object?> get props => [value];

  @override
  String toString() => 'ValidEmail(value: $value)';
}

mixin InvalidEmail implements Email, InvalidValueObject {
  String get value;

  TResult mapInvalid<TResult extends Object?>(
      {required TResult Function(InvalidEmailValue invalidEmailValue)
          invalidValue}) {
    return maybeMap(
        invalidValue: invalidValue, orElse: () => throw UnreachableError());
  }

  TResult maybeMapInvalid<TResult extends Object?>(
      {TResult Function(InvalidEmailValue invalidEmailValue)? invalidValue,
      required TResult Function() orElse}) {
    return maybeMap(invalidValue: invalidValue, orElse: orElse);
  }

  TResult? mapOrNullInvalid<TResult extends Object?>(
      {TResult Function(InvalidEmailValue invalidEmailValue)? invalidValue}) {
    return maybeMap(invalidValue: invalidValue, orElse: () => null);
  }

  TResult whenInvalid<TResult extends Object?>(
      {required TResult Function(EmailFormatFailure? formatFailure,
              EmailAvailableFailure? availableFailure)
          valueFailures}) {
    return maybeWhenInvalid(
        valueFailures: valueFailures, orElse: () => throw UnreachableError());
  }

  TResult maybeWhenInvalid<TResult extends Object?>(
      {TResult Function(EmailFormatFailure? formatFailure,
              EmailAvailableFailure? availableFailure)?
          valueFailures,
      required TResult Function() orElse}) {
    return maybeMap(
        invalidValue: valueFailures != null
            ? (invalidValue) => valueFailures(
                invalidValue.formatFailure, invalidValue.availableFailure)
            : null,
        orElse: orElse);
  }

  TResult? whenOrNullInvalid<TResult extends Object?>(
      {TResult Function(EmailFormatFailure? formatFailure,
              EmailAvailableFailure? availableFailure)?
          valueFailures}) {
    return maybeWhenInvalid(valueFailures: valueFailures, orElse: () => null);
  }
}

class InvalidEmailValue extends Email with InvalidEmail {
  InvalidEmailValue._(
      {required this.value,
      required this.formatFailure,
      required this.availableFailure})
      : super._();

  @override
  final String value;

  final EmailFormatFailure? formatFailure;

  final EmailAvailableFailure? availableFailure;

  bool get hasFormatFailure => formatFailure != null;

  bool get hasAvailableFailure => availableFailure != null;

  @override
  List<ValueFailure> get failures => [
        if (formatFailure != null) formatFailure!,
        if (availableFailure != null) availableFailure!
      ];

  @override
  List<Object?> get props => [value, formatFailure, availableFailure];

  @override
  TResult maybeMap<TResult extends Object?>(
      {TResult Function(ValidEmail validEmail)? valid,
      TResult Function(InvalidEmailValue invalidEmailValue)? invalidValue,
      required TResult Function() orElse}) {
    return invalidValue != null ? invalidValue(this) : orElse();
  }

  @override
  String toString() => 'InvalidEmailValue(failures: $failures, value: $value)';
}

class _$EmailValueHolder {
  _$EmailValueHolder({required this.value});

  final String value;

  _ValidateEmailFormat toFormatSubholder() {
    return _ValidateEmailFormat(value: value);
  }

  _ValidateEmailAvailable toAvailableSubholder() {
    return _ValidateEmailAvailable(value: value);
  }
}

class _ValidateEmailFormat {
  _ValidateEmailFormat({required this.value});

  final String value;
}

class _ValidateEmailAvailable {
  _ValidateEmailAvailable({required this.value});

  final String value;
}
