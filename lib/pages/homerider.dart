import 'package:flutter/material.dart';
import 'package:flutter_delivery/pages/login.dart';

class HomeRiderPage extends StatelessWidget {
  final List<Order> orders = [
    Order(
      id: 50,
      name: 'ตะวันชา ฟ้าใส',
      phoneNumber: '0222222222',
      address: '55/555 ต.ตรง อ.นบน จ.อออออ',
      items: [
        OrderItem(
          name: 'ชาเขียวใบ',
          imageUrl: 'assets/images/logo.png',
        ),
        OrderItem(
          name: 'ข้าวไข่เจียว+ผัดผง',
          imageUrl: 'assets/images/logo.png',
        ),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(110.0),
        child: AppBar(
          backgroundColor: Color.fromRGBO(255, 198, 207, 1),
          elevation: 0,
          flexibleSpace: Padding(
            padding: const EdgeInsets.only(top: 35.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    const SizedBox(width: 20),
                    CircleAvatar(
                      backgroundImage: AssetImage('assets/images/logo.png'),
                      radius: 35,
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'ชื่อไรเดอร์ : ตะวันชา ฟ้าใส',
                            style: TextStyle(color: Colors.black, fontSize: 16),
                          ),
                          Text(
                            'เบอร์โทร : xxxxxxxxxx',
                            style: TextStyle(color: Colors.black, fontSize: 14),
                          ),
                          Text(
                            'ทะเบียนรถ: xxxxxx',
                            style: TextStyle(color: Colors.black, fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginPage()),
                        );
                      },
                      icon: Icon(Icons.logout),
                      color: Colors.black,
                    ),
                    const SizedBox(width: 15),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 40),
          const Text(
            'ออร์เดอร์',
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index];
              return Card(
                color: Color.fromRGBO(255, 198, 207, 1),
                margin: const EdgeInsets.symmetric(horizontal: 20.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          'ออเดอร์ที่ ${order.id}',
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Center(
                        child: Text(
                          'ผู้ส่ง : ${order.name}',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text('เบอร์โทร: ${order.phoneNumber}'),
                      Text('ที่อยู่ : ${order.address}'),
                      const Divider(height: 20, thickness: 1, color: Colors.black),
                      Center(
                        child: Text(
                          'ผู้รับ : วันวาน ถึง',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text('เบอร์โทร: 0245896125'),
                      Text('ที่อยู่ : 55/555 ต.ตรง อ.ทกท จ.จงพพพ'),
                      const Divider(height: 20, thickness: 1, color: Colors.black),
                      const Text(
                        'รายการของที่สั่ง',
                        style: TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: 10),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: order.items.length,
                        itemBuilder: (context, itemIndex) {
                          final item = order.items[itemIndex];
                          return ListTile(
                            leading:
                                Image.asset(item.imageUrl), // รูปสินค้า
                            title: Text(item.name),
                          );
                        },
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Text('5 กิโลเมตร'),
                          const SizedBox(width: 30),
                          Container(
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(240, 49, 103, 1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: TextButton(
                              onPressed: () {
                                // โค้ดเมื่อกดปุ่ม
                              },
                              child: const Text(
                                'คลิกเพื่อดูตำแหน่ง',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      const Divider(
                          height: 20, thickness: 1, color: Colors.black),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              // โค้ดยกเลิกออเดอร์
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Color.fromRGBO(254, 116, 116, 1),
                            ),
                            child: const Text('ยกเลิกออเดอร์',
                                style: TextStyle(color: Colors.white)),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              // โค้ดยืนยันรับออเดอร์
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Color.fromRGBO(255, 174, 0, 1),
                            ),
                            child: const Text('ยืนยันรับออเดอร์',
                                style: TextStyle(color: Colors.white)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
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
