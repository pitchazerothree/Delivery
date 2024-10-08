import 'package:flutter/material.dart';
import 'package:flutter_delivery/pages/homeRider.dart';
import 'package:flutter_delivery/pages/sender.dart';
import 'package:flutter_delivery/pages/statusRider.dart'; // Import your StatusPage

class SenderProductPage extends StatefulWidget {
  @override
  _SenderProductPageState createState() => _SenderProductPageState();
}

class _SenderProductPageState extends State<SenderProductPage> {
  int _selectedIndex = 0; // To track the currently selected index

  // Sample order data
  final List<Order> orders = [
    Order(
      id: 55,
      name: 'นริสา ดูดี',
      phoneNumber: '0245879532',
      address: '18/54 ต.บางบัวทอง อ.พนม จ.ฉะเชิงเทรา 23519',
      items: [
        OrderItem(
          name: 'พัดลม',
          imageUrl: 'assets/images/fan.png',
        ),
      ],
    ),
    Order(
      id: 50,
      name: 'วันาน ถึง',
      phoneNumber: '0245896125',
      address: '55/555 ต.ธร อ.กร จ.จอพพพอง',
      items: [
        OrderItem(
          name: 'อโวคาโด้ปั่น',
          imageUrl: 'assets/images/logo.png',
        ),
        OrderItem(
          name: 'ข้าวไข่เจียว+ผัดหมู',
          imageUrl: 'assets/images/logo.png',
        ),
      ],
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Update the selected index
    });

    // Navigate to the appropriate page based on the selected index
    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => SenderPage()), // Navigate to SenderPage
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => SenderProductPage()), // Current Page
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 10, // Set AppBar height
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 18),
            ListView.builder(
              itemCount: orders.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final order = orders[index];
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(254, 172, 195, 1),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            'ออเดอร์ที่ ${order.id}\nผู้รับ : ${order.name}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text('เบอร์โทร : ${order.phoneNumber}'),
                        Text('ที่อยู่ : ${order.address}'),
                        SizedBox(height: 8),
                        Divider(color: Colors.black),
                        SizedBox(height: 8),
                        Text(
                          'รายการของที่สั่ง:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: order.items.length,
                          itemBuilder: (context, itemIndex) {
                            final item = order.items[itemIndex];
                            return ListTile(
                              leading: Image.asset(item.imageUrl,
                                  width: 50, height: 50),
                              title: Text(item.name),
                            );
                          },
                        ),
                        SizedBox(height: 16),
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => StatusPage()),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color.fromRGBO(255, 206, 249, 1),
                              foregroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 10),
                            ),
                            child: Text('ดูสถานะการจัดส่ง'),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
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
}

// Order class
class Order {
  final int id;
  final String name;
  final String phoneNumber;
  final String address;
  final List<OrderItem> items;

  Order({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.address,
    required this.items,
  });
}

// OrderItem class
class OrderItem {
  final String name;
  final String imageUrl;

  OrderItem({
    required this.name,
    required this.imageUrl,
  });
}
