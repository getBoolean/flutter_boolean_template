// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element

part of 'email.dart';

class EmailFailureTakenMapper extends SubClassMapperBase<EmailFailureTaken> {
  EmailFailureTakenMapper._();

  static EmailFailureTakenMapper? _instance;
  static EmailFailureTakenMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = EmailFailureTakenMapper._());
      EmailFailureMapper.ensureInitialized().addSubMapper(_instance!);
    }
    return _instance!;
  }

  static T _guard<T>(T Function(MapperContainer) fn) {
    ensureInitialized();
    return fn(MapperContainer.globals);
  }

  @override
  final String id = 'EmailFailureTaken';

  @override
  final Map<Symbol, Field<EmailFailureTaken, dynamic>> fields = const {};

  @override
  final String discriminatorKey = 'email_failure_type';
  @override
  final dynamic discriminatorValue = 'email_failure_taken';
  @override
  late final ClassMapperBase superMapper =
      EmailFailureMapper.ensureInitialized();

  static EmailFailureTaken _instantiate(DecodingData data) {
    return EmailFailureTaken();
  }

  @override
  final Function instantiate = _instantiate;

  static EmailFailureTaken fromMap(Map<String, dynamic> map) {
    return _guard((c) => c.fromMap<EmailFailureTaken>(map));
  }

  static EmailFailureTaken fromJson(String json) {
    return _guard((c) => c.fromJson<EmailFailureTaken>(json));
  }
}

mixin EmailFailureTakenMappable {
  String toJson() {
    return EmailFailureTakenMapper._guard(
        (c) => c.toJson(this as EmailFailureTaken));
  }

  Map<String, dynamic> toMap() {
    return EmailFailureTakenMapper._guard(
        (c) => c.toMap(this as EmailFailureTaken));
  }

  EmailFailureTakenCopyWith<EmailFailureTaken, EmailFailureTaken,
          EmailFailureTaken>
      get copyWith => _EmailFailureTakenCopyWithImpl(
          this as EmailFailureTaken, $identity, $identity);
  @override
  String toString() {
    return EmailFailureTakenMapper._guard((c) => c.asString(this));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            EmailFailureTakenMapper._guard((c) => c.isEqual(this, other)));
  }

  @override
  int get hashCode {
    return EmailFailureTakenMapper._guard((c) => c.hash(this));
  }
}

extension EmailFailureTakenValueCopy<$R, $Out>
    on ObjectCopyWith<$R, EmailFailureTaken, $Out> {
  EmailFailureTakenCopyWith<$R, EmailFailureTaken, $Out>
      get $asEmailFailureTaken =>
          $base.as((v, t, t2) => _EmailFailureTakenCopyWithImpl(v, t, t2));
}

abstract class EmailFailureTakenCopyWith<$R, $In extends EmailFailureTaken,
    $Out> implements EmailFailureCopyWith<$R, $In, $Out> {
  @override
  $R call();
  EmailFailureTakenCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _EmailFailureTakenCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, EmailFailureTaken, $Out>
    implements EmailFailureTakenCopyWith<$R, EmailFailureTaken, $Out> {
  _EmailFailureTakenCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<EmailFailureTaken> $mapper =
      EmailFailureTakenMapper.ensureInitialized();
  @override
  $R call() => $apply(FieldCopyWithData({}));
  @override
  EmailFailureTaken $make(CopyWithData data) => EmailFailureTaken();

  @override
  EmailFailureTakenCopyWith<$R2, EmailFailureTaken, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _EmailFailureTakenCopyWithImpl($value, $cast, t);
}

class EmailFailureInvalidMapper
    extends SubClassMapperBase<EmailFailureInvalid> {
  EmailFailureInvalidMapper._();

  static EmailFailureInvalidMapper? _instance;
  static EmailFailureInvalidMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = EmailFailureInvalidMapper._());
      EmailFailureMapper.ensureInitialized().addSubMapper(_instance!);
    }
    return _instance!;
  }

  static T _guard<T>(T Function(MapperContainer) fn) {
    ensureInitialized();
    return fn(MapperContainer.globals);
  }

  @override
  final String id = 'EmailFailureInvalid';

  @override
  final Map<Symbol, Field<EmailFailureInvalid, dynamic>> fields = const {};

  @override
  final String discriminatorKey = 'email_failure_type';
  @override
  final dynamic discriminatorValue = 'email_failure_invalid';
  @override
  late final ClassMapperBase superMapper =
      EmailFailureMapper.ensureInitialized();

  static EmailFailureInvalid _instantiate(DecodingData data) {
    return EmailFailureInvalid();
  }

  @override
  final Function instantiate = _instantiate;

  static EmailFailureInvalid fromMap(Map<String, dynamic> map) {
    return _guard((c) => c.fromMap<EmailFailureInvalid>(map));
  }

  static EmailFailureInvalid fromJson(String json) {
    return _guard((c) => c.fromJson<EmailFailureInvalid>(json));
  }
}

