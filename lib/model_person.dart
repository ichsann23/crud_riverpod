// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:uuid/uuid.dart';

class Person {
  final String name;
  final int age;
  final String uuid;
  Person({
    required this.name,
    required this.age,
    String? uuid,
  }) : uuid = uuid ?? const Uuid().v4();

  Person updated([String? name, int? age]) => Person(
        name: name ?? this.name,
        age: age ?? this.age,
        uuid: uuid,
      );

  String get displayName => '$name($age years old)';

  @override
  bool operator ==(covariant Person other) => uuid == other.uuid;
  @override
  int get hashCode => uuid.hashCode;
  @override
  String toString() => 'Person(name:$name, age:$age, uuid:$uuid)';
}
