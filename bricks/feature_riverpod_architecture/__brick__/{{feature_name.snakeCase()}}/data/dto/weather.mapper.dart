// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element

part of 'weather.dart';

class WeatherParamsMapper extends ClassMapperBase<WeatherParams> {
  WeatherParamsMapper._();

  static WeatherParamsMapper? _instance;
  static WeatherParamsMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = WeatherParamsMapper._());
    }
    return _instance!;
  }

  static T _guard<T>(T Function(MapperContainer) fn) {
    ensureInitialized();
    return fn(MapperContainer.globals);
  }

  @override
  final String id = 'WeatherParams';

  static double _$temp(WeatherParams v) => v.temp;
  static const Field<WeatherParams, double> _f$temp = Field('temp', _$temp);
  static double _$tempMin(WeatherParams v) => v.tempMin;
  static const Field<WeatherParams, double> _f$tempMin =
      Field('tempMin', _$tempMin, key: 'temp_min');
  static double _$tempMax(WeatherParams v) => v.tempMax;
  static const Field<WeatherParams, double> _f$tempMax =
      Field('tempMax', _$tempMax, key: 'temp_max');

  @override
  final Map<Symbol, Field<WeatherParams, dynamic>> fields = const {
    #temp: _f$temp,
    #tempMin: _f$tempMin,
    #tempMax: _f$tempMax,
  };

  static WeatherParams _instantiate(DecodingData data) {
    return WeatherParams(
        temp: data.dec(_f$temp),
        tempMin: data.dec(_f$tempMin),
        tempMax: data.dec(_f$tempMax));
  }

  @override
  final Function instantiate = _instantiate;

  static WeatherParams fromMap(Map<String, dynamic> map) {
    return _guard((c) => c.fromMap<WeatherParams>(map));
  }

  static WeatherParams fromJson(String json) {
    return _guard((c) => c.fromJson<WeatherParams>(json));
  }
}

mixin WeatherParamsMappable {
  String toJson() {
    return WeatherParamsMapper._guard((c) => c.toJson(this as WeatherParams));
  }

  Map<String, dynamic> toMap() {
    return WeatherParamsMapper._guard((c) => c.toMap(this as WeatherParams));
  }

  WeatherParamsCopyWith<WeatherParams, WeatherParams, WeatherParams>
      get copyWith => _WeatherParamsCopyWithImpl(
          this as WeatherParams, $identity, $identity);
  @override
  String toString() {
    return WeatherParamsMapper._guard((c) => c.asString(this));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            WeatherParamsMapper._guard((c) => c.isEqual(this, other)));
  }

  @override
  int get hashCode {
    return WeatherParamsMapper._guard((c) => c.hash(this));
  }
}

extension WeatherParamsValueCopy<$R, $Out>
    on ObjectCopyWith<$R, WeatherParams, $Out> {
  WeatherParamsCopyWith<$R, WeatherParams, $Out> get $asWeatherParams =>
      $base.as((v, t, t2) => _WeatherParamsCopyWithImpl(v, t, t2));
}

