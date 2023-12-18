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
    }
    return _instance!;
  }

  @override
  final String id = 'Settings';

  static bool _$bannerEnabled(Settings v) => v.bannerEnabled;
  static const Field<Settings, bool> _f$bannerEnabled =
      Field('bannerEnabled', _$bannerEnabled, opt: true, def: true);
  static bool _$darkMode(Settings v) => v.darkMode;
  static const Field<Settings, bool> _f$darkMode =
      Field('darkMode', _$darkMode, opt: true, def: true);
  static bool _$systemThemeMode(Settings v) => v.systemThemeMode;
  static const Field<Settings, bool> _f$systemThemeMode =
      Field('systemThemeMode', _$systemThemeMode, opt: true, def: true);
  static bool _$confirmExit(Settings v) => v.confirmExit;
  static const Field<Settings, bool> _f$confirmExit =
      Field('confirmExit', _$confirmExit, opt: true, def: true);

  @override
  final Map<Symbol, Field<Settings, dynamic>> fields = const {
    #bannerEnabled: _f$bannerEnabled,
    #darkMode: _f$darkMode,
    #systemThemeMode: _f$systemThemeMode,
    #confirmExit: _f$confirmExit,
  };

  static Settings _instantiate(DecodingData data) {
    return Settings(
        bannerEnabled: data.dec(_f$bannerEnabled),
        darkMode: data.dec(_f$darkMode),
        systemThemeMode: data.dec(_f$systemThemeMode),
        confirmExit: data.dec(_f$confirmExit));
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
      bool? darkMode,
      bool? systemThemeMode,
      bool? confirmExit});
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
          bool? darkMode,
          bool? systemThemeMode,
          bool? confirmExit}) =>
      $apply(FieldCopyWithData({
        if (bannerEnabled != null) #bannerEnabled: bannerEnabled,
        if (darkMode != null) #darkMode: darkMode,
        if (systemThemeMode != null) #systemThemeMode: systemThemeMode,
        if (confirmExit != null) #confirmExit: confirmExit
      }));
  @override
  Settings $make(CopyWithData data) => Settings(
      bannerEnabled: data.get(#bannerEnabled, or: $value.bannerEnabled),
      darkMode: data.get(#darkMode, or: $value.darkMode),
      systemThemeMode: data.get(#systemThemeMode, or: $value.systemThemeMode),
      confirmExit: data.get(#confirmExit, or: $value.confirmExit));

  @override
  SettingsCopyWith<$R2, Settings, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _SettingsCopyWithImpl($value, $cast, t);
}