mixin EmailFailureInvalidMappable {
  String toJson() {
    return EmailFailureInvalidMapper._guard(
        (c) => c.toJson(this as EmailFailureInvalid));
  }

  Map<String, dynamic> toMap() {
    return EmailFailureInvalidMapper._guard(
        (c) => c.toMap(this as EmailFailureInvalid));
  }

  EmailFailureInvalidCopyWith<EmailFailureInvalid, EmailFailureInvalid,
          EmailFailureInvalid>
      get copyWith => _EmailFailureInvalidCopyWithImpl(
          this as EmailFailureInvalid, $identity, $identity);
  @override
  String toString() {
    return EmailFailureInvalidMapper._guard((c) => c.asString(this));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            EmailFailureInvalidMapper._guard((c) => c.isEqual(this, other)));
  }

  @override
  int get hashCode {
    return EmailFailureInvalidMapper._guard((c) => c.hash(this));
  }
}

extension EmailFailureInvalidValueCopy<$R, $Out>
    on ObjectCopyWith<$R, EmailFailureInvalid, $Out> {
  EmailFailureInvalidCopyWith<$R, EmailFailureInvalid, $Out>
      get $asEmailFailureInvalid =>
          $base.as((v, t, t2) => _EmailFailureInvalidCopyWithImpl(v, t, t2));
}

abstract class EmailFailureInvalidCopyWith<$R, $In extends EmailFailureInvalid,
    $Out> implements EmailFailureCopyWith<$R, $In, $Out> {
  @override
  $R call();
  EmailFailureInvalidCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _EmailFailureInvalidCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, EmailFailureInvalid, $Out>
    implements EmailFailureInvalidCopyWith<$R, EmailFailureInvalid, $Out> {
  _EmailFailureInvalidCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<EmailFailureInvalid> $mapper =
      EmailFailureInvalidMapper.ensureInitialized();
  @override
  $R call() => $apply(FieldCopyWithData({}));
  @override
  EmailFailureInvalid $make(CopyWithData data) => EmailFailureInvalid();

  @override
  EmailFailureInvalidCopyWith<$R2, EmailFailureInvalid, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _EmailFailureInvalidCopyWithImpl($value, $cast, t);
}

class EmailFailureMapper extends ClassMapperBase<EmailFailure> {
  EmailFailureMapper._();

  static EmailFailureMapper? _instance;
  static EmailFailureMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = EmailFailureMapper._());
      EmailFailureTakenMapper.ensureInitialized();
      EmailFailureInvalidMapper.ensureInitialized();
    }
    return _instance!;
  }

  static T _guard<T>(T Function(MapperContainer) fn) {
    ensureInitialized();
    return fn(MapperContainer.globals);
  }

  @override
  final String id = 'EmailFailure';

  @override
  final Map<Symbol, Field<EmailFailure, dynamic>> fields = const {};

  static EmailFailure _instantiate(DecodingData data) {
    throw MapperException.missingSubclass('EmailFailure', 'email_failure_type',
        '${data.value['email_failure_type']}');
  }

  @override
  final Function instantiate = _instantiate;

  static EmailFailure fromMap(Map<String, dynamic> map) {
    return _guard((c) => c.fromMap<EmailFailure>(map));
  }

  static EmailFailure fromJson(String json) {
    return _guard((c) => c.fromJson<EmailFailure>(json));
  }
}

mixin EmailFailureMappable {
  String toJson();
  Map<String, dynamic> toMap();
  EmailFailureCopyWith<EmailFailure, EmailFailure, EmailFailure> get copyWith;
}

abstract class EmailFailureCopyWith<$R, $In extends EmailFailure, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call();
  EmailFailureCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}
