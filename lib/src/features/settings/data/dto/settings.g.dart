// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SettingsAdapter extends TypeAdapter<Settings> {
  @override
  final int typeId = 1;

  @override
  Settings read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Settings(
      bannerEnabled: fields[0] == null ? true : fields[0] as bool,
      darkMode: fields[1] == null ? true : fields[1] as bool,
      systemThemeMode: fields[2] == null ? true : fields[2] as bool,
      portraitNavigationTypeOverride: fields[3] == null
          ? NavigationTypeOverride.auto
          : fields[3] as NavigationTypeOverride,
      landscapeNavigationTypeOverride: fields[4] == null
          ? NavigationTypeOverride.auto
          : fields[4] as NavigationTypeOverride,
    );
  }

  @override
  void write(BinaryWriter writer, Settings obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.bannerEnabled)
      ..writeByte(1)
      ..write(obj.darkMode)
      ..writeByte(2)
      ..write(obj.systemThemeMode)
      ..writeByte(3)
      ..write(obj.portraitNavigationTypeOverride)
      ..writeByte(4)
      ..write(obj.landscapeNavigationTypeOverride);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SettingsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
