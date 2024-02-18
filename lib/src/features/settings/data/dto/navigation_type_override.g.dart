// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'navigation_type_override.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NavigationTypeOverrideAdapter
    extends TypeAdapter<NavigationTypeOverride> {
  @override
  final int typeId = 2;

  @override
  NavigationTypeOverride read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return NavigationTypeOverride.auto;
      case 1:
        return NavigationTypeOverride.bottom;
      case 3:
        return NavigationTypeOverride.drawer;
      case 4:
        return NavigationTypeOverride.sidebar;
      case 5:
        return NavigationTypeOverride.top;
      default:
        return NavigationTypeOverride.auto;
    }
  }

  @override
  void write(BinaryWriter writer, NavigationTypeOverride obj) {
    switch (obj) {
      case NavigationTypeOverride.auto:
        writer.writeByte(0);
        break;
      case NavigationTypeOverride.bottom:
        writer.writeByte(1);
        break;
      case NavigationTypeOverride.drawer:
        writer.writeByte(3);
        break;
      case NavigationTypeOverride.sidebar:
        writer.writeByte(4);
        break;
      case NavigationTypeOverride.top:
        writer.writeByte(5);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NavigationTypeOverrideAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
