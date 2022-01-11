import 'package:flutter/material.dart';
import 'package:real_estate_mobile/pages/Complaints.dart';
import 'package:real_estate_mobile/pages/Login.dart';
import 'package:real_estate_mobile/pages/Loading.dart';
import 'package:real_estate_mobile/pages/MyProperties.dart';
import 'package:real_estate_mobile/pages/Properties.dart';
import 'package:real_estate_mobile/pages/Registration.dart';
import 'package:real_estate_mobile/pages/MyVisits.dart';

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
      '/properties': (context) => Properties(),
      '/myProperties': (context) => MyProperties(),
      '/registration': (context) =>  Registration(),
      '/myVisits': (context) => MyVisits(),
      '/complaints': (context) => Complaints()
    });
  }
}
