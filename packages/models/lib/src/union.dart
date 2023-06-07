import 'package:dart_mappable/dart_mappable.dart';

part 'union.mapper.dart';

@MappableClass(discriminatorKey: 'union_type')
abstract class Union with UnionMappable {
  const Union();
  const factory Union.data() = UnionData;
  const factory Union.loading() = UnionLoading;
  const factory Union.error() = UnionError;
}

@MappableClass(discriminatorValue: 'union_data')
class UnionData extends Union with UnionDataMappable {
  const UnionData();
}

@MappableClass(discriminatorValue: 'union_loading')
class UnionLoading extends Union with UnionLoadingMappable {
  const UnionLoading();
}

@MappableClass(discriminatorValue: 'union_error')
class UnionError extends Union with UnionErrorMappable {
  const UnionError();
}
