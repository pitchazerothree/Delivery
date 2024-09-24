import 'package:flutter/material.dart';

class UserPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          alignment: Alignment.center,
          child: Text(
            'หน้าหลัก',
            style: TextStyle(color: Colors.black), // ปรับสีข้อความตามต้องการ
          ),
        ),
        backgroundColor: Color(0xFFFEACC3),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            OptionButton(
              title: 'ผู้ส่งสินค้า',
              image: 'assets/images/ส่ง.png', // เส้นทางของรูปภาพ
              color: Color(0xFFFEACC3),
              width: 200.0,
              height: 200.0,
            ),
            SizedBox(height: 20), // ระยะห่างระหว่างปุ่ม
            OptionButton(
              title: 'ผู้รับสินค้า',
              image: 'assets/images/รับ.png', // เส้นทางของรูปภาพ
              color: Color(0xFFFEACC3),
              width: 200.0,
              height: 200.0,
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'หน้าหลัก'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'ฉัน'),
        ],
        backgroundColor: Color(0xFFFEACC3),
        selectedItemColor: Colors.white,
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
        margin: EdgeInsets.all(10),
        color: color,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              image,
              height: 100, // กำหนดความสูงของภาพ
              fit: BoxFit.cover, // ให้ภาพพอดีกับ Container
            ),
            SizedBox(height: 8), // ระยะห่างระหว่างภาพและชื่อ
            Text(
              title,
              style: TextStyle(fontSize: 20), // ปรับขนาดฟอนต์ตามต้องการ
            ),
          ],
        ),
      ),
    );
  }
}
