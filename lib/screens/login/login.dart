// ignore: file_names
import 'package:cread_app/screens/homeScreen.dart';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginOldStudent extends StatefulWidget {
  const LoginOldStudent({super.key});

  @override
  State<LoginOldStudent> createState() => _LoginOldStudentState();
}

class _LoginOldStudentState extends State<LoginOldStudent> {
  final TextEditingController username = TextEditingController();
  final TextEditingController password = TextEditingController();
  Future<void> login() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedUsername = prefs.getString("username");
    String? savedPassword = prefs.getString("password");
    if (savedUsername == username.text && savedPassword == password.text) {
      await prefs.setBool("isLoggedin", true);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (ctx) => HomeScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[200],
      appBar: AppBar(
        backgroundColor: Colors.teal[400],
      ),
      body: Center(
        child: Container(
          height: 500,
          padding: const EdgeInsets.all(30),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            color: Colors.teal[50],
            elevation: 10,
            child: Padding(
              padding: const EdgeInsets.all(25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.person,
                    size: 90,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter your username";
                      } else {
                        return null;
                      }
                    },
                    controller: username,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), hintText: 'username'),
                  ),
                  const Gap(20),
                  TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter your password";
                        } else {
                          return null;
                        }
                      },
                      controller: password,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), hintText: 'password')),
                  const Gap(10),
                  Gap(20),
                  ElevatedButton(
                    onPressed: () {
                      login();
                    },
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.only(left: 30, right: 30)),
                    child: const Text('login'),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
