import 'package:flutter/material.dart';
import 'package:flutter_delivery/pages/realtimeRider.dart'; // นำเข้าหน้า realtimeRider
import 'package:flutter_delivery/pages/orderReceive.dart'; // นำเข้าหน้า orderReceive

class OrderReceivePage extends StatelessWidget {
  final Order order = Order(
    id: 50,
    senderName: 'ตะวันชา ฟ้าใส',
    senderPhoneNumber: '0222222222',
    senderAddress: '55/555 ต.ตรง อ.นบน จ.อออออ',
    receiverName: 'วันวาน ถึง',
    receiverPhoneNumber: '0245896125',
    receiverAddress: '55/555 ต.ตรง อ.ทกท จ.จงพพพ',
    items: [
      OrderItem(
        name: 'ชาเขียวใบ',
        imageUrl: 'assets/images/logo.png',
      ),
      OrderItem(
        name: 'ข้าวไข่เจียว+ผัดหมู',
        imageUrl: 'assets/images/logo.png',
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 10, // กำหนดความสูงของ AppBar
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildOrderCard(order, context),
            const SizedBox(height: 20),
            _buildCameraSection(),
            const SizedBox(height: 20),
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RealtimeRiderPage()),
                  );
                },
                style: TextButton.styleFrom(
                  backgroundColor: Color.fromRGBO(255, 179, 14, 1),
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                ),
                child: const Text('ดำเนินการต่อ',
                    style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderCard(Order order, BuildContext context) {
    return Card(
      color: Color.fromRGBO(254, 172, 195, 1),
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
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: Text(
                'ผู้ส่ง : ${order.senderName}',
                style: TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(height: 5),
            Text('เบอร์โทร: ${order.senderPhoneNumber}'),
            Text('ที่อยู่ : ${order.senderAddress}'),
            const Divider(height: 20, thickness: 1, color: Colors.black),
            Center(
              child: Text(
                'ผู้รับ : ${order.receiverName}',
                style: TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(height: 5),
            Text('เบอร์โทร: ${order.receiverPhoneNumber}'),
            Text('ที่อยู่ : ${order.receiverAddress}'),
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
              itemBuilder: (context, index) {
                final item = order.items[index];
                return ListTile(
                  leading: Image.asset(item.imageUrl), // รูปสินค้า
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
                      // นำทางไปยัง OrderReceivePage โดยใช้ pushReplacement
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RealtimeRiderPage()),
                      );
                    },
                    child: const Text(
                      'คลิกเพื่อดูตำแหน่ง',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCameraSection() {
    return Column(
      children: [
        const Text(
          'ถ่ายรูปสถานะรับสินค้า',
          style: TextStyle(fontSize: 18),
        ),
        const SizedBox(height: 20),
        Center(
          child: Container(
            height: 200, // ลดขนาดความสูงของช่องรูปภาพ
            width: 250, // ลดขนาดความกว้างของช่องรูปภาพ
            decoration: BoxDecoration(
              color: Color.fromRGBO(254, 172, 195, 1),
              borderRadius: BorderRadius.circular(0), // ทำให้เป็นสี่เหลี่ยม
              border: Border.all(color: Colors.black, width: 2), // กรอบสีดำ
            ),
            child: Center(
              child: Icon(Icons.camera_alt,
                  size: 80, color: Colors.black), // ลดขนาดไอคอน
            ),
          ),
        ),
        const SizedBox(height: 10),
        TextButton(
          onPressed: () {
            // โค้ดการเพิ่มรูปภาพ
          },
          style: TextButton.styleFrom(
            backgroundColor: Color.fromRGBO(255, 198, 207, 1), // สีพื้นหลัง
            padding: const EdgeInsets.symmetric(
                horizontal: 16, vertical: 8), // เพิ่ม padding
            shape: const RoundedRectangleBorder(
              // กำหนดรูปแบบให้เป็นสี่เหลี่ยม
              borderRadius: BorderRadius.zero, // ไม่มีมุมโค้ง
            ),
          ),
          child: const Text(
            'เพิ่มรูปภาพ',
            style: TextStyle(
                color: Colors.black, fontSize: 16), // เปลี่ยนสีข้อความเป็นขาว
          ),
        ),
      ],
    );
  }
}

class Order {
  final int id;
  final String senderName;
  final String senderPhoneNumber;
  final String senderAddress;
  final String receiverName;
  final String receiverPhoneNumber;
  final String receiverAddress;
  final List<OrderItem> items;

  Order({
    required this.id,
    required this.senderName,
    required this.senderPhoneNumber,
    required this.senderAddress,
    required this.receiverName,
    required this.receiverPhoneNumber,
    required this.receiverAddress,
    required this.items,
  });
}

class OrderItem {
  final String name;
  final String imageUrl;

  OrderItem({
    required this.name,
    required this.imageUrl,
  });
}
