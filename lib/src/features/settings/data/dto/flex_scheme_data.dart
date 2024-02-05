import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

class FlexSchemeDataAdapter extends TypeAdapter<FlexSchemeData> {
  FlexSchemeDataAdapter();

  @override
  final int typeId = 4;

  @override
  FlexSchemeData read(BinaryReader reader) {
    final Map<dynamic, dynamic> themeMap = reader.readMap();
    return FlexSchemeDataConverter.fromMap(themeMap);
  }

  @override
  void write(BinaryWriter writer, FlexSchemeData obj) {
    final json = FlexSchemeDataConverter(obj).toJson();
    writer.writeMap(json);
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

class FlexSchemeDataConverter {
  const FlexSchemeDataConverter(this.schemeData);
  final FlexSchemeData schemeData;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'name': schemeData.name,
      'description': schemeData.description,
      'light': FlexSchemeColorConverter(schemeData.light).toJson(),
      'dark': FlexSchemeColorConverter(schemeData.dark).toJson(),
    };
  }

  static FlexSchemeData fromMap(Map<dynamic, dynamic> map) {
    return FlexSchemeData(
      name: map['name'] as String,
      description: map['description'] as String,
      light: FlexSchemeColorConverter.fromMap(
        map['light'] as Map<dynamic, dynamic>,
      ),
      dark: FlexSchemeColorConverter.fromMap(
        map['dark'] as Map<dynamic, dynamic>,
      ),
    );
  }
}

class FlexSchemeColorConverter {
  const FlexSchemeColorConverter(this.schemeColor);
  final FlexSchemeColor schemeColor;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'primary': schemeColor.primary.value,
      'primaryContainer': schemeColor.primaryContainer.value,
      'secondary': schemeColor.secondary.value,
      'secondaryContainer': schemeColor.secondaryContainer.value,
      'tertiary': schemeColor.tertiary.value,
      'tertiaryContainer': schemeColor.tertiaryContainer.value,
      'appBarColor': schemeColor.appBarColor?.value,
      'error': schemeColor.error?.value,
      'errorContainer': schemeColor.errorContainer?.value,
      'swapOnMaterial3': schemeColor.swapOnMaterial3,
    };
  }

  static FlexSchemeColor fromMap(Map<dynamic, dynamic> map) {
    return FlexSchemeColor(
      primary: Color(map['primary'] as int),
      primaryContainer: Color(map['primaryContainer'] as int),
      secondary: Color(map['secondary'] as int),
      secondaryContainer: Color(map['secondaryContainer'] as int),
      tertiary: Color(map['tertiary'] as int),
      tertiaryContainer: Color(map['tertiaryContainer'] as int),
      appBarColor:
          map['appBarColor'] == null ? null : Color(map['appBarColor'] as int),
      error: map['error'] == null ? null : Color(map['error'] as int),
      errorContainer: map['errorContainer'] == null
          ? null
          : Color(map['errorContainer'] as int),
      swapOnMaterial3: map['swapOnMaterial3'] as bool,
    );
  }
}
