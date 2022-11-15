// ignore_for_file: unused_element
import 'package:dart_mappable/dart_mappable.dart';
import 'package:dart_mappable/internals.dart';

import 'person.dart' as p0;
import 'union.dart' as p1;


// === ALL STATICALLY REGISTERED MAPPERS ===

var _mappers = <BaseMapper>{
  // class mappers
  PersonMapper._(),
  UnionMapper._(),
  DataMapper._(),
  LoadingMapper._(),
  ErrorDetailsMapper._(),
  // enum mappers
  // custom mappers
};


// === GENERATED CLASS MAPPERS AND EXTENSIONS ===

class PersonMapper extends BaseMapper<p0.Person> {
  PersonMapper._();

  @override Function get decoder => decode;
  p0.Person decode(dynamic v) => checked(v, (Map<String, dynamic> map) => fromMap(map));
  p0.Person fromMap(Map<String, dynamic> map) => p0.Person(firstName: Mapper.i.$get(map, 'firstName'), lastName: Mapper.i.$get(map, 'lastName'), age: Mapper.i.$get(map, 'age'));

  @override Function get encoder => encode;
  dynamic encode(p0.Person v) => toMap(v);
  Map<String, dynamic> toMap(p0.Person p) => {'firstName': Mapper.i.$enc(p.firstName, 'firstName'), 'lastName': Mapper.i.$enc(p.lastName, 'lastName'), 'age': Mapper.i.$enc(p.age, 'age')};

  @override String stringify(p0.Person self) => 'Person(firstName: ${Mapper.asString(self.firstName)}, lastName: ${Mapper.asString(self.lastName)}, age: ${Mapper.asString(self.age)})';
  @override int hash(p0.Person self) => Mapper.hash(self.firstName) ^ Mapper.hash(self.lastName) ^ Mapper.hash(self.age);
  @override bool equals(p0.Person self, p0.Person other) => Mapper.isEqual(self.firstName, other.firstName) && Mapper.isEqual(self.lastName, other.lastName) && Mapper.isEqual(self.age, other.age);

  @override Function get typeFactory => (f) => f<p0.Person>();
}

mixin PersonMappable implements MappableMixin {
  String toJson() => Mapper.toJson(this as p0.Person);
  Map<String, dynamic> toMap() => Mapper.toMap(this as p0.Person);
  PersonCopyWith<p0.Person> get copyWith => _PersonCopyWithImpl(this as p0.Person, $identity, $identity);
  @override String toString() => Mapper.asString(this);
  @override bool operator ==(Object other) => identical(this, other) || (runtimeType == other.runtimeType && Mapper.isEqual(this, other));
  @override int get hashCode => Mapper.hash(this);
}

extension PersonObjectCopy<$R> on ObjectCopyWith<$R, p0.Person, p0.Person> {
  PersonCopyWith<$R> get asPerson => base.as((v, t, t2) => _PersonCopyWithImpl(v, t, t2));
}

abstract class PersonCopyWith<$R> implements ObjectCopyWith<$R, p0.Person, p0.Person> {
  PersonCopyWith<$R2> _chain<$R2>(Then<p0.Person, p0.Person> t, Then<p0.Person, $R2> t2);
  $R call({String? firstName, String? lastName, int? age});
}

class _PersonCopyWithImpl<$R> extends BaseCopyWith<$R, p0.Person, p0.Person> implements PersonCopyWith<$R> {
  _PersonCopyWithImpl(super.value, super.then, super.then2);
  @override PersonCopyWith<$R2> _chain<$R2>(Then<p0.Person, p0.Person> t, Then<p0.Person, $R2> t2) => _PersonCopyWithImpl($value, t, t2);

  @override $R call({String? firstName, String? lastName, int? age}) => $then(p0.Person(firstName: firstName ?? $value.firstName, lastName: lastName ?? $value.lastName, age: age ?? $value.age));
}

class UnionMapper extends BaseMapper<p1.Union> {
  UnionMapper._();

  @override Function get decoder => decode;
  p1.Union decode(dynamic v) => checked(v, (Map<String, dynamic> map) {
    switch(map['type']) {
      case 'data': return DataMapper._().decode(map);
      case 'error': return ErrorDetailsMapper._().decode(map);
      case 'loading': return LoadingMapper._().decode(map);
      default: return fromMap(map);
    }
  });
  p1.Union fromMap(Map<String, dynamic> map) => throw MapperException.missingSubclass('Union', 'type', '${map['type']}');

  @override Function get encoder => encode;
  dynamic encode(p1.Union v) => toMap(v);
  Map<String, dynamic> toMap(p1.Union u) => {};

  @override String stringify(p1.Union self) => 'Union()';
  @override int hash(p1.Union self) => 0;
  @override bool equals(p1.Union self, p1.Union other) => true;

