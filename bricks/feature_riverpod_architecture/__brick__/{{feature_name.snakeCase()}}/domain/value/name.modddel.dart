// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, prefer_void_to_null, invalid_use_of_protected_member, unnecessary_brace_in_string_interps, unnecessary_cast, unnecessary_null_comparison

part of 'name.dart';

// **************************************************************************
// ModddelsGenerator
// **************************************************************************

final _$unimplementedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`, or you tried to access an instance member from within the annotated class.');

class _$CopyWithDefault {
  const _$CopyWithDefault();
}

const _$copyWithDefault = _$CopyWithDefault();

mixin _$Name {
  static Name _$instance() => Name._();

  static Name _create(
      {required String firstName,
      required String lastName,
      required String middleName}) {
    final $nameValueHolder = _$NameValueHolder(
        firstName: firstName, lastName: lastName, middleName: middleName);

    return _verifyValueStep($nameValueHolder)
        .fold((invalidNameValue) => invalidNameValue, (validName) => validName);
  }

  static Either<InvalidNameValue, ValidName> _verifyValueStep(
      _$NameValueHolder $nameValueHolder) {
    // ignore: unused_local_variable
    final $nameInstance = _$instance();

    final allowedFailure = $nameInstance
        .validateAllowed($nameValueHolder.toAllowedSubholder())
        .toNullable();

    if (allowedFailure == null) {
      return right<InvalidNameValue, ValidName>(
        ValidName._(
            firstName: $nameValueHolder.firstName,
            lastName: $nameValueHolder.lastName,
            middleName: $nameValueHolder.middleName),
      );
    }

    return left<InvalidNameValue, ValidName>(
      InvalidNameValue._(
          firstName: $nameValueHolder.firstName,
          lastName: $nameValueHolder.lastName,
          middleName: $nameValueHolder.middleName,
          allowedFailure: allowedFailure),
    );
  }

  TResult map<TResult extends Object?>(
      {required TResult Function(ValidName validName) valid,
      required TResult Function(InvalidNameValue invalidNameValue)
          invalidValue}) {
    return maybeMap(
        valid: valid,
        invalidValue: invalidValue,
        orElse: () => throw UnreachableError());
  }

  TResult maybeMap<TResult extends Object?>(
          {TResult Function(ValidName validName)? valid,
          TResult Function(InvalidNameValue invalidNameValue)? invalidValue,
          required TResult Function() orElse}) =>
      throw _$unimplementedError;

  TResult? mapOrNull<TResult extends Object?>(
      {TResult Function(ValidName validName)? valid,
      TResult Function(InvalidNameValue invalidNameValue)? invalidValue}) {
    return maybeMap(
        valid: valid, invalidValue: invalidValue, orElse: () => null);
  }

  TResult mapValidity<TResult extends Object?>(
      {required TResult Function(ValidName validName) valid,
      required TResult Function(InvalidName invalidName) invalid}) {
    return maybeMap(valid: valid, orElse: () => invalid(this as InvalidName));
  }

  TResult maybeMapValidity<TResult extends Object?>(
      {required TResult Function(ValidName validName) valid,
      TResult Function(InvalidNameValue invalidNameValue)? invalidValue,
      required TResult Function(InvalidName invalidName) orElse}) {
    return maybeMap(
        valid: valid,
        invalidValue: invalidValue,
        orElse: () => orElse(this as InvalidName));
  }

  Name Function({String firstName, String lastName, String middleName})
      get copyWith {
    return (
        {Object? firstName = _$copyWithDefault,
        Object? lastName = _$copyWithDefault,
        Object? middleName = _$copyWithDefault}) {
      final $copy$firstName = mapValidity(
          valid: (valid) => valid.firstName,
          invalid: (invalid) => invalid.firstName);
      final $copy$lastName = mapValidity(
          valid: (valid) => valid.lastName,
          invalid: (invalid) => invalid.lastName);
      final $copy$middleName = mapValidity(
          valid: (valid) => valid.middleName,
          invalid: (invalid) => invalid.middleName);

      return Name(
          firstName: firstName == _$copyWithDefault
              ? $copy$firstName
              : firstName as String,
          lastName: lastName == _$copyWithDefault
              ? $copy$lastName
              : lastName as String,
          middleName: middleName == _$copyWithDefault
              ? $copy$middleName
              : middleName as String);
    };
  }

  Option<NameValidFailure> validateAllowed(_ValidateNameAllowed name);

  List<Object?> get props => throw _$unimplementedError;
}

class ValidName extends Name implements ValidValueObject {
  ValidName._(
      {required this.firstName,
      required this.lastName,
      required this.middleName})
      : super._();

  final String firstName;

  final String lastName;

  final String middleName;

  @override
  TResult maybeMap<TResult extends Object?>(
      {TResult Function(ValidName validName)? valid,
      TResult Function(InvalidNameValue invalidNameValue)? invalidValue,
      required TResult Function() orElse}) {
    return valid != null ? valid(this) : orElse();
  }

  @override
  List<Object?> get props => [firstName, lastName, middleName];

  @override
  String toString() =>
      'ValidName(firstName: $firstName, lastName: $lastName, middleName: $middleName)';
}

mixin InvalidName implements Name, InvalidValueObject {
  String get firstName;

  String get lastName;

  String get middleName;

  TResult mapInvalid<TResult extends Object?>(
      {required TResult Function(InvalidNameValue invalidNameValue)
          invalidValue}) {
    return maybeMap(
        invalidValue: invalidValue, orElse: () => throw UnreachableError());
  }

  TResult maybeMapInvalid<TResult extends Object?>(
      {TResult Function(InvalidNameValue invalidNameValue)? invalidValue,
      required TResult Function() orElse}) {
    return maybeMap(invalidValue: invalidValue, orElse: orElse);
  }

  TResult? mapOrNullInvalid<TResult extends Object?>(
      {TResult Function(InvalidNameValue invalidNameValue)? invalidValue}) {
    return maybeMap(invalidValue: invalidValue, orElse: () => null);
  }

  TResult whenInvalid<TResult extends Object?>(
      {required TResult Function(NameValidFailure allowedFailure)
          valueFailures}) {
    return maybeWhenInvalid(
        valueFailures: valueFailures, orElse: () => throw UnreachableError());
  }

  TResult maybeWhenInvalid<TResult extends Object?>(
      {TResult Function(NameValidFailure allowedFailure)? valueFailures,
      required TResult Function() orElse}) {
    return maybeMap(
        invalidValue: valueFailures != null
            ? (invalidValue) => valueFailures(invalidValue.allowedFailure)
            : null,
        orElse: orElse);
  }

  TResult? whenOrNullInvalid<TResult extends Object?>(
      {TResult Function(NameValidFailure allowedFailure)? valueFailures}) {
    return maybeWhenInvalid(valueFailures: valueFailures, orElse: () => null);
  }
}

class InvalidNameValue extends Name with InvalidName {
  InvalidNameValue._(
      {required this.firstName,
      required this.lastName,
      required this.middleName,
      required this.allowedFailure})
      : super._();

  @override
  final String firstName;

  @override
  final String lastName;

  @override
  final String middleName;

  final NameValidFailure allowedFailure;

  @override
  List<ValueFailure> get failures => [allowedFailure];

  @override
  List<Object?> get props => [firstName, lastName, middleName, allowedFailure];

  @override
  TResult maybeMap<TResult extends Object?>(
      {TResult Function(ValidName validName)? valid,
      TResult Function(InvalidNameValue invalidNameValue)? invalidValue,
      required TResult Function() orElse}) {
    return invalidValue != null ? invalidValue(this) : orElse();
  }

  @override
  String toString() =>
      'InvalidNameValue(failures: $failures, firstName: $firstName, lastName: $lastName, middleName: $middleName)';
}

class _$NameValueHolder {
  _$NameValueHolder(
      {required this.firstName,
      required this.lastName,
      required this.middleName});

  final String firstName;

  final String lastName;

  final String middleName;

  _ValidateNameAllowed toAllowedSubholder() {
    return _ValidateNameAllowed(
        firstName: firstName, lastName: lastName, middleName: middleName);
  }
}

class _ValidateNameAllowed {
  _ValidateNameAllowed(
      {required this.firstName,
      required this.lastName,
      required this.middleName});

  final String firstName;

  final String lastName;

  final String middleName;
}
