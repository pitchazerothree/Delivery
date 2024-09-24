import 'package:flutter/material.dart';
import 'package:flutter_delivery/pages/userMe.dart';

class UserPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //ปิดไม่ให้ย้อนกลับ
        automaticallyImplyLeading: false,
        title: Container(
          alignment: Alignment.center,
          child: const Text(
            'หน้าหลัก',
            style: TextStyle(color: Colors.black), // ปรับสีข้อความตามต้องการ
          ),
        ),
        backgroundColor: const Color(0xFFFEACC3),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            OptionButton(
              title: 'ผู้ส่งสินค้า',
              image: 'assets/images/ส่ง.png', // เส้นทางของรูปภาพ
              color: const Color(0xFFFEACC3),
              width: 200.0,
              height: 200.0,
            ),
            const SizedBox(height: 20), // ระยะห่างระหว่างปุ่ม
            OptionButton(
              title: 'ผู้รับสินค้า',
              image: 'assets/images/รับ.png', // เส้นทางของรูปภาพ
              color: const Color(0xFFFEACC3),
              width: 200.0,
              height: 200.0,
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'หน้าหลัก'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'ฉัน'), // เปลี่ยนจาก Icons.book เป็น Icons.person
        ],
        backgroundColor: const Color(0xFFFEACC3),
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

class OptionButton extends StatelessWidget {
  final String title;
  final String image; // เปลี่ยนเป็น String สำหรับเส้นทางของภาพ
  final Color color;
  final double width;
  final double height;

  OptionButton({
    required this.title,
    required this.image,
    required this.color,
    this.width = 100.0,
    this.height = 100.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: Card(
        margin: const EdgeInsets.all(10),
        color: color,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              image,
              height: 100, // กำหนดความสูงของภาพ
              fit: BoxFit.cover, // ให้ภาพพอดีกับ Container
            ),
            const SizedBox(height: 8), // ระยะห่างระหว่างภาพและชื่อ
            Text(
              title,
              style: const TextStyle(fontSize: 20), // ปรับขนาดฟอนต์ตามต้องการ
            ),
          ],
        ),
      ),
    );
  }
}
