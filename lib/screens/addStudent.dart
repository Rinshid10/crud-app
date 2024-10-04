
// ignore: file_names
import 'dart:io';

import 'package:cread_app/database/functions.dart';
import 'package:cread_app/modal/student.dart';
import 'package:cread_app/screens/homeScreen.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';

class AddStudent extends StatefulWidget {
  const AddStudent({super.key});

  @override
  State<AddStudent> createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {
  final studentName = TextEditingController();

  final studentClass = TextEditingController();

  final studentAge = TextEditingController();

  final studentAddress = TextEditingController();

  File? _selectImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal[400],
      ),
      backgroundColor: Colors.teal[200],
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Card(
                  elevation: 20,
                  color: Colors.teal[100],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  child: SizedBox(
                    width: 400,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Stack(
                            children: [
                              CircleAvatar(
                                radius: 60,
                                backgroundImage: _selectImage != null
                                    ? FileImage(_selectImage!)
                                    : const AssetImage('') as ImageProvider,
                              ),
                              Positioned(
                                top: 80,
                                left: 50,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.teal[200],
                                        shape: const CircleBorder(),
                                        padding: const EdgeInsets.all(10)),
                                    onPressed: () {
                                      _pickImageGallery();
                                    },
                                    child: const Icon(Icons.add_a_photo)),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: studentName,
                            decoration: const InputDecoration(
                                contentPadding: EdgeInsets.all(10),
                                hintText: 'Name',
                                border: OutlineInputBorder()),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            controller: studentAge,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                                contentPadding: EdgeInsets.all(10),
                                hintText: 'Age',
                                border: OutlineInputBorder()),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: studentClass,
                            decoration: const InputDecoration(
                                contentPadding: EdgeInsets.all(10),
                                hintText: 'Class',
                                border: OutlineInputBorder()),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: studentAddress,
                            decoration: const InputDecoration(
                                contentPadding: EdgeInsets.all(10),
                                hintText: 'Address',
                                border: OutlineInputBorder()),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.teal[300]),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text(
                                    'cancel',
                                    style: TextStyle(color: Colors.white),
                                  )),
                              const Gap(20),
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.teal[300]),
                                  onPressed: () {
                                    addStudentCheack(context);
                                  },
                                  child: const Text('Add',
                                      style: TextStyle(color: Colors.white))),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Future addStudentCheack(BuildContext context) async {
    final stname = studentName.text;
    final stage = studentAge.text;
    final stclass = studentClass.text;
    final staddress = studentAddress.text;

    print(stname);

    final printSt = Student(
        name: stname,
        classes: stclass,
        address: staddress,
        age: stage,
        images: _selectImage?.path ?? "");

    if (stname.isNotEmpty &&
        staddress.isNotEmpty &&
        staddress.isNotEmpty &&
        stage.isNotEmpty) {
      addStudentTolist(printSt);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (ctx) => const HomeScreen()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('fill the form to add details')));
    }
  }

  Future _pickImageGallery() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile == null) {
      return;
    } else {
      setState(() {
        _selectImage = File(pickedFile.path);
      });
    }
  }
}
