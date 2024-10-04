import 'dart:developer';
import 'dart:io';

import 'package:cread_app/database/functions.dart';
import 'package:cread_app/modal/student.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';

// ignore: must_be_immutable
class Editstudent extends StatefulWidget {
  String? name;
  String? classs;
  String? address;
  String? age;
  dynamic images;
  int? id;
  int? index;

  Editstudent({
    super.key,
    required this.name,
    required this.classs,
    required this.address,
    required this.age,
    required this.images,
    this.id,
    this.index,
  });

  @override
  State<Editstudent> createState() => _EditstudentState();
}

class _EditstudentState extends State<Editstudent> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _classController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _ageController = TextEditingController();

  File? _selectImage;

  @override
  Widget build(BuildContext context) {
    _nameController = TextEditingController(text: widget.name);
    _classController = TextEditingController(text: widget.classs);
    _ageController = TextEditingController(text: widget.age);
    _addressController = TextEditingController(text: widget.address);
    File? selectImage = widget.images != '' ? File(widget.images) : null;

    return Scaffold(
      backgroundColor: Colors.teal[200],
      appBar: AppBar(
        title: const Text('Edit Student'),
        backgroundColor: Colors.teal[400],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: Container(
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              color: Colors.teal[100],
              elevation: 10,
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Stack(
                      children: [
                        CircleAvatar(
                          backgroundImage: _selectImage != null
                              ? FileImage(_selectImage!)
                              : const AssetImage(''),
                          // as ImageProvider,,
                          radius: 60,
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
                                _pickImageGllry();
                              },
                              child: Icon(
                                Icons.add_a_photo,
                                color: Colors.teal[900],
                              )),
                        ),
                      ],
                    ),
                    const Gap(20),
                    TextField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                        labelText: 'Name',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: _ageController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                        labelText: 'Age',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: _classController,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                        labelText: 'Class',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: _addressController,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                        labelText: 'Address',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        updateAll();
                        Navigator.pop(context);
                      },
                      child: const Text('Update'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> updateAll() async {
    final namee = _nameController.text;
    final agee = _ageController.text;
    final classe = _classController.text;
    final addresse = _addressController.text;
    final images = _selectImage?.path ?? "";

    // final Image1 = _image?.path ?? "";

    if (namee.isEmpty || agee.isEmpty || classe.isEmpty || addresse.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please fill all fields')));
    } else {
      final update = Student(
        name: namee,
        age: agee,
        classes: classe,
        address: addresse,
        images: _selectImage?.path ?? "",
        // images: Image1
      );
      editing(widget.index, update);

      log("message");
    }
  }

  Future _pickImageGllry() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectImage = File(pickedFile.path);
      });
    }
  }
}
