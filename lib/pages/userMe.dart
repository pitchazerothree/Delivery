import 'package:flutter/material.dart';
import 'package:flutter_delivery/pages/user.dart';
import 'package:flutter_delivery/pages/login.dart'; // Import หน้าล็อกอิน

class userMePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          const SizedBox(height: 40),
          const CircleAvatar(
            radius: 60,
            backgroundImage:
                AssetImage('assets/images/ส่ง.png'), //ตรงนี้ใส่รูปผู้ใช้เด้อ
          ),
          const SizedBox(height: 20),
          Card(
            color: Colors.pink[100],
            margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: const Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ชื่อผู้ใช้ : ลลินดา ดาว',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'หมายเลขโทรศัพท์ : 0555555555',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'ที่อยู่ : 15/12 ต.สาลี อ.บาดี จ.ชัยภูมิ 36190',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              // เมื่อกดปุ่มออกจากระบบ จะนำไปยังหน้า LoginPage
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        LoginPage()), // เปลี่ยนไปหน้า LoginPage
              );
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              backgroundColor: Color.fromRGBO(255, 198, 207, 1), // Background color
            ),
            child: const Text('ออกจากระบบ',
                style: TextStyle(fontSize: 16, color: Colors.black)),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'หน้าหลัก'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'ฉัน'), // เปลี่ยนจาก Icons.book เป็น Icons.person
        ],
        backgroundColor: Color.fromRGBO(254, 172, 195, 1),
        selectedItemColor: Colors.black,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => UserPage()), // ไปที่หน้า UserPage
            );
          } else {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => userMePage()), // ไปที่หน้า UserMePage
            );
          }
        },
      ),
    );
  }
}
