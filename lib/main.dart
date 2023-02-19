import 'package:cheque_print/UI/Dahboard/Dahboard.dart';
import 'package:cheque_print/UI/loginpage/loginpage.dart';
import 'package:flutter/material.dart';

void main() {

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // fontFamily: 'Cutive',
      ),
      home: LoginPage(),
    );
  }
}

//abc