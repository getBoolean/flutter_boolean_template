import 'package:dart_mappable/dart_mappable.dart';
part 'person.mapper.dart';

@MappableClass()
class Person with PersonMappable {
  const Person({
    @MappableField(key: 'first_name')
    required this.firstName,
    required this.lastName,
    required this.age,
  });

  factory Person.fromJson(String json) => PersonMapper.fromJson(json);

  factory Person.fromMap(Map<String, Object?> map) => PersonMapper.fromMap(map);

  final String firstName;
  final String lastName;
  final int age;

  String testMethod() {
    return '$firstName $lastName says hello world';
  }
}
