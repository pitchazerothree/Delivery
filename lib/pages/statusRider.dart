import 'package:flutter/material.dart';

class StatusPage extends StatefulWidget {
  @override
  _StatusPageState createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {
  bool _showRiderCard = false; // สถานะการแสดงผลของการ์ด

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('สถานะการจัดส่ง'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              const SizedBox(
                width: 300, // กำหนดความกว้างของการ์ด
                child: Card(
                  color: Color.fromARGB(255, 243, 164, 229), // สีการ์ด
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero, // ไม่มีการโค้งมุม
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(16.0), // ระยะห่างภายในการ์ด
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'สถานะการจัดส่ง : ไรเดอร์กำลังเดินทางมาส่งสินค้า',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10), // ระยะห่างระหว่างข้อความและภาพ
              Image.asset(
                'assets/images/logo.png', // เปลี่ยนเป็นพาธของภาพที่คุณต้องการแสดง
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 5),
              const Text(
                'ตำแหน่งของ Rider',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              // Placeholder for map
              Expanded(
                child: Container(
                  color: Colors.grey[300],
                  child: const Center(
                    child: Text('แผนที่', style: TextStyle(fontSize: 18)),
                  ),
                ),
              ),
              const SizedBox(height: 80),
            ],
          ),
          // ปุ่ม Rider ที่อยู่ด้านล่างสุด
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _showRiderCard = !_showRiderCard;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 243, 164, 229),
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                  ),
                  child: const Text(
                    'Rider',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          ),
          // การ์ด Rider แบบที่แสดงตรงกลางหน้าจอ
          if (_showRiderCard)
            Align(
              alignment: Alignment.center,
              child: AnimatedOpacity(
                opacity: _showRiderCard ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 500),
                child: Container(
                  // Wrap the Card in a Container
                  width: 300, // Set your desired width here
                  child: Card(
                    color: Colors.pink[100],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Rider',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    SizedBox(
                                        height:
                                            10), // Space between the text and the avatar
                                    CircleAvatar(
                                      backgroundColor: Colors.white,
                                      radius: 25,
                                      child: Icon(Icons.person, size: 40),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Text('ชื่อ: ปัญญา วิสัย',
                              style: TextStyle(fontSize: 16)),
                          Text('เบอร์โทร: 0245687955',
                              style: TextStyle(fontSize: 16)),
                          Text('ทะเบียนรถ: กข 254',
                              style: TextStyle(fontSize: 16)),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
