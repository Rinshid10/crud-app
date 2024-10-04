import 'package:hive/hive.dart';

part 'student.g.dart';

@HiveType(typeId: 0)
class Student {
  @HiveField(0)
  int? id;

  @HiveField(1)
  String? name;
  @HiveField(2)
  String? classes;
  @HiveField(3)
  String? address;
  @HiveField(4)
  String? age;
  @HiveField(5)
  String? images;

  Student(
      {required this.name,
      required this.classes,
      required this.address,
      required this.age,
      required this.images,
      this.id});
}
