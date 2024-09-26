import 'package:flutter/material.dart';
import 'package:flutter_delivery/pages/SendProduct.dart';

class SenderPage extends StatefulWidget {
  @override
  _SenderPageState createState() => _SenderPageState();
}

class _SenderPageState extends State<SenderPage> {
  int _selectedIndex = 0; // To track the currently selected index

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Update the selected index
    });

    // Navigate to the appropriate page based on the selected index
    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SenderPage()), // Current Page
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => SenderProductPage()), // Product Page
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('หน้าผู้ส่งสินค้า'),
      ),
      body: Center(
        child: const Text(
          'ยินดีต้อนรับสู่หน้าผู้ส่ง!',
          style: TextStyle(fontSize: 24),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'ค้นหาสมาชิก'),
          BottomNavigationBarItem(
              icon: Icon(Icons.send),
              label: 'สินค้าที่ต้องส่ง'), // Use an existing icon
        ],
        currentIndex: _selectedIndex, // Highlight the current index
        backgroundColor: Color.fromRGBO(254, 172, 195, 1),
        selectedItemColor: Colors.black,
        onTap: _onItemTapped, // Handle tap events
      ),
    );
  }
}
