import 'package:flutter/material.dart';

class UserPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('หน้าหลัก'),
        backgroundColor: Colors.pink,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          OptionButton(
              title: 'ผู้ส่งสินค้า', icon: Icons.send, color: Colors.amber),
          OptionButton(
              title: 'ผู้รับสินค้า', icon: Icons.receipt, color: Colors.green),
        ],
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
  final IconData icon;
  final Color color;

  OptionButton({required this.title, required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      color: color,
      child: ListTile(
        leading: Icon(icon, size: 50),
        title: Text(title),
        onTap: () {
          // เพิ่มการดำเนินการเมื่อผู้ใช้คลิก
        },
      ),
    );
  }
}
