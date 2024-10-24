import 'package:cloud_firestore/cloud_firestore.dart';
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
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // Connnect to FireStore
  FirebaseFirestore.instance.settings = const Settings(
    persistenceEnabled: true,
  );
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
