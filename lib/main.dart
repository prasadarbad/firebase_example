import 'package:firebase_example/homepage.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_example/homepage1.dart';
import 'package:firebase_example/login.dart';
import 'package:firebase_example/signup.dart';
import 'package:firebase_example/splashscreen.dart';
import 'package:firebase_example/start.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: Splash(),
    );
  }
}
