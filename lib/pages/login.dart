import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_delivery/config/shared/dataUser.dart';
import 'package:flutter_delivery/pages/homeRider.dart';
import 'package:flutter_delivery/pages/model/Request/riderReq.dart';
import 'package:flutter_delivery/pages/model/Request/userReq.dart';
import 'package:flutter_delivery/pages/registerRider.dart';
import 'package:flutter_delivery/pages/registeruser.dart';

import 'package:flutter_delivery/pages/user.dart';
import 'package:flutter_delivery/pages/userMe.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(254, 172, 195, 1),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
              child: Image.asset(
                'assets/images/logo.png',
                height: 250,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 200),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Card(
                      color: Colors.white,
                      elevation: 5,
                      margin: const EdgeInsets.symmetric(horizontal: 30.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'หมายเลขโทรศัพท์ :',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            TextField(
                              controller: phoneController,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: Color.fromRGBO(255, 198, 207, 1),
                                    width: 2,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: Color.fromRGBO(255, 198, 207, 1),
                                    width: 2,
                                  ),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                              keyboardType: TextInputType.phone,
                            ),
                            const SizedBox(height: 20),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'รหัสผ่าน :',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            TextField(
                              controller: passwordController,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: Color.fromRGBO(255, 198, 207, 1),
                                    width: 2,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: Color.fromRGBO(255, 198, 207, 1),
                                    width: 2,
                                  ),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                              obscureText: true,
                            ),
                            const SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () => login(context),
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromRGBO(255, 198, 207, 1),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 50, vertical: 15),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              child: const Text(
                                'เข้าสู่ระบบ',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text('หรือ'),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegisterRider()),
                            );
                          },
                          child: const Text('สมัครสมาชิก (rider)'),
                        ),
                        const SizedBox(width: 20),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegisterUser()),
                            );
                          },
                          child: const Text('สมัครสมาชิก (User)'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void login(BuildContext context) async {
    String phone = phoneController.text.trim();
    String password = passwordController.text.trim();

    if (phone.isEmpty || password.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: const Text('หมายเลขโทรศัพท์และรหัสผ่านไม่สามารถว่างได้'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
      return;
    }

    log('Phone: $phone, Password: $password'); // เพิ่มการ log

    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('register')
          .where('phone', isEqualTo: phone)
          .where('password', isEqualTo: password)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        var userDoc = querySnapshot.docs.first.data() as Map<String, dynamic>;
        String documentId = querySnapshot.docs.first.id;
        String userType = userDoc['type'] ?? '';

        // เพิ่มการตรวจสอบ userType
        if (userType == 'user') {
          log(' is a User');
          UserProfile userProfile = UserProfile(
            id: documentId,
            name: userDoc['name'] ?? '',
            phone: userDoc['phone'] ?? '',
            address: userDoc['address'] ?? '',
            image: userDoc['image'] ?? '',
            latitude:
                double.tryParse(userDoc['latitude']?.toString() ?? '0.0') ??
                    0.0,
            longitude:
                double.tryParse(userDoc['longitude']?.toString() ?? '0.0') ??
                    0.0,
            type: userDoc['type'] ?? '',
          );
          // บันทึกข้อมูลผู้ใช้หากต้องการ
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => UserPage(),
            ),
          );
        } else if (userType == 'Rider') {
          log('User is a Rider');
          RiderProfile riderProfile = RiderProfile(
            id: documentId,
            name: userDoc['name'] ?? '',
            phone: userDoc['phone'] ?? '',
            image: userDoc['image'] ?? '',
            vehicle: userDoc['vehicle'] ?? '',
            type: userDoc['type'] ?? '',
          );
          // สามารถบันทึกข้อมูล riderProfile หรือใช้ Provider ที่นี่ได้
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomeRiderPage(),
            ),
          );
        } else {
          log('Unknown user type');
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('ไม่พบผู้ใช้หรือรหัสผ่านไม่ถูกต้อง!'),
          ),
        );
      }
    } catch (error) {
      log('Error: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('เกิดข้อผิดพลาด: $error')),
      );
    }
  }
}
