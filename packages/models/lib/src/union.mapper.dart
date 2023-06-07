// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element

part of 'union.dart';

class UnionMapper extends ClassMapperBase<Union> {
  UnionMapper._();

  static UnionMapper? _instance;
  static UnionMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = UnionMapper._());
      UnionDataMapper.ensureInitialized();
      UnionLoadingMapper.ensureInitialized();
      UnionErrorMapper.ensureInitialized();
    }
    return _instance!;
  }

  static T _guard<T>(T Function(MapperContainer) fn) {
    ensureInitialized();
    return fn(MapperContainer.globals);
  }

  @override
  final String id = 'Union';

  @override
  final Map<Symbol, Field<Union, dynamic>> fields = const {};

  static Union _instantiate(DecodingData data) {
    throw MapperException.missingSubclass(
        'Union', 'union_type', '${data.value['union_type']}');
  }

  @override
  final Function instantiate = _instantiate;

  static Union fromMap(Map<String, dynamic> map) {
    return _guard((c) => c.fromMap<Union>(map));
  }

  static Union fromJson(String json) {
    return _guard((c) => c.fromJson<Union>(json));
  }
}

mixin UnionMappable {
  String toJson();
  Map<String, dynamic> toMap();
  UnionCopyWith<Union, Union, Union> get copyWith;
}

abstract class UnionCopyWith<$R, $In extends Union, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call();
  UnionCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class UnionDataMapper extends SubClassMapperBase<UnionData> {
  UnionDataMapper._();

  static UnionDataMapper? _instance;
  static UnionDataMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = UnionDataMapper._());
      UnionMapper.ensureInitialized().addSubMapper(_instance!);
    }
    return _instance!;
  }

  static T _guard<T>(T Function(MapperContainer) fn) {
    ensureInitialized();
    return fn(MapperContainer.globals);
  }

  @override
  final String id = 'UnionData';

  @override
  final Map<Symbol, Field<UnionData, dynamic>> fields = const {};

  @override
  final String discriminatorKey = 'union_type';
  @override
  final dynamic discriminatorValue = 'union_data';
  @override
  late final ClassMapperBase superMapper = UnionMapper.ensureInitialized();

  static UnionData _instantiate(DecodingData data) {
    return UnionData();
  }

  @override
  final Function instantiate = _instantiate;

  static UnionData fromMap(Map<String, dynamic> map) {
    return _guard((c) => c.fromMap<UnionData>(map));
  }

  static UnionData fromJson(String json) {
    return _guard((c) => c.fromJson<UnionData>(json));
  }
}

mixin UnionDataMappable {
  String toJson() {
    return UnionDataMapper._guard((c) => c.toJson(this as UnionData));
  }

  Map<String, dynamic> toMap() {
    return UnionDataMapper._guard((c) => c.toMap(this as UnionData));
  }

  UnionDataCopyWith<UnionData, UnionData, UnionData> get copyWith =>
      _UnionDataCopyWithImpl(this as UnionData, $identity, $identity);
  @override
  String toString() {
    return UnionDataMapper._guard((c) => c.asString(this));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            UnionDataMapper._guard((c) => c.isEqual(this, other)));
  }

  @override
  int get hashCode {
    return UnionDataMapper._guard((c) => c.hash(this));
  }
}

extension UnionDataValueCopy<$R, $Out> on ObjectCopyWith<$R, UnionData, $Out> {
  UnionDataCopyWith<$R, UnionData, $Out> get $asUnionData =>
      $base.as((v, t, t2) => _UnionDataCopyWithImpl(v, t, t2));
}

abstract class UnionDataCopyWith<$R, $In extends UnionData, $Out>
    implements UnionCopyWith<$R, $In, $Out> {
  @override
  $R call();
  UnionDataCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _UnionDataCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, UnionData, $Out>
    implements UnionDataCopyWith<$R, UnionData, $Out> {
  _UnionDataCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<UnionData> $mapper =
      UnionDataMapper.ensureInitialized();
  @override
  $R call() => $apply(FieldCopyWithData({}));
  @override
  UnionData $make(CopyWithData data) => UnionData();

  @override
  UnionDataCopyWith<$R2, UnionData, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _UnionDataCopyWithImpl($value, $cast, t);
}

class UnionLoadingMapper extends SubClassMapperBase<UnionLoading> {
  UnionLoadingMapper._();

  static UnionLoadingMapper? _instance;
  static UnionLoadingMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = UnionLoadingMapper._());
      UnionMapper.ensureInitialized().addSubMapper(_instance!);
    }
    return _instance!;
  }

  static T _guard<T>(T Function(MapperContainer) fn) {
    ensureInitialized();
    return fn(MapperContainer.globals);
  }

  @override
  final String id = 'UnionLoading';

  @override
  final Map<Symbol, Field<UnionLoading, dynamic>> fields = const {};

  @override
  final String discriminatorKey = 'union_type';
  @override
  final dynamic discriminatorValue = 'union_loading';
  @override
  late final ClassMapperBase superMapper = UnionMapper.ensureInitialized();

  static UnionLoading _instantiate(DecodingData data) {
    return UnionLoading();
  }

  @override
  final Function instantiate = _instantiate;

  static UnionLoading fromMap(Map<String, dynamic> map) {
    return _guard((c) => c.fromMap<UnionLoading>(map));
  }

  static UnionLoading fromJson(String json) {
    return _guard((c) => c.fromJson<UnionLoading>(json));
  }
}

