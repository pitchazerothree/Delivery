import 'package:flutter/material.dart';
import 'package:flutter_delivery/pages/registerrider.dart';
import 'package:flutter_delivery/pages/registeruser.dart';
import 'package:flutter_delivery/pages/user.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(10)), // กำหนดขนาดของขอบโค้ง
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
                    // การ์ดสำหรับช่องกรอกข้อมูลและปุ่ม
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
                            // ป้ายกำกับสำหรับหมายเลขโทรศัพท์
                            Align(
                              alignment: Alignment.centerLeft,
                              child: const Text(
                                'หมายเลขโทรศัพท์ :',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold, // ตัวหนา
                                ),
                              ),
                            ),
                            // ช่องกรอกหมายเลขโทรศัพท์
                            TextField(
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
                            // ป้ายกำกับสำหรับรหัสผ่าน
                            Align(
                              alignment: Alignment.centerLeft,
                              child: const Text(
                                'รหัสผ่าน :',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold, // ตัวหนา
                                ),
                              ),
                            ),
                            // ช่องกรอกรหัสผ่าน
                            TextField(
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
                            // ปุ่มเข้าสู่ระบบ
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => UserPage()),
                                );
                              },
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
                    // ลิงก์สมัครสมาชิก rider และ user
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
}
