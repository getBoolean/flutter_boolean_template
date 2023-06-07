// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element

part of 'person.dart';

class PersonMapper extends ClassMapperBase<Person> {
  PersonMapper._();

  static PersonMapper? _instance;
  static PersonMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PersonMapper._());
      MapperContainer.globals.use(AgeMapper());
    }
    return _instance!;
  }

  static T _guard<T>(T Function(MapperContainer) fn) {
    ensureInitialized();
    return fn(MapperContainer.globals);
  }

  @override
  final String id = 'Person';

  static String _$firstName(Person v) => v.firstName;
  static const Field<Person, String> _f$firstName =
      Field('firstName', _$firstName);
  static String _$lastName(Person v) => v.lastName;
  static const Field<Person, String> _f$lastName =
      Field('lastName', _$lastName);
  static Age _$age(Person v) => v.age;
  static const Field<Person, Age> _f$age = Field('age', _$age);

  @override
  final Map<Symbol, Field<Person, dynamic>> fields = const {
    #firstName: _f$firstName,
    #lastName: _f$lastName,
    #age: _f$age,
  };

  static Person _instantiate(DecodingData data) {
    return Person(
        firstName: data.dec(_f$firstName),
        lastName: data.dec(_f$lastName),
        age: data.dec(_f$age));
  }

  @override
  final Function instantiate = _instantiate;

  static Person fromMap(Map<String, dynamic> map) {
    return _guard((c) => c.fromMap<Person>(map));
  }

  static Person fromJson(String json) {
    return _guard((c) => c.fromJson<Person>(json));
  }
}

mixin PersonMappable {
  String toJson() {
    return PersonMapper._guard((c) => c.toJson(this as Person));
  }

  Map<String, dynamic> toMap() {
    return PersonMapper._guard((c) => c.toMap(this as Person));
  }

  PersonCopyWith<Person, Person, Person> get copyWith =>
      _PersonCopyWithImpl(this as Person, $identity, $identity);
  @override
  String toString() {
    return PersonMapper._guard((c) => c.asString(this));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            PersonMapper._guard((c) => c.isEqual(this, other)));
  }

  @override
  int get hashCode {
    return PersonMapper._guard((c) => c.hash(this));
  }
}

extension PersonValueCopy<$R, $Out> on ObjectCopyWith<$R, Person, $Out> {
  PersonCopyWith<$R, Person, $Out> get $asPerson =>
      $base.as((v, t, t2) => _PersonCopyWithImpl(v, t, t2));
}