abstract class WeatherParamsCopyWith<$R, $In extends WeatherParams, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({double? temp, double? tempMin, double? tempMax});
  WeatherParamsCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _WeatherParamsCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, WeatherParams, $Out>
    implements WeatherParamsCopyWith<$R, WeatherParams, $Out> {
  _WeatherParamsCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<WeatherParams> $mapper =
      WeatherParamsMapper.ensureInitialized();
  @override
  $R call({double? temp, double? tempMin, double? tempMax}) =>
      $apply(FieldCopyWithData({
        if (temp != null) #temp: temp,
        if (tempMin != null) #tempMin: tempMin,
        if (tempMax != null) #tempMax: tempMax
      }));
  @override
  WeatherParams $make(CopyWithData data) => WeatherParams(
      temp: data.get(#temp, or: $value.temp),
      tempMin: data.get(#tempMin, or: $value.tempMin),
      tempMax: data.get(#tempMax, or: $value.tempMax));

  @override
  WeatherParamsCopyWith<$R2, WeatherParams, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _WeatherParamsCopyWithImpl($value, $cast, t);
}

class WeatherInfoMapper extends ClassMapperBase<WeatherInfo> {
  WeatherInfoMapper._();

  static WeatherInfoMapper? _instance;
  static WeatherInfoMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = WeatherInfoMapper._());
    }
    return _instance!;
  }

  static T _guard<T>(T Function(MapperContainer) fn) {
    ensureInitialized();
    return fn(MapperContainer.globals);
  }

  @override
  final String id = 'WeatherInfo';

  static String _$main(WeatherInfo v) => v.main;
  static const Field<WeatherInfo, String> _f$main = Field('main', _$main);
  static String _$description(WeatherInfo v) => v.description;
  static const Field<WeatherInfo, String> _f$description =
      Field('description', _$description);
  static String _$icon(WeatherInfo v) => v.icon;
  static const Field<WeatherInfo, String> _f$icon = Field('icon', _$icon);

  @override
  final Map<Symbol, Field<WeatherInfo, dynamic>> fields = const {
    #main: _f$main,
    #description: _f$description,
    #icon: _f$icon,
  };

  static WeatherInfo _instantiate(DecodingData data) {
    return WeatherInfo(
        main: data.dec(_f$main),
        description: data.dec(_f$description),
        icon: data.dec(_f$icon));
  }

  @override
  final Function instantiate = _instantiate;

  static WeatherInfo fromMap(Map<String, dynamic> map) {
    return _guard((c) => c.fromMap<WeatherInfo>(map));
  }

  static WeatherInfo fromJson(String json) {
    return _guard((c) => c.fromJson<WeatherInfo>(json));
  }
}

mixin WeatherInfoMappable {
  String toJson() {
    return WeatherInfoMapper._guard((c) => c.toJson(this as WeatherInfo));
  }

  Map<String, dynamic> toMap() {
    return WeatherInfoMapper._guard((c) => c.toMap(this as WeatherInfo));
  }

  WeatherInfoCopyWith<WeatherInfo, WeatherInfo, WeatherInfo> get copyWith =>
      _WeatherInfoCopyWithImpl(this as WeatherInfo, $identity, $identity);
  @override
  String toString() {
    return WeatherInfoMapper._guard((c) => c.asString(this));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            WeatherInfoMapper._guard((c) => c.isEqual(this, other)));
  }

  @override
  int get hashCode {
    return WeatherInfoMapper._guard((c) => c.hash(this));
  }
}

extension WeatherInfoValueCopy<$R, $Out>
    on ObjectCopyWith<$R, WeatherInfo, $Out> {
  WeatherInfoCopyWith<$R, WeatherInfo, $Out> get $asWeatherInfo =>
      $base.as((v, t, t2) => _WeatherInfoCopyWithImpl(v, t, t2));
}

