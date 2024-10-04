import 'dart:async';

import 'package:cread_app/screens/homeScreen.dart';
import 'package:cread_app/screens/login/signUp.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      checkLogin();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[400],
      body: Center(
        child: Container(
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.app_registration,
                size: 110,
              ),
              Text(
                'CRUD APP',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w900,
                    fontStyle: FontStyle.italic,
                    shadows: [
                      Shadow(
                          color: Colors.black,
                          offset: Offset(2, 0),
                          blurRadius: 1.4),
                    ]),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> checkLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedin = prefs.getBool("isLoggedin") ?? false;
    if (isLoggedin) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (ctx) => const HomeScreen()));
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (ctx) => const Loginscreen()));
    }
  }
}