abstract class PersonCopyWith<$R, $In extends Person, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? firstName, String? lastName, Age? age});
  PersonCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _PersonCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, Person, $Out>
    implements PersonCopyWith<$R, Person, $Out> {
  _PersonCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Person> $mapper = PersonMapper.ensureInitialized();
  @override
  $R call({String? firstName, String? lastName, Age? age}) =>
      $apply(FieldCopyWithData({
        if (firstName != null) #firstName: firstName,
        if (lastName != null) #lastName: lastName,
        if (age != null) #age: age
      }));
  @override
  Person $make(CopyWithData data) => Person(
      firstName: data.get(#firstName, or: $value.firstName),
      lastName: data.get(#lastName, or: $value.lastName),
      age: data.get(#age, or: $value.age));

  @override
  PersonCopyWith<$R2, Person, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _PersonCopyWithImpl($value, $cast, t);
}

class AgeFailureMinorMapper extends SubClassMapperBase<AgeFailureMinor> {
  AgeFailureMinorMapper._();

  static AgeFailureMinorMapper? _instance;
  static AgeFailureMinorMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AgeFailureMinorMapper._());
      AgeFailureMapper.ensureInitialized().addSubMapper(_instance!);
    }
    return _instance!;
  }

  static T _guard<T>(T Function(MapperContainer) fn) {
    ensureInitialized();
    return fn(MapperContainer.globals);
  }

  @override
  final String id = 'AgeFailureMinor';

  @override
  final Map<Symbol, Field<AgeFailureMinor, dynamic>> fields = const {};

  @override
  final String discriminatorKey = 'age_failure_type';
  @override
  final dynamic discriminatorValue = 'age_failure_minor';
  @override
  late final ClassMapperBase superMapper = AgeFailureMapper.ensureInitialized();

  static AgeFailureMinor _instantiate(DecodingData data) {
    return AgeFailureMinor();
  }

  @override
  final Function instantiate = _instantiate;

  static AgeFailureMinor fromMap(Map<String, dynamic> map) {
    return _guard((c) => c.fromMap<AgeFailureMinor>(map));
  }

  static AgeFailureMinor fromJson(String json) {
    return _guard((c) => c.fromJson<AgeFailureMinor>(json));
  }
}

mixin AgeFailureMinorMappable {
  String toJson() {
    return AgeFailureMinorMapper._guard(
        (c) => c.toJson(this as AgeFailureMinor));
  }

  Map<String, dynamic> toMap() {
    return AgeFailureMinorMapper._guard(
        (c) => c.toMap(this as AgeFailureMinor));
  }

  AgeFailureMinorCopyWith<AgeFailureMinor, AgeFailureMinor, AgeFailureMinor>
      get copyWith => _AgeFailureMinorCopyWithImpl(
          this as AgeFailureMinor, $identity, $identity);
  @override
  String toString() {
    return AgeFailureMinorMapper._guard((c) => c.asString(this));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            AgeFailureMinorMapper._guard((c) => c.isEqual(this, other)));
  }

  @override
  int get hashCode {
    return AgeFailureMinorMapper._guard((c) => c.hash(this));
  }
}

extension AgeFailureMinorValueCopy<$R, $Out>
    on ObjectCopyWith<$R, AgeFailureMinor, $Out> {
  AgeFailureMinorCopyWith<$R, AgeFailureMinor, $Out> get $asAgeFailureMinor =>
      $base.as((v, t, t2) => _AgeFailureMinorCopyWithImpl(v, t, t2));
}

abstract class AgeFailureMinorCopyWith<$R, $In extends AgeFailureMinor, $Out>
    implements AgeFailureCopyWith<$R, $In, $Out> {
  @override
  $R call();
  AgeFailureMinorCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _AgeFailureMinorCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, AgeFailureMinor, $Out>
    implements AgeFailureMinorCopyWith<$R, AgeFailureMinor, $Out> {
  _AgeFailureMinorCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<AgeFailureMinor> $mapper =
      AgeFailureMinorMapper.ensureInitialized();
  @override
  $R call() => $apply(FieldCopyWithData({}));
  @override
  AgeFailureMinor $make(CopyWithData data) => AgeFailureMinor();

  @override
  AgeFailureMinorCopyWith<$R2, AgeFailureMinor, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _AgeFailureMinorCopyWithImpl($value, $cast, t);
}

class AgeFailureInvalidMapper extends SubClassMapperBase<AgeFailureInvalid> {
  AgeFailureInvalidMapper._();

  static AgeFailureInvalidMapper? _instance;
  static AgeFailureInvalidMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AgeFailureInvalidMapper._());
      AgeFailureMapper.ensureInitialized().addSubMapper(_instance!);
    }
    return _instance!;
  }

  static T _guard<T>(T Function(MapperContainer) fn) {
    ensureInitialized();
    return fn(MapperContainer.globals);
  }

  @override
  final String id = 'AgeFailureInvalid';

  @override
  final Map<Symbol, Field<AgeFailureInvalid, dynamic>> fields = const {};

  @override
  final String discriminatorKey = 'age_failure_type';
  @override
  final dynamic discriminatorValue = 'age_failure_invalid';
  @override
  late final ClassMapperBase superMapper = AgeFailureMapper.ensureInitialized();

  static AgeFailureInvalid _instantiate(DecodingData data) {
    return AgeFailureInvalid();
  }

  @override
  final Function instantiate = _instantiate;

  static AgeFailureInvalid fromMap(Map<String, dynamic> map) {
    return _guard((c) => c.fromMap<AgeFailureInvalid>(map));
  }

  static AgeFailureInvalid fromJson(String json) {
    return _guard((c) => c.fromJson<AgeFailureInvalid>(json));
  }
}

