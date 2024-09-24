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
        // title: Text('Profile'),
        // backgroundColor: Colors.pink[200],
      ),
      body: Column(
        children: [
          SizedBox(height: 40),
          CircleAvatar(
            radius: 60,
            backgroundImage: AssetImage(
                'assets/profile.png'), // Replace with the correct image path
          ),
          SizedBox(height: 20),
          Card(
            color: Colors.pink[100],
            margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
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
          SizedBox(height: 30),
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
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              backgroundColor: Colors.pink[200], // Background color
            ),
            child: Text('ออกจากระบบ',
                style: TextStyle(fontSize: 16, color: Colors.black)),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'หน้าหลัก'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'ฉัน'), // เปลี่ยนจาก Icons.book เป็น Icons.person
        ],
        backgroundColor: Color(0xFFFEACC3),
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
