import 'package:flutter/material.dart';
import 'package:flutter_delivery/pages/homerider.dart';
import 'package:flutter_delivery/pages/login.dart';
import 'package:flutter_delivery/pages/registerrider.dart';
import 'package:flutter_delivery/pages/registeruser.dart';
import 'package:flutter_delivery/pages/user.dart';
import 'package:flutter_delivery/pages/userMe.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: HomeRiderPage(),
    );
  }
}

