import 'package:cread_app/modal/student.dart';

import 'package:cread_app/screens/splash.dart';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(StudentAdapter().typeId)) {
    Hive.registerAdapter(StudentAdapter());
  }

  runApp(const MyApp());
}

bool isLoggedin = false;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
