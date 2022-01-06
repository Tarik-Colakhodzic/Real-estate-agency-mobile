import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:real_estate_mobile/pages/Login.dart';
import 'package:real_estate_mobile/pages/Loading.dart';
import 'package:real_estate_mobile/pages/Home.dart';
import 'package:real_estate_mobile/pages/MyProperties.dart';
import 'package:real_estate_mobile/pages/Properties.dart';
import 'package:real_estate_mobile/pages/Registration.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Login(), routes: {
      '/registrationLogin': (context) => Login(),
      '/loading': (context) => Loading(),
      '/home': (context) => Home(),
      '/properties': (context) => Properties(),
      '/myProperties': (context) => MyProperties(),
      '/registration': (context) =>  Registration()
    });
  }
}
