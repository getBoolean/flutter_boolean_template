// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'location_history.dart';

class LocationHistoryMapper extends ClassMapperBase<LocationHistory> {
  LocationHistoryMapper._();

  static LocationHistoryMapper? _instance;
  static LocationHistoryMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = LocationHistoryMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'LocationHistory';

  static List<String> _$history(LocationHistory v) => v.history;
  static const Field<LocationHistory, List<String>> _f$history =
      Field('history', _$history, opt: true, def: const []);
  static List<String> _$popped(LocationHistory v) => v.popped;
  static const Field<LocationHistory, List<String>> _f$popped =
      Field('popped', _$popped, opt: true, def: const []);

  @override
  final Map<Symbol, Field<LocationHistory, dynamic>> fields = const {
    #history: _f$history,
    #popped: _f$popped,
  };

  static LocationHistory _instantiate(DecodingData data) {
    return LocationHistory(
        history: data.dec(_f$history), popped: data.dec(_f$popped));
  }

  @override
  final Function instantiate = _instantiate;

  static LocationHistory fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<LocationHistory>(map);
  }

  static LocationHistory fromJson(String json) {
    return ensureInitialized().decodeJson<LocationHistory>(json);
  }
}

mixin LocationHistoryMappable {
  String toJson() {
    return LocationHistoryMapper.ensureInitialized()
        .encodeJson<LocationHistory>(this as LocationHistory);
  }

  Map<String, dynamic> toMap() {
    return LocationHistoryMapper.ensureInitialized()
        .encodeMap<LocationHistory>(this as LocationHistory);
  }

  LocationHistoryCopyWith<LocationHistory, LocationHistory, LocationHistory>
      get copyWith => _LocationHistoryCopyWithImpl(
          this as LocationHistory, $identity, $identity);
  @override
  String toString() {
    return LocationHistoryMapper.ensureInitialized()
        .stringifyValue(this as LocationHistory);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            LocationHistoryMapper.ensureInitialized()
                .isValueEqual(this as LocationHistory, other));
  }

  @override
  int get hashCode {
    return LocationHistoryMapper.ensureInitialized()
        .hashValue(this as LocationHistory);
  }
}

extension LocationHistoryValueCopy<$R, $Out>
    on ObjectCopyWith<$R, LocationHistory, $Out> {
  LocationHistoryCopyWith<$R, LocationHistory, $Out> get $asLocationHistory =>
      $base.as((v, t, t2) => _LocationHistoryCopyWithImpl(v, t, t2));
}

abstract class LocationHistoryCopyWith<$R, $In extends LocationHistory, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get history;
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get popped;
  $R call({List<String>? history, List<String>? popped});
  LocationHistoryCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _LocationHistoryCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, LocationHistory, $Out>
    implements LocationHistoryCopyWith<$R, LocationHistory, $Out> {
  _LocationHistoryCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<LocationHistory> $mapper =
      LocationHistoryMapper.ensureInitialized();
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get history =>
      ListCopyWith($value.history, (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(history: v));
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get popped =>
      ListCopyWith($value.popped, (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(popped: v));
  @override
  $R call({List<String>? history, List<String>? popped}) =>
      $apply(FieldCopyWithData({
        if (history != null) #history: history,
        if (popped != null) #popped: popped
      }));
  @override
  LocationHistory $make(CopyWithData data) => LocationHistory(
      history: data.get(#history, or: $value.history),
      popped: data.get(#popped, or: $value.popped));

  @override
  LocationHistoryCopyWith<$R2, LocationHistory, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _LocationHistoryCopyWithImpl($value, $cast, t);
}
