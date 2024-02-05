// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_type.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ThemeTypeAdapter extends TypeAdapter<ThemeType> {
  @override
  final int typeId = 3;

  @override
  ThemeType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return ThemeType.light;
      case 1:
        return ThemeType.dark;
      case 2:
        return ThemeType.system;
      default:
        return ThemeType.light;
    }
  }

  @override
  void write(BinaryWriter writer, ThemeType obj) {
    switch (obj) {
      case ThemeType.light:
        writer.writeByte(0);
        break;
      case ThemeType.dark:
        writer.writeByte(1);
        break;
      case ThemeType.system:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ThemeTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
