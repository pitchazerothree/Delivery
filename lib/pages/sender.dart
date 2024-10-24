import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_delivery/pages/PackThings.dart';
import 'package:flutter_delivery/pages/SendProduct.dart';
import 'package:flutter_delivery/pages/model/Response/getUsers_res.dart';

class SenderPage extends StatefulWidget {
  @override
  _SenderPageState createState() => _SenderPageState();
}

class _SenderPageState extends State<SenderPage> {
  int _selectedIndex = 0;
  final TextEditingController phoneNoCtl = TextEditingController();
  List<GetUsersRes> users = []; // เก็บรายการผู้ใช้ที่ค้นหาได้
  String _userNoResultMessage = ''; // ข้อความเมื่อไม่พบผู้ใช้
  bool isLoading = false; // แสดงสถานะการโหลดข้อมูล
  late Future<void> loadData;

  @override
  void initState() {
    super.initState();
    loadData = getMember();
  }

  // ฟังก์ชันเปลี่ยนหน้าใน BottomNavigationBar
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SenderPage()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SenderProductPage()),
      );
    }
  }

  // ฟังก์ชันค้นหาผู้ใช้จาก Firestore ด้วยเบอร์โทร
  void _searchUsers(String query) async {
    setState(() {
      isLoading = true; // เริ่มแสดงการโหลด
    });

    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('register').get();

      // กรองข้อมูลผู้ใช้ตามหมายเลขโทรศัพท์
      List<GetUsersRes> foundUsers = querySnapshot.docs
          .map((doc) {
            Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
            if (data.containsKey('phone') && data['phone'] is String) {
              String phone = data['phone'];
              if (phone.contains(query)) {
                return GetUsersRes.fromJson(data, doc.id);
              }
            }
            return null;
          })
          .where((user) => user != null) // กรองค่าที่เป็น null
          .cast<GetUsersRes>()
          .toList();

      setState(() {
        users = foundUsers; // อัปเดตรายการผู้ใช้
        _userNoResultMessage = users.isEmpty ? 'ไม่พบผู้ใช้ที่ค้นหา' : '';
        isLoading = false; // หยุดการโหลด
      });

      log("Found Users: ${foundUsers.map((user) => user.name).toList()}");
    } catch (e) {
      log("เกิดข้อผิดพลาด: $e");
      setState(() {
        isLoading = false; // หยุดการโหลดเมื่อเกิดข้อผิดพลาด
      });
    }
  }

  Future<void> getMember() async {
    try {
      // เข้าถึง collection "Users" และกรองด้วย type เป็น "user"
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('register')
          .where('type', isEqualTo: 'user')
          .get();

      // แปลงข้อมูลจากเอกสารใน QuerySnapshot เป็น List<GetUsersRes>
      List<GetUsersRes> allUsers = getUsersResFromQuerySnapshot(querySnapshot);

      setState(() {
        users = allUsers; // กำหนด users ให้เป็น List<GetUsersRes>
        log('data : $allUsers');
        _userNoResultMessage = allUsers.isEmpty ? "ไม่มีผู้ใช้ที่จะแสดง" : '';
      });
    } catch (e) {
      log('Error fetching users: $e');
      print('Error: $e');
    }
  }

  // ฟังก์ชันสร้างการ์ดแสดงผลผู้ใช้
  Widget buildRecipientCard(GetUsersRes user) {
    return Card(
      color: const Color(0xFFFFC0CB),
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.name,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    user.phone,
                    style: const TextStyle(fontSize: 16),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    user.address,
                    style: const TextStyle(fontSize: 14),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PackThingsPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0.0),
                ),
              ),
              child: const Text(
                'เลือก',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ค้นหาผู้รับ'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Image.asset(
                'assets/images/logo.png',
                height: 150,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 20),
              const Text(
                'ค้นหาผู้รับโดยใช้หมายเลขโทรศัพท์',
                style: TextStyle(fontSize: 15),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: phoneNoCtl,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFFFFC0CB),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                  ),
                ),
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  _searchUsers(phoneNoCtl.text); // เรียกฟังก์ชันค้นหา
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFFC0CB),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                ),
                child: const Text(
                  'ค้นหา',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              const SizedBox(height: 20),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'ผลการค้นหา',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 10),
              if (isLoading)
                const CircularProgressIndicator() // แสดงการโหลด
              else if (users.isEmpty)
                Text(_userNoResultMessage) // แสดงข้อความเมื่อไม่พบข้อมูล
              else
                Column(
                  children: users.map((user) {
                    return buildRecipientCard(user); // แสดงการ์ดผู้ใช้
                  }).toList(),
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
        currentIndex: _selectedIndex,
        backgroundColor: const Color.fromRGBO(254, 172, 195, 1),
        selectedItemColor: Colors.black,
        onTap: _onItemTapped,
      ),
    );
  }
}
