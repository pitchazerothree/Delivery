import 'package:flutter/material.dart';
import 'package:flutter_delivery/pages/SendProduct.dart';
import 'package:flutter_delivery/pages/homeRider.dart';
import 'package:flutter_delivery/pages/login.dart';
import 'package:flutter_delivery/pages/orderReceive.dart';
import 'package:flutter_delivery/pages/orderSender.dart';
import 'package:flutter_delivery/pages/realtimeRider.dart';
import 'package:flutter_delivery/pages/receiver.dart';
import 'package:flutter_delivery/pages/registerRider.dart';
import 'package:flutter_delivery/pages/registerUser.dart';
import 'package:flutter_delivery/pages/sender.dart';
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