abstract class WeatherInfoCopyWith<$R, $In extends WeatherInfo, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? main, String? description, String? icon});
  WeatherInfoCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _WeatherInfoCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, WeatherInfo, $Out>
    implements WeatherInfoCopyWith<$R, WeatherInfo, $Out> {
  _WeatherInfoCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<WeatherInfo> $mapper =
      WeatherInfoMapper.ensureInitialized();
  @override
  $R call({String? main, String? description, String? icon}) =>
      $apply(FieldCopyWithData({
        if (main != null) #main: main,
        if (description != null) #description: description,
        if (icon != null) #icon: icon
      }));
  @override
  WeatherInfo $make(CopyWithData data) => WeatherInfo(
      main: data.get(#main, or: $value.main),
      description: data.get(#description, or: $value.description),
      icon: data.get(#icon, or: $value.icon));

  @override
  WeatherInfoCopyWith<$R2, WeatherInfo, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _WeatherInfoCopyWithImpl($value, $cast, t);
}

class WeatherMapper extends ClassMapperBase<Weather> {
  WeatherMapper._();

  static WeatherMapper? _instance;
  static WeatherMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = WeatherMapper._());
      WeatherParamsMapper.ensureInitialized();
      WeatherInfoMapper.ensureInitialized();
    }
    return _instance!;
  }

  static T _guard<T>(T Function(MapperContainer) fn) {
    ensureInitialized();
    return fn(MapperContainer.globals);
  }

  @override
  final String id = 'Weather';

  static WeatherParams _$weatherParams(Weather v) => v.weatherParams;
  static const Field<Weather, WeatherParams> _f$weatherParams =
      Field('weatherParams', _$weatherParams, key: 'main');
  static List<WeatherInfo> _$weatherInfo(Weather v) => v.weatherInfo;
  static const Field<Weather, List<WeatherInfo>> _f$weatherInfo =
      Field('weatherInfo', _$weatherInfo, key: 'weather');
  static int _$dt(Weather v) => v.dt;
  static const Field<Weather, int> _f$dt = Field('dt', _$dt);

  @override
  final Map<Symbol, Field<Weather, dynamic>> fields = const {
    #weatherParams: _f$weatherParams,
    #weatherInfo: _f$weatherInfo,
    #dt: _f$dt,
  };

  static Weather _instantiate(DecodingData data) {
    return Weather(
        weatherParams: data.dec(_f$weatherParams),
        weatherInfo: data.dec(_f$weatherInfo),
        dt: data.dec(_f$dt));
  }

  @override
  final Function instantiate = _instantiate;

  static Weather fromMap(Map<String, dynamic> map) {
    return _guard((c) => c.fromMap<Weather>(map));
  }

  static Weather fromJson(String json) {
    return _guard((c) => c.fromJson<Weather>(json));
  }
}

mixin WeatherMappable {
  String toJson() {
    return WeatherMapper._guard((c) => c.toJson(this as Weather));
  }

  Map<String, dynamic> toMap() {
    return WeatherMapper._guard((c) => c.toMap(this as Weather));
  }

  WeatherCopyWith<Weather, Weather, Weather> get copyWith =>
      _WeatherCopyWithImpl(this as Weather, $identity, $identity);
  @override
  String toString() {
    return WeatherMapper._guard((c) => c.asString(this));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            WeatherMapper._guard((c) => c.isEqual(this, other)));
  }

  @override
  int get hashCode {
    return WeatherMapper._guard((c) => c.hash(this));
  }
}

extension WeatherValueCopy<$R, $Out> on ObjectCopyWith<$R, Weather, $Out> {
  WeatherCopyWith<$R, Weather, $Out> get $asWeather =>
      $base.as((v, t, t2) => _WeatherCopyWithImpl(v, t, t2));
}

abstract class WeatherCopyWith<$R, $In extends Weather, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  WeatherParamsCopyWith<$R, WeatherParams, WeatherParams> get weatherParams;
  ListCopyWith<$R, WeatherInfo,
      WeatherInfoCopyWith<$R, WeatherInfo, WeatherInfo>> get weatherInfo;
  $R call(
      {WeatherParams? weatherParams, List<WeatherInfo>? weatherInfo, int? dt});
  WeatherCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _WeatherCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, Weather, $Out>
    implements WeatherCopyWith<$R, Weather, $Out> {
  _WeatherCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Weather> $mapper =
      WeatherMapper.ensureInitialized();
  @override
  WeatherParamsCopyWith<$R, WeatherParams, WeatherParams> get weatherParams =>
      $value.weatherParams.copyWith.$chain((v) => call(weatherParams: v));
  @override
  ListCopyWith<$R, WeatherInfo,
          WeatherInfoCopyWith<$R, WeatherInfo, WeatherInfo>>
      get weatherInfo => ListCopyWith($value.weatherInfo,
          (v, t) => v.copyWith.$chain(t), (v) => call(weatherInfo: v));
  @override
  $R call(
          {WeatherParams? weatherParams,
          List<WeatherInfo>? weatherInfo,
          int? dt}) =>
      $apply(FieldCopyWithData({
        if (weatherParams != null) #weatherParams: weatherParams,
        if (weatherInfo != null) #weatherInfo: weatherInfo,
        if (dt != null) #dt: dt
      }));
  @override
  Weather $make(CopyWithData data) => Weather(
      weatherParams: data.get(#weatherParams, or: $value.weatherParams),
      weatherInfo: data.get(#weatherInfo, or: $value.weatherInfo),
      dt: data.get(#dt, or: $value.dt));

  @override
  WeatherCopyWith<$R2, Weather, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _WeatherCopyWithImpl($value, $cast, t);
}
