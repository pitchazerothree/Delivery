import 'package:flutter/material.dart';
import 'orderSender.dart'; // นำเข้าหน้านี้เพื่อไปที่หน้า orderSender

class RealtimeRiderPage extends StatelessWidget {
  final String myLocation = 'ถิงถิง บิงซูน้ำขิง'; // ตำแหน่งของฉัน
  final String destination = 'มหาวิทยาลัยมหาสารคาม'; // จุดหมาย
  final double distance = 2.0; // ระยะทางเป็นกิโลเมตร
  final int time = 4; // เวลาเป็นนาที

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Placeholder สำหรับแผนที่
          Container(
            height: MediaQuery.of(context).size.height * 0.5, // ครึ่งหนึ่งของจอ
            width: MediaQuery.of(context).size.width,
            color: Colors.grey[300], // สีพื้นหลังของแผนที่ (แทนที่แผนที่จริง)
            child: const Center(
              child: Text('แผนที่จะแสดงที่นี่', style: TextStyle(fontSize: 20)),
            ),
          ),
          // Card ที่แสดงข้อมูลตำแหน่งของฉันและจุดหมาย
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center, // จัดตรงกลาง
                children: [
                  const Text('เส้นทาง',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 20), // ช่องว่างระหว่าง 'เส้นทาง' กับการ์ด
                  // การ์ดที่ครอบคลุมทั้งตำแหน่งของฉัน, จุดหมาย, และระยะทาง
                  _buildCombinedInfoCard(
                      myLocation, destination, distance, time),
                  const SizedBox(height: 55), // ลดช่องว่างระหว่างการ์ดกับปุ่ม
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => OrderSenderPage()), // เปลี่ยนไปที่หน้า orderSender
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Color.fromRGBO(240, 49, 103, 1), // สีของปุ่ม
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      'สิ้นสุดการเดินทาง',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ปุ่มปิดที่มุมขวาบน
          Positioned(
            top: 40,
            right: 20,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context); // ปิดหน้าเมื่อกดปุ่มนี้
              },
              child: const Icon(Icons.close, size: 40, color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  // ฟังก์ชันสร้างการ์ดที่รวมข้อมูลตำแหน่งของฉัน จุดหมาย และระยะทาง
  Widget _buildCombinedInfoCard(
      String myLocation, String destination, double distance, int time) {
    return Stack(
      children: [
        // การ์ดใหญ่
        Container(
          padding: const EdgeInsets.all(15), // Padding ภายในการ์ดใหญ่
          decoration: BoxDecoration(
            color: Color.fromRGBO(254, 172, 195, 1), // สีพื้นหลังของการ์ดใหญ่
            borderRadius: BorderRadius.circular(10), // มุมโค้งของการ์ดใหญ่
            boxShadow: [
              BoxShadow(
                color: Colors.black12, // เงาของการ์ด
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.center, // จัดข้อความให้ตรงกลาง
            mainAxisAlignment:
                MainAxisAlignment.center, // จัดให้ตรงกลางในแนวตั้ง
            children: [
              const SizedBox(height: 15),
              _buildSmallCard('ตำแหน่งของฉัน :', myLocation),
              const SizedBox(height: 15), // ช่องว่างระหว่างบรรทัด
              _buildSmallCard('จุดมุ่งหมาย :', destination),
              const SizedBox(height: 60),
            ],
          ),
        ),
        // การ์ดระยะทางที่ทับซ้อน
        Positioned(
          bottom: 0, // ตำแหน่งที่ทับซ้อน
          left: 0,
          right: 0,
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Color.fromRGBO(255, 206, 249, 1), // เปลี่ยนสีพื้นหลังเป็นสีที่คุณต้องการ
              borderRadius: BorderRadius.circular(6), // มุมโค้ง
              boxShadow: [
                BoxShadow(
                  color: Colors.black12, // เงาของการ์ด
                  blurRadius: 3,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment:
                  MainAxisAlignment.center, // จัดข้อความไว้ตรงกลาง
              children: [
                Text(
                  'ระยะทาง : $distance กิโลเมตร | เวลา : $time นาที',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ฟังก์ชันสร้างการ์ดเล็ก
  Widget _buildSmallCard(String label, String value) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white, // สีพื้นหลังของการ์ด
        borderRadius: BorderRadius.circular(5), // มุมโค้งของการ์ด
        border: Border.all(
          color: Colors.black, // กรอบสีดำ
          width: 1.5,
        ),
      ),
      child: Row(
        children: [
          Text(
            label, // แสดงข้อความ label เช่น "ตำแหน่งของฉัน:"
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(width: 5),
          Text(
            value, // แสดงข้อมูลเช่น "ถิงถิง บิงซูน้ำขิง"
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  // ฟังก์ชันสร้างการ์ดที่เต็มความกว้าง (สำหรับระยะทางและเวลา)
  Widget _buildFullWidthCard(String value) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Color.fromRGBO(255, 206, 249, 1), // สีพื้นหลังของการ์ด
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center, // จัดข้อความไว้ตรงกลาง
        children: [
          Text(
            value, // แสดงข้อมูลเช่น "2 กิโลเมตร | 4 นาที"
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
