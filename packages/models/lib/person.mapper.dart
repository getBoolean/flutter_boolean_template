// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element

part of 'person.dart';

class PersonMapper extends MapperBase<Person> {
  static MapperContainer container = MapperContainer(
    mappers: {PersonMapper()},
  );

  @override
  PersonMapperElement createElement(MapperContainer container) {
    return PersonMapperElement._(this, container);
  }

  @override
  String get id => 'Person';

  static final fromMap = container.fromMap<Person>;
  static final fromJson = container.fromJson<Person>;
}

class PersonMapperElement extends MapperElementBase<Person> {
  PersonMapperElement._(super.mapper, super.container);

  @override
  Function get decoder => decode;
  Person decode(dynamic v) =>
      checkedType(v, (Map<String, dynamic> map) => fromMap(map));
  Person fromMap(Map<String, dynamic> map) => Person(
      firstName: container.$get(map, 'firstName'),
      lastName: container.$get(map, 'lastName'),
      age: container.$get(map, 'age'));

  @override
  Function get encoder => encode;
  dynamic encode(Person v) => toMap(v);
  Map<String, dynamic> toMap(Person p) => {
        'firstName': container.$enc(p.firstName, 'firstName'),
        'lastName': container.$enc(p.lastName, 'lastName'),
        'age': container.$enc(p.age, 'age')
      };

  @override
  String stringify(Person self) =>
      'Person(firstName: ${container.asString(self.firstName)}, lastName: ${container.asString(self.lastName)}, age: ${container.asString(self.age)})';
  @override
  int hash(Person self) =>
      container.hash(self.firstName) ^
      container.hash(self.lastName) ^
      container.hash(self.age);
  @override
  bool equals(Person self, Person other) =>
      container.isEqual(self.firstName, other.firstName) &&
      container.isEqual(self.lastName, other.lastName) &&
      container.isEqual(self.age, other.age);
}

mixin PersonMappable {
  String toJson() => PersonMapper.container.toJson(this as Person);
  Map<String, dynamic> toMap() => PersonMapper.container.toMap(this as Person);
  PersonCopyWith<Person, Person, Person> get copyWith =>
      _PersonCopyWithImpl(this as Person, $identity, $identity);
  @override
  String toString() => PersonMapper.container.asString(this);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (runtimeType == other.runtimeType &&
          PersonMapper.container.isEqual(this, other));
  @override
  int get hashCode => PersonMapper.container.hash(this);
}

extension PersonValueCopy<$R, $Out extends Person>
    on ObjectCopyWith<$R, Person, $Out> {
  PersonCopyWith<$R, Person, $Out> get asPerson =>
      base.as((v, t, t2) => _PersonCopyWithImpl(v, t, t2));
}

typedef PersonCopyWithBound = Person;

abstract class PersonCopyWith<$R, $In extends Person, $Out extends Person>
    implements ObjectCopyWith<$R, $In, $Out> {
  PersonCopyWith<$R2, $In, $Out2> chain<$R2, $Out2 extends Person>(
      Then<Person, $Out2> t, Then<$Out2, $R2> t2);
  $R call({String? firstName, String? lastName, int? age});
}

class _PersonCopyWithImpl<$R, $Out extends Person>
    extends CopyWithBase<$R, Person, $Out>
    implements PersonCopyWith<$R, Person, $Out> {
  _PersonCopyWithImpl(super.value, super.then, super.then2);
  @override
  PersonCopyWith<$R2, Person, $Out2> chain<$R2, $Out2 extends Person>(
          Then<Person, $Out2> t, Then<$Out2, $R2> t2) =>
      _PersonCopyWithImpl($value, t, t2);

  @override
  $R call({String? firstName, String? lastName, int? age}) => $then(Person(
      firstName: firstName ?? $value.firstName,
      lastName: lastName ?? $value.lastName,
      age: age ?? $value.age));
}
