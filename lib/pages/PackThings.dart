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
        title: Text('จัดส่งสินค้า'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
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
              SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'สรุปรายการที่จัดส่ง',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 10),
              Container(
                color: Color(0xFFFFC0CB),
                padding: EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'บริสา ดูดี',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text('0245879532'),
                    Text('18/54 ต.นาบี อ.ดงพนม จ.อุตร 23519'),
                    SizedBox(height: 10),
                    Divider(),
                    Text('รายการของที่ส่ง'),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Image.asset(
                          'assets/images/fan.png',
                          height: 50,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'พัดลม',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
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
                      ? Color(0xFF00FF00) // Light green color
                      : Color(0xFFFFA500), // Orange color
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
                child: Text(
                  isProceeding ? 'ยืนยันการจัดส่งสินค้า' : 'ดำเนินการต่อ',
                  style: TextStyle(fontSize: 18, color: Colors.black),
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
      padding: EdgeInsets.all(15),
      color: Color(0xFFFFC0CB),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'เพิ่มของที่จะส่ง',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 10),
          Container(
            height: 150,
            width: double.infinity,
            color: Colors.white,
            child: Icon(
              Icons.camera_alt_outlined,
              size: 80,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              // Implement image picking logic
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            ),
            child: Text(
              'เพิ่มรูป',
              style: TextStyle(color: Colors.black),
            ),
          ),
          SizedBox(height: 10),
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
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              // Implement confirmation logic
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF00FF00),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
            ),
            child: Text(
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
      padding: EdgeInsets.all(15),
      color: Color(0xFFFFC0CB),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'ถ่ายรูปประกอบสถานะ',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 10),
          Container(
            height: 150,
            width: double.infinity,
            color: Colors.white,
            child: Icon(
              Icons.camera_alt_outlined,
              size: 80,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              // Implement camera functionality
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFFFF00FF),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
            ),
            child: Text(
              'ถ่ายรูป',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
