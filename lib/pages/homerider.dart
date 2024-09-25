import 'package:flutter/material.dart';
import 'package:flutter_delivery/pages/login.dart';

class HomeRiderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(110.0), // ปรับขนาด AppBar ให้เล็กลง
        child: AppBar(
          backgroundColor: Color.fromRGBO(255, 198, 207, 1),
          elevation: 0,
          flexibleSpace: Padding(
            padding: const EdgeInsets.only(top: 35.0), // ลดระยะห่างจากด้านบน
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    const SizedBox(width: 20), // เพิ่มระยะห่างจากขอบซ้าย
                    CircleAvatar(
                      backgroundImage: AssetImage('assets/images/logo.png'),
                      radius: 35, // ปรับขนาดรูปโปรไฟล์ให้เล็กลง
                    ),
                    const SizedBox(width: 20), // ระยะห่างระหว่างรูปกับข้อความ
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
                              builder: (context) =>
                                  LoginPage()), // ต้องมีวงเล็บ () ที่ LoginPage
                        );
                      },
                      icon: Icon(Icons.logout),
                      color: Colors.black,
                    ),
                    const SizedBox(width: 15), // เพิ่มระยะห่างจากขอบขวา
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
            textAlign: TextAlign.center, // จัดให้อยู่กลาง
          ),
          const SizedBox(height: 20),
          Card(
            color: Color.fromRGBO(255, 198, 207, 1),
            margin: const EdgeInsets.symmetric(horizontal: 20.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: const Text(
                      'ออเดอร์ที่ 50',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: const Text(
                      'ผู้ส่ง : ตะวันชา ฟ้าใส',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text('เบอร์โทร: 0222222222'),
                  const Text('ที่อยู่ : 55/555 ต.ตรง อ.นบน จ.อออออ'),
                  const Divider(height: 20, thickness: 1, color: Colors.black),
                  Center(
                    child: const Text(
                      'ผู้รับ : วันวาน ถึง',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text('เบอร์โทร: 0245896125'),
                  const Text('ที่อยู่ : 55/555 ต.ตรง อ.ทกท จ.จงพพพ'),
                  const Divider(height: 20, thickness: 1, color: Colors.black),
                  const Text(
                    'รายการของที่สั่ง',
                    style: TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 10),
                  ListView(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      ListTile(
                        leading:
                            Image.asset('assets/images/logo.png'), // รูปสินค้า
                        title: Text('ชาเขียวใบ'),
                      ),
                      ListTile(
                        leading: Image.asset('assets/images/logo.png'),
                        title: Text('ข้าวไข่เจียว+ผัดผง'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Text('5 กิโลเมตร'),
                      const SizedBox(width: 30), // ขยับระยะห่าง
                      Container(
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(
                              240, 49, 103, 1), // เปลี่ยนสีพื้นหลัง
                          borderRadius: BorderRadius.circular(8), // มุมโค้ง
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
                      height: 20,
                      thickness: 1,
                      color: Colors.black), // เส้นบรรทัดด้านล่างของรายการที่ส่ง
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
                              Color.fromRGBO(254, 116, 116, 1), // สีพื้นหลัง
                        ),
                        child: const Text('ยกเลิกออเดอร์',
                            style: TextStyle(
                                color: Colors.white)), // เปลี่ยนสีตัวหนังสือ
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // โค้ดยืนยันรับออเดอร์
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Color.fromRGBO(255, 174, 0, 1), // สีพื้นหลัง
                        ),
                        child: const Text('ยืนยันรับออเดอร์',
                            style: TextStyle(
                                color: Colors.white)), // เปลี่ยนสีตัวหนังสือ
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
