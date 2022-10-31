import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../models.mapper.g.dart';

part 'union.freezed.dart';

@freezed
@MappableClass(discriminatorKey: 'type')
class Union with _$Union {
  @MappableClass(discriminatorValue: 'data')
  const factory Union.data(@MappableField(key: 'mykey') int value) = Data;
  @MappableClass(discriminatorValue: 'loading')
  const factory Union.loading() = Loading;
  @MappableClass(discriminatorValue: 'error')
  const factory Union.error([String? message]) = ErrorDetails;
}

void testUnion() {
  const data = Union.data(42);

  final dataJson = data.toJson();
  debugPrint(dataJson); // {"mykey":42,"type":"data"}

  final parsedData = Mapper.fromJson<Union>(dataJson);
  debugPrint(parsedData.toString()); // Union.data(value: 42)
}
