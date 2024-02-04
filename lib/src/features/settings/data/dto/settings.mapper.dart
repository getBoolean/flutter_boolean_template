// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'settings.dart';

class SettingsMapper extends ClassMapperBase<Settings> {
  SettingsMapper._();

  static SettingsMapper? _instance;
  static SettingsMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SettingsMapper._());
      NavigationTypeOverrideMapper.ensureInitialized();
      ThemeTypeMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'Settings';

  static bool _$bannerEnabled(Settings v) => v.bannerEnabled;
  static const Field<Settings, bool> _f$bannerEnabled =
      Field('bannerEnabled', _$bannerEnabled, opt: true, def: true);
  static NavigationTypeOverride _$portraitNavigationTypeOverride(Settings v) =>
      v.portraitNavigationTypeOverride;
  static const Field<Settings, NavigationTypeOverride>
      _f$portraitNavigationTypeOverride = Field(
          'portraitNavigationTypeOverride', _$portraitNavigationTypeOverride,
          opt: true, def: NavigationTypeOverride.auto);
  static NavigationTypeOverride _$landscapeNavigationTypeOverride(Settings v) =>
      v.landscapeNavigationTypeOverride;
  static const Field<Settings, NavigationTypeOverride>
      _f$landscapeNavigationTypeOverride = Field(
          'landscapeNavigationTypeOverride', _$landscapeNavigationTypeOverride,
          opt: true, def: NavigationTypeOverride.auto);
  static ThemeType _$themeType(Settings v) => v.themeType;
  static const Field<Settings, ThemeType> _f$themeType =
      Field('themeType', _$themeType, opt: true, def: ThemeType.system);
  static FlexSchemeData _$lightTheme(Settings v) => v.lightTheme;
  static const Field<Settings, FlexSchemeData> _f$lightTheme =
      Field('lightTheme', _$lightTheme, opt: true, def: FlexColor.flutterDash);
  static FlexSchemeData _$darkTheme(Settings v) => v.darkTheme;
  static const Field<Settings, FlexSchemeData> _f$darkTheme =
      Field('darkTheme', _$darkTheme, opt: true, def: FlexColor.bahamaBlue);

  @override
  final MappableFields<Settings> fields = const {
    #bannerEnabled: _f$bannerEnabled,
    #portraitNavigationTypeOverride: _f$portraitNavigationTypeOverride,
    #landscapeNavigationTypeOverride: _f$landscapeNavigationTypeOverride,
    #themeType: _f$themeType,
    #lightTheme: _f$lightTheme,
    #darkTheme: _f$darkTheme,
  };

  static Settings _instantiate(DecodingData data) {
    return Settings(
        bannerEnabled: data.dec(_f$bannerEnabled),
        portraitNavigationTypeOverride:
            data.dec(_f$portraitNavigationTypeOverride),
        landscapeNavigationTypeOverride:
            data.dec(_f$landscapeNavigationTypeOverride),
        themeType: data.dec(_f$themeType),
        lightTheme: data.dec(_f$lightTheme),
        darkTheme: data.dec(_f$darkTheme));
  }

  @override
  final Function instantiate = _instantiate;

  static Settings fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Settings>(map);
  }

  static Settings fromJson(String json) {
    return ensureInitialized().decodeJson<Settings>(json);
  }
}

mixin SettingsMappable {
  String toJson() {
    return SettingsMapper.ensureInitialized()
        .encodeJson<Settings>(this as Settings);
  }

  Map<String, dynamic> toMap() {
    return SettingsMapper.ensureInitialized()
        .encodeMap<Settings>(this as Settings);
  }

  SettingsCopyWith<Settings, Settings, Settings> get copyWith =>
      _SettingsCopyWithImpl(this as Settings, $identity, $identity);
  @override
  String toString() {
    return SettingsMapper.ensureInitialized().stringifyValue(this as Settings);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            SettingsMapper.ensureInitialized()
                .isValueEqual(this as Settings, other));
  }

  @override
  int get hashCode {
    return SettingsMapper.ensureInitialized().hashValue(this as Settings);
  }
}

extension SettingsValueCopy<$R, $Out> on ObjectCopyWith<$R, Settings, $Out> {
  SettingsCopyWith<$R, Settings, $Out> get $asSettings =>
      $base.as((v, t, t2) => _SettingsCopyWithImpl(v, t, t2));
}

abstract class SettingsCopyWith<$R, $In extends Settings, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call(
      {bool? bannerEnabled,
      NavigationTypeOverride? portraitNavigationTypeOverride,
      NavigationTypeOverride? landscapeNavigationTypeOverride,
      ThemeType? themeType,
      FlexSchemeData? lightTheme,
      FlexSchemeData? darkTheme});
  SettingsCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _SettingsCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, Settings, $Out>
    implements SettingsCopyWith<$R, Settings, $Out> {
  _SettingsCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Settings> $mapper =
      SettingsMapper.ensureInitialized();
  @override
  $R call(
          {bool? bannerEnabled,
          NavigationTypeOverride? portraitNavigationTypeOverride,
          NavigationTypeOverride? landscapeNavigationTypeOverride,
          ThemeType? themeType,
          FlexSchemeData? lightTheme,
          FlexSchemeData? darkTheme}) =>
      $apply(FieldCopyWithData({
        if (bannerEnabled != null) #bannerEnabled: bannerEnabled,
        if (portraitNavigationTypeOverride != null)
          #portraitNavigationTypeOverride: portraitNavigationTypeOverride,
        if (landscapeNavigationTypeOverride != null)
          #landscapeNavigationTypeOverride: landscapeNavigationTypeOverride,
        if (themeType != null) #themeType: themeType,
        if (lightTheme != null) #lightTheme: lightTheme,
        if (darkTheme != null) #darkTheme: darkTheme
      }));
  @override
  Settings $make(CopyWithData data) => Settings(
      bannerEnabled: data.get(#bannerEnabled, or: $value.bannerEnabled),
      portraitNavigationTypeOverride: data.get(#portraitNavigationTypeOverride,
          or: $value.portraitNavigationTypeOverride),
      landscapeNavigationTypeOverride: data.get(
          #landscapeNavigationTypeOverride,
          or: $value.landscapeNavigationTypeOverride),
      themeType: data.get(#themeType, or: $value.themeType),
      lightTheme: data.get(#lightTheme, or: $value.lightTheme),
      darkTheme: data.get(#darkTheme, or: $value.darkTheme));

  @override
  SettingsCopyWith<$R2, Settings, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _SettingsCopyWithImpl($value, $cast, t);
}
