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
      portraitNavigationTypeOverride: fields[3] == null
          ? NavigationTypeOverride.auto
          : fields[3] as NavigationTypeOverride,
      landscapeNavigationTypeOverride: fields[4] == null
          ? NavigationTypeOverride.auto
          : fields[4] as NavigationTypeOverride,
      themeType: fields[5] == null ? ThemeType.system : fields[5] as ThemeType,
      lightTheme: fields[6] == null
          ? const FlexSchemeData(
              name: 'Flutter Dash',
              description: 'Flutter Dash wallpaper based theme',
              light: const FlexSchemeColor(
                  primary: const Color(4282685152),
                  primaryContainer: const Color(4290045695),
                  secondary: const Color(4280298349),
                  secondaryContainer: const Color(4288269561),
                  tertiary: const Color(4283515449),
                  tertiaryContainer: const Color(4290423197),
                  appBarColor: const Color(4283515449),
                  error: const Color(4289724448)),
              dark: const FlexSchemeColor(
                  primary: const Color(4290045695),
                  primaryContainer: const Color(4280192987),
                  secondary: const Color(4288269561),
                  secondaryContainer: const Color(4280298349),
                  tertiary: const Color(4290423197),
                  tertiaryContainer: const Color(4283515449),
                  appBarColor: const Color(4290423197),
                  error: const Color(4291782265)))
          : fields[6] as FlexSchemeData,
      darkTheme: fields[7] == null
          ? const FlexSchemeData(
              name: 'Bahama and trinidad',
              description: 'Bahama blue and trinidad orange colored theme',
              light: const FlexSchemeColor(
                  primary: const Color(4278803870),
                  primaryContainer: const Color(4289121517),
                  secondary: const Color(4292694543),
                  secondaryContainer: const Color(4294958029),
                  tertiary: const Color(4286367992),
                  tertiaryContainer: const Color(4291160063),
                  appBarColor: const Color(4286367992),
                  error: const Color(4289724448),
                  swapOnMaterial3: true),
              dark: const FlexSchemeColor(
                  primary: const Color(4282746293),
                  primaryContainer: const Color(4278803870),
                  secondary: const Color(4293229642),
                  secondaryContainer: const Color(4292694543),
                  tertiary: const Color(4288468473),
                  tertiaryContainer: const Color(4282020498),
                  appBarColor: const Color(4288468473),
                  error: const Color(4291782265),
                  swapOnMaterial3: true))
          : fields[7] as FlexSchemeData,
      customThemes:
          fields[8] == null ? [] : (fields[8] as List).cast<FlexSchemeData>(),
    );
  }

  @override
  void write(BinaryWriter writer, Settings obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.bannerEnabled)
      ..writeByte(3)
      ..write(obj.portraitNavigationTypeOverride)
      ..writeByte(4)
      ..write(obj.landscapeNavigationTypeOverride)
      ..writeByte(5)
      ..write(obj.themeType)
      ..writeByte(6)
      ..write(obj.lightTheme)
      ..writeByte(7)
      ..write(obj.darkTheme)
      ..writeByte(8)
      ..write(obj.customThemes);
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
