import 'package:cread_app/modal/student.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

ValueNotifier<List<Student>> studentNotifier = ValueNotifier([]);

Future addStudentTolist(Student value) async {
  final studentDb = await Hive.openBox<Student>('save_data');
  studentDb.add(value);

  studentNotifier.value.add(value);

  studentNotifier.notifyListeners();
}

Future getAllStudent() async {
  final studentDb = await Hive.openBox<Student>('save_data');
  studentNotifier.value.clear();
  studentNotifier.value.addAll(studentDb.values);
  studentNotifier.notifyListeners();
}

Future deleteStudent(int index) async {
  final studentDb = await Hive.openBox<Student>('save_data');
  studentDb.deleteAt(index);
  getAllStudent();
}

Future<void> editing(index, Student value) async {
  final studentDb = await Hive.openBox<Student>('save_data');

  studentNotifier.value.clear();
  studentNotifier.value.addAll(studentDb.values);
  studentNotifier.notifyListeners();
  studentDb.putAt(index, value);
  getAllStudent();
}

