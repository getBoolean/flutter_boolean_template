import 'package:dart_mappable/dart_mappable.dart';

part 'location_history.mapper.dart';

/// Source: @cgestes https://github.com/flutter/flutter/issues/115353#issuecomment-1675808675
@MappableClass()
class LocationHistory with LocationHistoryMappable {
  @MappableField()
  final List<String> history;
  @MappableField()
  final List<String> popped;

  /// Source: @cgestes https://github.com/flutter/flutter/issues/115353#issuecomment-1675808675
  const LocationHistory({
    this.history = const [],
    this.popped = const [],
  });

  bool hasForward() {
    return popped.isNotEmpty;
  }

  bool hasBackward() {
    return history.length > 1;
  }

  static const fromMap = LocationHistoryMapper.fromMap;
  static const fromJson = LocationHistoryMapper.fromJson;
}
