import 'package:flutter/material.dart';
import 'package:flutter_delivery/pages/SendProduct.dart';
import 'package:flutter_delivery/pages/sender.dart';

class PackThingsPage extends StatefulWidget {
  @override
  _PackThingsPageState createState() => _PackThingsPageState();
}

class _PackThingsPageState extends State<PackThingsPage> {
  bool isProceeding = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('จัดส่งสินค้า'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              isProceeding
                  ? _buildStatusPhotoSection()
                  : _buildItemUploadSection(),
              const SizedBox(height: 50),
              const Align(
                alignment: Alignment.center,
                child: Text(
                  'สรุปรายการที่จัดส่ง',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                color: const Color(0xFFFFC0CB),
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'บริสา ดูดี',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const Text('0245879532'),
                    const Text('18/54 ต.นาบี อ.ดงพนม จ.อุตร 23519'),
                    const SizedBox(height: 10),
                    const Divider(),
                    const Text('รายการของที่ส่ง'),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        Image.asset(
                          'assets/images/fan.png',
                          height: 50,
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          'พัดลม',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50),
              ElevatedButton(
                onPressed: () {
                  if (isProceeding) {
                    // Navigate to SenderPage
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SenderProductPage()),
                    );
                  } else {
                    setState(() {
                      isProceeding = !isProceeding;
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: isProceeding
                      ? const Color(0xFF00FF00) // Light green color
                      : const Color(0xFFFFA500), // Orange color
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
                child: Text(
                  isProceeding ? 'ยืนยันการจัดส่งสินค้า' : 'ดำเนินการต่อ',
                  style: const TextStyle(fontSize: 18, color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildItemUploadSection() {
    return Container(
      padding: const EdgeInsets.all(15),
      color: const Color(0xFFFFC0CB),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'เพิ่มของที่จะส่ง',
            style: TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 10),
          Container(
            height: 150,
            width: double.infinity,
            color: Colors.white,
            child: const Icon(
              Icons.camera_alt_outlined,
              size: 80,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              // Implement image picking logic
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            ),
            child: const Text(
              'เพิ่มรูป',
              style: TextStyle(color: Colors.black),
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            decoration: InputDecoration(
              hintText: 'ชื่อของที่จะส่ง',
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              // Implement confirmation logic
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF00FF00),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
            ),
            child: const Text(
              'ตกลง',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusPhotoSection() {
    return Container(
      padding: const EdgeInsets.all(15),
      color: const Color(0xFFFFC0CB),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'ถ่ายรูปประกอบสถานะ',
            style: TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 10),
          Container(
            height: 150,
            width: double.infinity,
            color: Colors.white,
            child: const Icon(
              Icons.camera_alt_outlined,
              size: 80,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              // Implement camera functionality
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFF00FF),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
            ),
            child: const Text(
              'ถ่ายรูป',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