mixin UnionLoadingMappable {
  String toJson() {
    return UnionLoadingMapper._guard((c) => c.toJson(this as UnionLoading));
  }

  Map<String, dynamic> toMap() {
    return UnionLoadingMapper._guard((c) => c.toMap(this as UnionLoading));
  }

  UnionLoadingCopyWith<UnionLoading, UnionLoading, UnionLoading> get copyWith =>
      _UnionLoadingCopyWithImpl(this as UnionLoading, $identity, $identity);
  @override
  String toString() {
    return UnionLoadingMapper._guard((c) => c.asString(this));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            UnionLoadingMapper._guard((c) => c.isEqual(this, other)));
  }

  @override
  int get hashCode {
    return UnionLoadingMapper._guard((c) => c.hash(this));
  }
}

extension UnionLoadingValueCopy<$R, $Out>
    on ObjectCopyWith<$R, UnionLoading, $Out> {
  UnionLoadingCopyWith<$R, UnionLoading, $Out> get $asUnionLoading =>
      $base.as((v, t, t2) => _UnionLoadingCopyWithImpl(v, t, t2));
}

abstract class UnionLoadingCopyWith<$R, $In extends UnionLoading, $Out>
    implements UnionCopyWith<$R, $In, $Out> {
  @override
  $R call();
  UnionLoadingCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _UnionLoadingCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, UnionLoading, $Out>
    implements UnionLoadingCopyWith<$R, UnionLoading, $Out> {
  _UnionLoadingCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<UnionLoading> $mapper =
      UnionLoadingMapper.ensureInitialized();
  @override
  $R call() => $apply(FieldCopyWithData({}));
  @override
  UnionLoading $make(CopyWithData data) => UnionLoading();

  @override
  UnionLoadingCopyWith<$R2, UnionLoading, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _UnionLoadingCopyWithImpl($value, $cast, t);
}

class UnionErrorMapper extends SubClassMapperBase<UnionError> {
  UnionErrorMapper._();

  static UnionErrorMapper? _instance;
  static UnionErrorMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = UnionErrorMapper._());
      UnionMapper.ensureInitialized().addSubMapper(_instance!);
    }
    return _instance!;
  }

  static T _guard<T>(T Function(MapperContainer) fn) {
    ensureInitialized();
    return fn(MapperContainer.globals);
  }

  @override
  final String id = 'UnionError';

  @override
  final Map<Symbol, Field<UnionError, dynamic>> fields = const {};

  @override
  final String discriminatorKey = 'union_type';
  @override
  final dynamic discriminatorValue = 'union_error';
  @override
  late final ClassMapperBase superMapper = UnionMapper.ensureInitialized();

  static UnionError _instantiate(DecodingData data) {
    return UnionError();
  }

  @override
  final Function instantiate = _instantiate;

  static UnionError fromMap(Map<String, dynamic> map) {
    return _guard((c) => c.fromMap<UnionError>(map));
  }

  static UnionError fromJson(String json) {
    return _guard((c) => c.fromJson<UnionError>(json));
  }
}

mixin UnionErrorMappable {
  String toJson() {
    return UnionErrorMapper._guard((c) => c.toJson(this as UnionError));
  }

  Map<String, dynamic> toMap() {
    return UnionErrorMapper._guard((c) => c.toMap(this as UnionError));
  }

  UnionErrorCopyWith<UnionError, UnionError, UnionError> get copyWith =>
      _UnionErrorCopyWithImpl(this as UnionError, $identity, $identity);
  @override
  String toString() {
    return UnionErrorMapper._guard((c) => c.asString(this));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            UnionErrorMapper._guard((c) => c.isEqual(this, other)));
  }

  @override
  int get hashCode {
    return UnionErrorMapper._guard((c) => c.hash(this));
  }
}

extension UnionErrorValueCopy<$R, $Out>
    on ObjectCopyWith<$R, UnionError, $Out> {
  UnionErrorCopyWith<$R, UnionError, $Out> get $asUnionError =>
      $base.as((v, t, t2) => _UnionErrorCopyWithImpl(v, t, t2));
}

abstract class UnionErrorCopyWith<$R, $In extends UnionError, $Out>
    implements UnionCopyWith<$R, $In, $Out> {
  @override
  $R call();
  UnionErrorCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _UnionErrorCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, UnionError, $Out>
    implements UnionErrorCopyWith<$R, UnionError, $Out> {
  _UnionErrorCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<UnionError> $mapper =
      UnionErrorMapper.ensureInitialized();
  @override
  $R call() => $apply(FieldCopyWithData({}));
  @override
  UnionError $make(CopyWithData data) => UnionError();

  @override
  UnionErrorCopyWith<$R2, UnionError, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _UnionErrorCopyWithImpl($value, $cast, t);
}
