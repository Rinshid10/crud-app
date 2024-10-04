// ignore: file_names
import 'package:cread_app/screens/homeScreen.dart';
import 'package:cread_app/screens/login/login.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  final TextEditingController username = TextEditingController();
  final TextEditingController password = TextEditingController();

  Future<void> isLogined() async {
    if (username.text.isNotEmpty && password.text.isNotEmpty) {
      final sharedpref = await SharedPreferences.getInstance();
      await sharedpref.setString("username", username.text);
      await sharedpref.setString("password", password.text);
      await sharedpref.setBool("isLoggedn", true);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (ctx) => HomeScreen()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Enter your user name and password')));
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
                  Row(
                    children: [
                      Text(
                        'Alredy have a account ?',
                        style: TextStyle(fontWeight: FontWeight.w400),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (ctx) => LoginOldStudent()));
                          },
                          child: Text(
                            'Login',
                            style: TextStyle(
                                color: Colors.teal[300],
                                fontWeight: FontWeight.w900),
                          ))
                    ],
                  ),
                  Gap(20),
                  ElevatedButton(
                    onPressed: () {
                      isLogined();
                    },
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.only(left: 30, right: 30)),
                    child: const Text('Sign Up'),
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
