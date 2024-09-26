import 'package:flutter/material.dart';
import 'package:flutter_delivery/pages/receiver.dart';
import 'package:flutter_delivery/pages/sender.dart';
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
        backgroundColor: Color.fromRGBO(254, 172, 195, 1),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            OptionButton(
              title: 'ผู้ส่งสินค้า',
              image: 'assets/images/ส่ง.png',
              color: Color.fromRGBO(254, 172, 195, 1),
              width: 200.0,
              height: 200.0,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          SenderPage()), // Adjust the page to navigate to
                );
              },
            ),
            const SizedBox(height: 20),
            OptionButton(
              title: 'ผู้รับสินค้า',
              image: 'assets/images/รับ.png',
              color: Color.fromRGBO(254, 172, 195, 1),
              width: 200.0,
              height: 200.0,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ReceiverPage()), // Adjust the page to navigate to
                );
              },
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

class OptionButton extends StatelessWidget {
  final String title;
  final String image;
  final Color color;
  final double width;
  final double height;
  final VoidCallback onPressed; // Callback function for tap event

  OptionButton({
    required this.title,
    required this.image,
    required this.color,
    this.width = 100.0,
    this.height = 100.0,
    required this.onPressed, // Require onPressed parameter
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed, // Use the onPressed callback here
      child: Container(
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
                height: 100,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 8),
              Text(
                title,
                style: const TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
