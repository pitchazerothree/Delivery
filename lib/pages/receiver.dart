import 'package:flutter/material.dart';
import 'package:flutter_delivery/pages/statusRider.dart'; // Import your StatusPage

class ReceiverPage extends StatelessWidget {
  final List<Order> orders = [
    Order(
      id: 20,
      name: 'ตะวันชา ฟ้าใส',
      phoneNumber: '0222222222',
      address: '55/555 ต.รธ อ.นนน จ.ออออ',
      items: [
        OrderItem(
          name: 'อโกโก้ได้บัน',
          imageUrl: 'assets/images/logo.png',
        ),
        OrderItem(
          name: 'ข้าวไข่เจียว+ผัดหมู',
          imageUrl: 'assets/images/logo.png',
        ),
      ],
    ),
    Order(
      id: 21,
      name: 'นางสา กรกฎ',
      phoneNumber: '02222255522',
      address: '9/57/2557',
      items: [
        OrderItem(
          name: 'ข้าวผัดกะเพรา',
          imageUrl: 'assets/images/logo.png',
        ),
        OrderItem(
          name: 'ชานมไข่มุก',
          imageUrl: 'assets/images/logo.png',
        ),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('สินค้าที่ต้องส่ง'),
      ),
      body: ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];
          return Container(
            // width: 100, // Set width to 150 pixels
            //height: , // Set height to 350 pixels
            child: Card(
              color: Colors.pink[100],
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      // Center the title
                      child: Text(
                        'ออเดอร์ที่ ${order.id}\nผู้ส่ง: ${order.name}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                        textAlign: TextAlign.center, // Center the text inside
                      ),
                    ),
                    Text('เบอร์โทร : ${order.phoneNumber}'),
                    Text('ที่อยู่ : ${order.address}'),
                    SizedBox(height: 8),
                    Divider(color: Colors.black), // Black Divider
                    SizedBox(height: 8),
                    Text('รายการของที่สั่ง:',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 8),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: order.items.length,
                      itemBuilder: (context, itemIndex) {
                        final item = order.items[itemIndex];
                        return ListTile(
                          leading:
                              Image.asset(item.imageUrl, width: 50, height: 50),
                          title: Text(item.name),
                        );
                      },
                    ),
                    SizedBox(height: 16),
                    // Button at the bottom of the card
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          // Navigate to StatusPage when the button is pressed
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    StatusPage(orderId: order.id)),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 247, 169, 241),
                          foregroundColor:
                              Colors.black, // Set the text color to black
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
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
            ),
          );
        },
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