  @override Function get typeFactory => (f) => f<p1.Union>();
}

extension UnionMapperExtension on p1.Union {
  String toJson() => Mapper.toJson(this);
  Map<String, dynamic> toMap() => Mapper.toMap(this);
}

abstract class UnionCopyWith<$R, $In extends p1.Union, $Out extends p1.Union> implements ObjectCopyWith<$R, $In, $Out> {
  UnionCopyWith<$R2, $In, $Out2> _chain<$R2, $Out2 extends p1.Union>(Then<p1.Union, $Out2> t, Then<$Out2, $R2> t2);
  $R call();
}


class DataMapper extends BaseMapper<p1.Data> {
  DataMapper._();

  @override Function get decoder => decode;
  p1.Data decode(dynamic v) => checked(v, (Map<String, dynamic> map) => fromMap(map));
  p1.Data fromMap(Map<String, dynamic> map) => p1.Data(Mapper.i.$get(map, 'mykey'));

  @override Function get encoder => encode;
  dynamic encode(p1.Data v) => toMap(v);
  Map<String, dynamic> toMap(p1.Data d) => {'mykey': Mapper.i.$enc(d.value, 'value'), 'type': 'data'};

  @override String stringify(p1.Data self) => 'Data()';
  @override int hash(p1.Data self) => 0;
  @override bool equals(p1.Data self, p1.Data other) => true;

  @override Function get typeFactory => (f) => f<p1.Data>();
}

extension DataMapperExtension on p1.Data {
  String toJson() => Mapper.toJson(this);
  Map<String, dynamic> toMap() => Mapper.toMap(this);
  DataCopyWith<p1.Data, p1.Data> get copyWith => _DataCopyWithImpl(this, $identity, $identity);
}

extension DataObjectCopy<$R, $Out extends p1.Union> on ObjectCopyWith<$R, p1.Data, $Out> {
  DataCopyWith<$R, $Out> get asData => base.as((v, t, t2) => _DataCopyWithImpl(v, t, t2));
}

abstract class DataCopyWith<$R, $Out extends p1.Union> implements UnionCopyWith<$R, p1.Data, $Out> {
  DataCopyWith<$R2, $Out2> _chain<$R2, $Out2 extends p1.Union>(Then<p1.Data, $Out2> t, Then<$Out2, $R2> t2);
  @override $R call({int? value});
}

class _DataCopyWithImpl<$R, $Out extends p1.Union> extends BaseCopyWith<$R, p1.Data, $Out> implements DataCopyWith<$R, $Out> {
  _DataCopyWithImpl(super.value, super.then, super.then2);
  @override DataCopyWith<$R2, $Out2> _chain<$R2, $Out2 extends p1.Union>(Then<p1.Data, $Out2> t, Then<$Out2, $R2> t2) => _DataCopyWithImpl($value, t, t2);

  @override $R call({int? value}) => $then(p1.Data(value ?? $value.value));
}

class LoadingMapper extends BaseMapper<p1.Loading> {
  LoadingMapper._();

  @override Function get decoder => decode;
  p1.Loading decode(dynamic v) => checked(v, (Map<String, dynamic> map) => fromMap(map));
  p1.Loading fromMap(Map<String, dynamic> map) => p1.Loading();

  @override Function get encoder => encode;
  dynamic encode(p1.Loading v) => toMap(v);
  Map<String, dynamic> toMap(p1.Loading l) => {'type': 'loading'};

  @override String stringify(p1.Loading self) => 'Loading()';
  @override int hash(p1.Loading self) => 0;
  @override bool equals(p1.Loading self, p1.Loading other) => true;

  @override Function get typeFactory => (f) => f<p1.Loading>();
}

extension LoadingMapperExtension on p1.Loading {
  String toJson() => Mapper.toJson(this);
  Map<String, dynamic> toMap() => Mapper.toMap(this);
  LoadingCopyWith<p1.Loading, p1.Loading> get copyWith => _LoadingCopyWithImpl(this, $identity, $identity);
}

extension LoadingObjectCopy<$R, $Out extends p1.Union> on ObjectCopyWith<$R, p1.Loading, $Out> {
  LoadingCopyWith<$R, $Out> get asLoading => base.as((v, t, t2) => _LoadingCopyWithImpl(v, t, t2));
}

abstract class LoadingCopyWith<$R, $Out extends p1.Union> implements UnionCopyWith<$R, p1.Loading, $Out> {
  LoadingCopyWith<$R2, $Out2> _chain<$R2, $Out2 extends p1.Union>(Then<p1.Loading, $Out2> t, Then<$Out2, $R2> t2);
  @override $R call();
}

