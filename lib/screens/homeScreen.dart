import 'dart:developer';
import 'dart:io';

import 'package:cread_app/database/functions.dart';
import 'package:cread_app/modal/student.dart';
import 'package:cread_app/screens/addStudent.dart';
import 'package:cread_app/screens/editStudent.dart';
import 'package:cread_app/screens/login/signUp.dart';
import 'package:cread_app/screens/studentView.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // File? _selectImage;
  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool("IsLoggedin", false);
    log("Data setted to is Logged in D=false");
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (ctx) => const Loginscreen()));
  }

  String search = '';
  List<Student> serchTheStudent = [];
  void searchNew() {
    getAllStudent();
    serchTheStudent = studentNotifier.value
        .where((filter) =>
            filter.name!.toLowerCase().contains(search.toLowerCase()))
        .toList();
  }

  @override
  void initState() {
    super.initState();
    getAllStudent();
  }

  @override
  Widget build(BuildContext context) {
    searchNew();

    return Scaffold(
      backgroundColor: Colors.teal[200],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (ctx) => const AddStudent()));
        },
        backgroundColor: Colors.teal[400],
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.only(left: 20),
          child: Icon(
            Icons.home,
            size: 35,
          ),
        ),
        backgroundColor: Colors.teal[400],
        title: Align(
          alignment: Alignment.center,
          child: Container(
            height: 40,
            width: 200,
            child: TextFormField(
              onChanged: (value) {
                setState(() {
                  search = value;
                  searchNew();
                });
              },
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.teal)),
                  suffixIcon: Icon(Icons.search)),
            ),
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                logout();
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 10),
        child: ValueListenableBuilder(
          valueListenable: studentNotifier,
          builder: (context, ListStudent, child) {
            return search.isNotEmpty
                ? serchTheStudent.isEmpty
                    ? Center(
                        child: Text(
                          "No Data Found",
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    : _studentList(serchTheStudent)
                : _studentList(ListStudent);
          },
        ),
      ),
    );
  }

  Widget _studentList(List<Student> students) {
    return students.isEmpty
        ? Center(
            child: Text(
              "No Students Found",
              style: TextStyle(color: Colors.red),
            ),
          )
        : ListView.builder(
            itemBuilder: (context, index) {
              final studentData = students[index];
              return Card(
                elevation: 10,
                color: Colors.teal[100],
                margin: const EdgeInsets.only(left: 30, right: 30, top: 10),
                child: ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      (MaterialPageRoute(
                        builder: (ctx) => StudentView(
                          name: studentData.name.toString(),
                          classs: studentData.classes.toString(),
                          address: studentData.address.toString(),
                          age: studentData.age.toString(),
                          images: studentData.images,
                        ),
                      )),
                    );
                  },
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundImage: studentData.images != null
                        ? FileImage(File(studentData.images ?? "N/A"))
                        : const AssetImage('') as ImageProvider,
                  ),
                  title: Text(studentData.name.toString()),
                  subtitle: Text(studentData.age.toString()),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (ctx) => Editstudent(
                                        name: studentData.name,
                                        age: studentData.age,
                                        classs: studentData.classes,
                                        address: studentData.address,
                                        images: studentData.images,
                                        index: index)));
                          },
                          icon: const Icon(Icons.edit)),
                      const SizedBox(
                        width: 1,
                      ),
                      IconButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                backgroundColor: Colors.teal[400],
                                content: Text(
                                  '${studentData.name} Deleted',
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                )));
                            deleteStudent(index);
                          },
                          icon: const Icon(Icons.delete))
                    ],
                  ),
                ),
              );
            },
            itemCount: students.length,
          );
  }
}
