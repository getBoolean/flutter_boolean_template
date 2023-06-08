// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, prefer_void_to_null, invalid_use_of_protected_member, unnecessary_brace_in_string_interps, unnecessary_cast, unnecessary_null_comparison

part of 'user_account.dart';

// **************************************************************************
// ModddelsGenerator
// **************************************************************************

final _$unimplementedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`, or you tried to access an instance member from within the annotated class.');

class _$CopyWithDefault {
  const _$CopyWithDefault();
}

const _$copyWithDefault = _$CopyWithDefault();

mixin _$UserAccount {
  static UserAccount _$instance() => UserAccount._();

  static UserAccount _create(
      {required Id id, required Name name, required Email email}) {
    final $userAccountMidHolder =
        _$UserAccountMidHolder(id: id, name: name, email: email);

    return _verifyMidStep($userAccountMidHolder).fold(
      (invalidUserAccountMid) => invalidUserAccountMid,
      ($userAccountValueHolder) => _verifyValueStep($userAccountValueHolder)
          .fold((invalidUserAccountValue) => invalidUserAccountValue,
              (validUserAccount) => validUserAccount),
    );
  }

  static Either<InvalidUserAccountMid, _$UserAccountValueHolder> _verifyMidStep(
      _$UserAccountMidHolder $userAccountMidHolder) {
    // ignore: unused_local_variable
    final $userAccountInstance = _$instance();

    final contentFailure = validateContent($userAccountMidHolder).toNullable();

    if (contentFailure == null) {
      return right<InvalidUserAccountMid, _$UserAccountValueHolder>(
        _$UserAccountValueHolder(
            id: $userAccountMidHolder.id as ValidId,
            name: $userAccountMidHolder.name as ValidName,
            email: $userAccountMidHolder.email as ValidEmail),
      );
    }

    return left<InvalidUserAccountMid, _$UserAccountValueHolder>(
      InvalidUserAccountMid._(
          id: $userAccountMidHolder.id,
          name: $userAccountMidHolder.name,
          email: $userAccountMidHolder.email,
          contentFailure: contentFailure),
    );
  }

  static Either<InvalidUserAccountValue, ValidUserAccount> _verifyValueStep(
      _$UserAccountValueHolder $userAccountValueHolder) {
    // ignore: unused_local_variable
    final $userAccountInstance = _$instance();

    final accountFailure = $userAccountInstance
        .validateAccount($userAccountValueHolder.toAccountSubholder())
        .toNullable();

    if (accountFailure == null) {
      return right<InvalidUserAccountValue, ValidUserAccount>(
        ValidUserAccount._(
            id: $userAccountValueHolder.id,
            name: $userAccountValueHolder.name,
            email: $userAccountValueHolder.email),
      );
    }

    return left<InvalidUserAccountValue, ValidUserAccount>(
      InvalidUserAccountValue._(
          id: $userAccountValueHolder.id,
          name: $userAccountValueHolder.name,
          email: $userAccountValueHolder.email,
          accountFailure: accountFailure),
    );
  }

  static Option<ContentFailure> validateContent(
      _$UserAccountMidHolder $userAccountMidHolder) {
    final $invalid$id =
        $userAccountMidHolder.id.toEither.getLeft().toNullable();
    final $invalid$name =
        $userAccountMidHolder.name.toEither.getLeft().toNullable();
    final $invalid$email =
        $userAccountMidHolder.email.toEither.getLeft().toNullable();

    if ($invalid$id == null &&
        $invalid$name == null &&
        $invalid$email == null) {
      return none();
    }

    final $contentFailure = ContentFailure([
      if ($invalid$id != null)
        ModddelInvalidMember(member: $invalid$id, description: 'id'),
      if ($invalid$name != null)
        ModddelInvalidMember(member: $invalid$name, description: 'name'),
      if ($invalid$email != null)
        ModddelInvalidMember(member: $invalid$email, description: 'email')
    ]);

    return some($contentFailure);
  }

  TResult map<TResult extends Object?>(
      {required TResult Function(ValidUserAccount validUserAccount) valid,
      required TResult Function(InvalidUserAccountMid invalidUserAccountMid)
          invalidMid,
      required TResult Function(InvalidUserAccountValue invalidUserAccountValue)
          invalidValue}) {
    return maybeMap(
        valid: valid,
        invalidMid: invalidMid,
        invalidValue: invalidValue,
        orElse: () => throw UnreachableError());
  }

  TResult maybeMap<TResult extends Object?>(
          {TResult Function(ValidUserAccount validUserAccount)? valid,
          TResult Function(InvalidUserAccountMid invalidUserAccountMid)?
              invalidMid,
          TResult Function(InvalidUserAccountValue invalidUserAccountValue)?
              invalidValue,
          required TResult Function() orElse}) =>
      throw _$unimplementedError;

  TResult? mapOrNull<TResult extends Object?>(
      {TResult Function(ValidUserAccount validUserAccount)? valid,
      TResult Function(InvalidUserAccountMid invalidUserAccountMid)? invalidMid,
      TResult Function(InvalidUserAccountValue invalidUserAccountValue)?
          invalidValue}) {
    return maybeMap(
        valid: valid,
        invalidMid: invalidMid,
        invalidValue: invalidValue,
        orElse: () => null);
  }

  TResult mapValidity<TResult extends Object?>(
      {required TResult Function(ValidUserAccount validUserAccount) valid,
      required TResult Function(InvalidUserAccount invalidUserAccount)
          invalid}) {
    return maybeMap(
        valid: valid, orElse: () => invalid(this as InvalidUserAccount));
  }

  TResult maybeMapValidity<TResult extends Object?>(
      {required TResult Function(ValidUserAccount validUserAccount) valid,
      TResult Function(InvalidUserAccountMid invalidUserAccountMid)? invalidMid,
      TResult Function(InvalidUserAccountValue invalidUserAccountValue)?
          invalidValue,
      required TResult Function(InvalidUserAccount invalidUserAccount)
          orElse}) {
    return maybeMap(
        valid: valid,
        invalidMid: invalidMid,
        invalidValue: invalidValue,
        orElse: () => orElse(this as InvalidUserAccount));
  }

  UserAccount Function({Id id, Name name, Email email}) get copyWith {
    return (
        {Object? id = _$copyWithDefault,
        Object? name = _$copyWithDefault,
        Object? email = _$copyWithDefault}) {
      final $copy$id = mapValidity(
          valid: (valid) => valid.id, invalid: (invalid) => invalid.id);
      final $copy$name = mapValidity(
          valid: (valid) => valid.name, invalid: (invalid) => invalid.name);
      final $copy$email = mapValidity(
          valid: (valid) => valid.email, invalid: (invalid) => invalid.email);

      return UserAccount(
          id: id == _$copyWithDefault ? $copy$id : id as Id,
          name: name == _$copyWithDefault ? $copy$name : name as Name,
          email: email == _$copyWithDefault ? $copy$email : email as Email);
    };
  }

  Option<UserAccountValidFailure> validateAccount(
      _ValidateUserAccountAccount userAccount);

  List<Object?> get props => throw _$unimplementedError;
}

class ValidUserAccount extends UserAccount implements ValidEntity {
  ValidUserAccount._(
      {required this.id, required this.name, required this.email})
      : super._();

  final ValidId id;

  final ValidName name;

  final ValidEmail email;

  @override
  TResult maybeMap<TResult extends Object?>(
      {TResult Function(ValidUserAccount validUserAccount)? valid,
      TResult Function(InvalidUserAccountMid invalidUserAccountMid)? invalidMid,
      TResult Function(InvalidUserAccountValue invalidUserAccountValue)?
          invalidValue,
      required TResult Function() orElse}) {
    return valid != null ? valid(this) : orElse();
  }

  @override
  List<Object?> get props => [id, name, email];

  @override
  String toString() => 'ValidUserAccount(id: $id, name: $name, email: $email)';
}

mixin InvalidUserAccount implements UserAccount, InvalidEntity {
  Id get id;

  Name get name;

  Email get email;

  TResult mapInvalid<TResult extends Object?>(
      {required TResult Function(InvalidUserAccountMid invalidUserAccountMid)
          invalidMid,
      required TResult Function(InvalidUserAccountValue invalidUserAccountValue)
          invalidValue}) {
    return maybeMap(
        invalidMid: invalidMid,
        invalidValue: invalidValue,
        orElse: () => throw UnreachableError());
  }

  TResult maybeMapInvalid<TResult extends Object?>(
      {TResult Function(InvalidUserAccountMid invalidUserAccountMid)?
          invalidMid,
      TResult Function(InvalidUserAccountValue invalidUserAccountValue)?
          invalidValue,
      required TResult Function() orElse}) {
    return maybeMap(
        invalidMid: invalidMid, invalidValue: invalidValue, orElse: orElse);
  }

  TResult? mapOrNullInvalid<TResult extends Object?>(
      {TResult Function(InvalidUserAccountMid invalidUserAccountMid)?
          invalidMid,
      TResult Function(InvalidUserAccountValue invalidUserAccountValue)?
          invalidValue}) {
    return maybeMap(
        invalidMid: invalidMid, invalidValue: invalidValue, orElse: () => null);
  }

  TResult whenInvalid<TResult extends Object?>(
      {required TResult Function(ContentFailure contentFailure) midFailures,
      required TResult Function(UserAccountValidFailure accountFailure)
          valueFailures}) {
    return maybeWhenInvalid(
        midFailures: midFailures,
        valueFailures: valueFailures,
        orElse: () => throw UnreachableError());
  }

  TResult maybeWhenInvalid<TResult extends Object?>(
      {TResult Function(ContentFailure contentFailure)? midFailures,
      TResult Function(UserAccountValidFailure accountFailure)? valueFailures,
      required TResult Function() orElse}) {
    return maybeMap(
        invalidMid: midFailures != null
            ? (invalidMid) => midFailures(invalidMid.contentFailure)
            : null,
        invalidValue: valueFailures != null
            ? (invalidValue) => valueFailures(invalidValue.accountFailure)
            : null,
        orElse: orElse);
  }

  TResult? whenOrNullInvalid<TResult extends Object?>(
      {TResult Function(ContentFailure contentFailure)? midFailures,
      TResult Function(UserAccountValidFailure accountFailure)?
          valueFailures}) {
    return maybeWhenInvalid(
        midFailures: midFailures,
        valueFailures: valueFailures,
        orElse: () => null);
  }
}

class InvalidUserAccountMid extends UserAccount with InvalidUserAccount {
  InvalidUserAccountMid._(
      {required this.id,
      required this.name,
      required this.email,
      required this.contentFailure})
      : super._();

  @override
  final Id id;

  @override
  final Name name;

  @override
  final Email email;

  final ContentFailure contentFailure;

  @override
  List<EntityFailure> get failures => [contentFailure];

  @override
  List<Object?> get props => [id, name, email, contentFailure];

  @override
  TResult maybeMap<TResult extends Object?>(
      {TResult Function(ValidUserAccount validUserAccount)? valid,
      TResult Function(InvalidUserAccountMid invalidUserAccountMid)? invalidMid,
      TResult Function(InvalidUserAccountValue invalidUserAccountValue)?
          invalidValue,
      required TResult Function() orElse}) {
    return invalidMid != null ? invalidMid(this) : orElse();
  }

  @override
  String toString() =>
      'InvalidUserAccountMid(failures: $failures, id: $id, name: $name, email: $email)';
}

class _$UserAccountMidHolder {
  _$UserAccountMidHolder(
      {required this.id, required this.name, required this.email});

  final Id id;

  final Name name;

  final Email email;
}

class InvalidUserAccountValue extends UserAccount with InvalidUserAccount {
  InvalidUserAccountValue._(
      {required this.id,
      required this.name,
      required this.email,
      required this.accountFailure})
      : super._();

  @override
  final ValidId id;

  @override
  final ValidName name;

  @override
  final ValidEmail email;

  final UserAccountValidFailure accountFailure;

  @override
  List<EntityFailure> get failures => [accountFailure];

  @override
  List<Object?> get props => [id, name, email, accountFailure];

  @override
  TResult maybeMap<TResult extends Object?>(
      {TResult Function(ValidUserAccount validUserAccount)? valid,
      TResult Function(InvalidUserAccountMid invalidUserAccountMid)? invalidMid,
      TResult Function(InvalidUserAccountValue invalidUserAccountValue)?
          invalidValue,
      required TResult Function() orElse}) {
    return invalidValue != null ? invalidValue(this) : orElse();
  }

  @override
  String toString() =>
      'InvalidUserAccountValue(failures: $failures, id: $id, name: $name, email: $email)';
}

class _$UserAccountValueHolder {
  _$UserAccountValueHolder(
      {required this.id, required this.name, required this.email});

  final ValidId id;

  final ValidName name;

  final ValidEmail email;

  _ValidateUserAccountAccount toAccountSubholder() {
    return _ValidateUserAccountAccount(id: id, name: name, email: email);
  }
}

class _ValidateUserAccountAccount {
  _ValidateUserAccountAccount(
      {required this.id, required this.name, required this.email});

  final ValidId id;

  final ValidName name;

  final ValidEmail email;
}