class _LoadingCopyWithImpl<$R, $Out extends p1.Union> extends BaseCopyWith<$R, p1.Loading, $Out> implements LoadingCopyWith<$R, $Out> {
  _LoadingCopyWithImpl(super.value, super.then, super.then2);
  @override LoadingCopyWith<$R2, $Out2> _chain<$R2, $Out2 extends p1.Union>(Then<p1.Loading, $Out2> t, Then<$Out2, $R2> t2) => _LoadingCopyWithImpl($value, t, t2);

  @override $R call() => $then(p1.Loading());
}

class ErrorDetailsMapper extends BaseMapper<p1.ErrorDetails> {
  ErrorDetailsMapper._();

  @override Function get decoder => decode;
  p1.ErrorDetails decode(dynamic v) => checked(v, (Map<String, dynamic> map) => fromMap(map));
  p1.ErrorDetails fromMap(Map<String, dynamic> map) => p1.ErrorDetails(Mapper.i.$getOpt(map, 'message'));

  @override Function get encoder => encode;
  dynamic encode(p1.ErrorDetails v) => toMap(v);
  Map<String, dynamic> toMap(p1.ErrorDetails e) => {'message': Mapper.i.$enc(e.message, 'message'), 'type': 'error'};

  @override String stringify(p1.ErrorDetails self) => 'ErrorDetails()';
  @override int hash(p1.ErrorDetails self) => 0;
  @override bool equals(p1.ErrorDetails self, p1.ErrorDetails other) => true;

  @override Function get typeFactory => (f) => f<p1.ErrorDetails>();
}

extension ErrorDetailsMapperExtension on p1.ErrorDetails {
  String toJson() => Mapper.toJson(this);
  Map<String, dynamic> toMap() => Mapper.toMap(this);
  ErrorDetailsCopyWith<p1.ErrorDetails, p1.ErrorDetails> get copyWith => _ErrorDetailsCopyWithImpl(this, $identity, $identity);
}

extension ErrorDetailsObjectCopy<$R, $Out extends p1.Union> on ObjectCopyWith<$R, p1.ErrorDetails, $Out> {
  ErrorDetailsCopyWith<$R, $Out> get asErrorDetails => base.as((v, t, t2) => _ErrorDetailsCopyWithImpl(v, t, t2));
}

abstract class ErrorDetailsCopyWith<$R, $Out extends p1.Union> implements UnionCopyWith<$R, p1.ErrorDetails, $Out> {
  ErrorDetailsCopyWith<$R2, $Out2> _chain<$R2, $Out2 extends p1.Union>(Then<p1.ErrorDetails, $Out2> t, Then<$Out2, $R2> t2);
  @override $R call({String? message});
}

class _ErrorDetailsCopyWithImpl<$R, $Out extends p1.Union> extends BaseCopyWith<$R, p1.ErrorDetails, $Out> implements ErrorDetailsCopyWith<$R, $Out> {
  _ErrorDetailsCopyWithImpl(super.value, super.then, super.then2);
  @override ErrorDetailsCopyWith<$R2, $Out2> _chain<$R2, $Out2 extends p1.Union>(Then<p1.ErrorDetails, $Out2> t, Then<$Out2, $R2> t2) => _ErrorDetailsCopyWithImpl($value, t, t2);

  @override $R call({Object? message = $none}) => $then(p1.ErrorDetails(or(message, $value.message)));
}


// === GENERATED ENUM MAPPERS AND EXTENSIONS ===




// === GENERATED UTILITY CODE ===

class Mapper {
  Mapper._();

  static MapperContainer i = MapperContainer(_mappers);

  static T fromValue<T>(dynamic value) => i.fromValue<T>(value);
  static T fromMap<T>(Map<String, dynamic> map) => i.fromMap<T>(map);
  static T fromIterable<T>(Iterable<dynamic> iterable) => i.fromIterable<T>(iterable);
  static T fromJson<T>(String json) => i.fromJson<T>(json);

  static dynamic toValue<T>(T value) => i.toValue<T>(value);
  static Map<String, dynamic> toMap<T>(T object) => i.toMap<T>(object);
  static Iterable<dynamic> toIterable<T>(T object) => i.toIterable<T>(object);
  static String toJson<T>(T object) => i.toJson<T>(object);

  static bool isEqual(dynamic value, Object? other) => i.isEqual(value, other);
  static int hash(dynamic value) => i.hash(value);
  static String asString(dynamic value) => i.asString(value);

  static void use<T>(BaseMapper<T> mapper) => i.use<T>(mapper);
  static BaseMapper<T>? unuse<T>() => i.unuse<T>();
  static void useAll(List<BaseMapper> mappers) => i.useAll(mappers);

  static BaseMapper<T>? get<T>([Type? type]) => i.get<T>(type);
  static List<BaseMapper> getAll() => i.getAll();
}

extension _ChainedCopyWith<Result, In, Out> on ObjectCopyWith<Result, In, Out> {
  BaseCopyWith<Result, In, Out> get base => this as BaseCopyWith<Result, In, Out>;
}
