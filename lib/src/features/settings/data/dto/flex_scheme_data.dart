import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:hive_flutter/adapters.dart';

class FlexSchemeDataAdapter extends TypeAdapter<FlexSchemeData> {
  FlexSchemeDataAdapter(this.themes);

  final List<FlexSchemeData> themes;

  @override
  final int typeId = 4;

  @override
  FlexSchemeData read(BinaryReader reader) {
    final name = reader.readString();
    return themes.firstWhere((element) {
      return element.name == name;
    });
  }

  @override
  void write(BinaryWriter writer, FlexSchemeData obj) {
    writer.writeString(obj.name);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FlexSchemeDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
