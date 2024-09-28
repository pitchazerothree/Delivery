import 'package:flutter/material.dart';
import 'package:flutter_delivery/pages/SendProduct.dart';
import 'package:flutter_delivery/pages/PackThings.dart'; // Import the PackThings page

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
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              Image.asset(
                'assets/images/logo.png',
                height: 150,
                fit: BoxFit.contain,
              ),
              SizedBox(height: 20),
              const Text(
                'ค้นหาผู้รับโดยใช้หมายเลขโทรศัพท์',
                style: TextStyle(fontSize: 15),
              ),
              SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                  hintText: '0',
                  filled: true,
                  fillColor: Color(0xFFFFC0CB),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(0.0),
                    borderSide: BorderSide.none,
                  ),
                ),
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  // Implement search logic
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFFFC0CB),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                ),
                child: Text(
                  'ค้นหา',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              SizedBox(height: 20),
              // Align text to the left
              Align(
                alignment: Alignment.centerLeft, // Move text to the left
                child: const Text(
                  'ผลการค้นหา',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 10),
              // Example list of recipients
              Column(
                children: [
                  buildRecipientCard('บริสา ดูดี', '0245879532',
                      '18/54 ต.นาบี อ.ดงพนม จ.อุตร 23519'),
                  buildRecipientCard('ไจด์ ดีดี', '0222279532',
                      '124/54 ต.นาบี อ.ดงพนม จ.อุตร 23519'),
                  buildRecipientCard('กรกฎ คน', '0245875755',
                      '18/54 ต.นาบี อ.ดงพนม จ.อุตร 23519'),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'ค้นหาสมาชิก'),
          BottomNavigationBarItem(
              icon: Icon(Icons.send), label: 'สินค้าที่ต้องส่ง'),
        ],
        currentIndex: _selectedIndex, // Highlight the current index
        backgroundColor: Color.fromRGBO(254, 172, 195, 1),
        selectedItemColor: Colors.black,
        onTap: _onItemTapped, // Handle tap events
      ),
    );
  }

  Widget buildRecipientCard(String name, String phone, String address) {
    return Card(
      color: Color(0xFFFFC0CB),
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  phone,
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  address,
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                // Navigate to the PackThings page when selected
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        PackThingsPage(), // Navigate to PackThings
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0.0),
                ),
              ),
              child: Text(
                'เลือก',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
