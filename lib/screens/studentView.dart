import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class StudentView extends StatelessWidget {
  final String name;
  final String classs;
  final String address;
  final String age;
  dynamic images;

  StudentView(
      {super.key,
      required this.name,
      required this.classs,
      required this.age,
      required this.address,
      required this.images});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[200],
      appBar: AppBar(
        backgroundColor: Colors.teal[400],
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 30),
              width: 300,
              height: 300,
              child: Card(
                color: Colors.teal[100],
                elevation: 10,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: FileImage(File(images)),
                    ),
                    const Gap(20),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          name,
                        ),
                        Text(
                          age,
                        ),
                        Text(
                          classs,
                        ),
                        Text(
                          address,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