mixin AgeFailureInvalidMappable {
  String toJson() {
    return AgeFailureInvalidMapper._guard(
        (c) => c.toJson(this as AgeFailureInvalid));
  }

  Map<String, dynamic> toMap() {
    return AgeFailureInvalidMapper._guard(
        (c) => c.toMap(this as AgeFailureInvalid));
  }

  AgeFailureInvalidCopyWith<AgeFailureInvalid, AgeFailureInvalid,
          AgeFailureInvalid>
      get copyWith => _AgeFailureInvalidCopyWithImpl(
          this as AgeFailureInvalid, $identity, $identity);
  @override
  String toString() {
    return AgeFailureInvalidMapper._guard((c) => c.asString(this));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            AgeFailureInvalidMapper._guard((c) => c.isEqual(this, other)));
  }

  @override
  int get hashCode {
    return AgeFailureInvalidMapper._guard((c) => c.hash(this));
  }
}

extension AgeFailureInvalidValueCopy<$R, $Out>
    on ObjectCopyWith<$R, AgeFailureInvalid, $Out> {
  AgeFailureInvalidCopyWith<$R, AgeFailureInvalid, $Out>
      get $asAgeFailureInvalid =>
          $base.as((v, t, t2) => _AgeFailureInvalidCopyWithImpl(v, t, t2));
}

abstract class AgeFailureInvalidCopyWith<$R, $In extends AgeFailureInvalid,
    $Out> implements AgeFailureCopyWith<$R, $In, $Out> {
  @override
  $R call();
  AgeFailureInvalidCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _AgeFailureInvalidCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, AgeFailureInvalid, $Out>
    implements AgeFailureInvalidCopyWith<$R, AgeFailureInvalid, $Out> {
  _AgeFailureInvalidCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<AgeFailureInvalid> $mapper =
      AgeFailureInvalidMapper.ensureInitialized();
  @override
  $R call() => $apply(FieldCopyWithData({}));
  @override
  AgeFailureInvalid $make(CopyWithData data) => AgeFailureInvalid();

  @override
  AgeFailureInvalidCopyWith<$R2, AgeFailureInvalid, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _AgeFailureInvalidCopyWithImpl($value, $cast, t);
}

class AgeFailureMapper extends ClassMapperBase<AgeFailure> {
  AgeFailureMapper._();

  static AgeFailureMapper? _instance;
  static AgeFailureMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AgeFailureMapper._());
      AgeFailureMinorMapper.ensureInitialized();
      AgeFailureInvalidMapper.ensureInitialized();
    }
    return _instance!;
  }

  static T _guard<T>(T Function(MapperContainer) fn) {
    ensureInitialized();
    return fn(MapperContainer.globals);
  }

  @override
  final String id = 'AgeFailure';

  @override
  final Map<Symbol, Field<AgeFailure, dynamic>> fields = const {};

  static AgeFailure _instantiate(DecodingData data) {
    throw MapperException.missingSubclass(
        'AgeFailure', 'age_failure_type', '${data.value['age_failure_type']}');
  }

  @override
  final Function instantiate = _instantiate;

  static AgeFailure fromMap(Map<String, dynamic> map) {
    return _guard((c) => c.fromMap<AgeFailure>(map));
  }

  static AgeFailure fromJson(String json) {
    return _guard((c) => c.fromJson<AgeFailure>(json));
  }
}

mixin AgeFailureMappable {
  String toJson();
  Map<String, dynamic> toMap();
  AgeFailureCopyWith<AgeFailure, AgeFailure, AgeFailure> get copyWith;
}

abstract class AgeFailureCopyWith<$R, $In extends AgeFailure, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call();
  AgeFailureCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}
