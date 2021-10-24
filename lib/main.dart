import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:real_estate_mobile/pages/Login.dart';
import 'package:real_estate_mobile/pages/Loading.dart';
import 'package:real_estate_mobile/pages/Home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Login(),
      routes: {
        '/loading':(context)=>Loading(),
        '/home':(context)=>Home()
      }
    );
  }
}
