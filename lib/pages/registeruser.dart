import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:flutter_delivery/pages/login.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:developer';
import 'dart:io';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;
import 'package:geocoding/geocoding.dart'; // เพิ่มการนำเข้า geocoding
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterUser extends StatefulWidget {
  const RegisterUser({super.key});

  @override
  State<RegisterUser> createState() => _MemberUserPageState();
}

class _MemberUserPageState extends State<RegisterUser> {
  final _formKey = GlobalKey<FormState>();
  File? _image;
  String? _imageUrl;
  TextEditingController nameNoCtl = TextEditingController();
  TextEditingController phoneNoCtl = TextEditingController();
  TextEditingController addressNoCtl = TextEditingController();
  TextEditingController passwordNoCtl = TextEditingController();
  TextEditingController confirmpasswordNoCtl = TextEditingController();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  LatLng latLng = LatLng(15.998009549056942, 102.53815639596311);
  double latitude = 0.0;
  double longitude = 0.0;
  MapController mapController = MapController();
  List<Marker> markers = [];

  @override
  void initState() {
    super.initState();
    _determinePosition().then((position) {
      setState(() {
        latLng = LatLng(
            position.latitude, position.longitude); // อัปเดตค่าตำแหน่งเริ่มต้น
        latitude = position.latitude; // อัปเดตค่า latitude
        longitude = position.longitude; // อัปเดตค่า longitude
      });
    }).catchError((error) {
      log('Error getting current position: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(254, 172, 195, 1),
        title: const Text(
          'Get Started',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      backgroundColor: Color.fromRGBO(254, 172, 195, 1),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey, // ผูกฟอร์มกับ GlobalKey
          child: Column(
            children: [
              const SizedBox(height: 20),
              Center(
                child: GestureDetector(
                  onTap: () {
                    _pickImage();
                  },
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.white,
                    backgroundImage: _image != null ? FileImage(_image!) : null,
                    child: _image == null
                        ? const Icon(
                            Icons.person,
                            size: 50,
                            color: Colors.grey,
                          )
                        : null,
                  ),
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  _pickImage(); // เรียกใช้เมธอด _pickImage โดยตรง
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
                child: Text(
                  'เพิ่มรูปภาพ',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                    child: Text('ชื่อ'),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 20.0),
                    child: TextFormField(
                      controller: nameNoCtl,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'กรุณากรอกชื่อ';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        filled: true, // เปิดใช้งาน fill
                        fillColor: Colors.white, // ตั้งค่าสีพื้นหลังเป็นสีขาว
                        border: OutlineInputBorder(
                          borderSide: BorderSide(width: 1),
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                    child: Text('รหัสผ่าน'),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 10),
                    child: TextFormField(
                      controller: passwordNoCtl,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'กรุณากรอกรหัสผ่าน';
                        }
                        return null;
                      },
                      obscureText: true,
                      decoration: const InputDecoration(
                        filled: true, // เปิดใช้งาน fill
                        fillColor: Colors.white, // ตั้งค่าสีพื้นหลังเป็นสีขาว
                        border: OutlineInputBorder(
                          borderSide: BorderSide(width: 1),
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                    child: Text('หมายเลขโทรศัพท์'),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 20.0),
                    child: TextFormField(
                      controller: phoneNoCtl,
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'กรุณากรอกหมายเลขโทรศัพท์';
                        } else if (value.length != 10) {
                          return 'เบอร์โทรศัพท์ต้องมี 10 หลัก';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        filled: true, // เปิดใช้งาน fill
                        fillColor: Colors.white, // ตั้งค่าสีพื้นหลังเป็นสีขาว
                        border: OutlineInputBorder(
                          borderSide: BorderSide(width: 1),
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                    child: Text('ที่อยู่'),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 20.0),
                    child: TextFormField(
                      controller: addressNoCtl,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'กรุณากรอกที่อยู่';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        filled: true, // เปิดใช้งาน fill
                        fillColor: Colors.white, // ตั้งค่าสีพื้นหลังเป็นสีขาว
                        border: OutlineInputBorder(
                          borderSide: BorderSide(width: 1),
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                    child: Text('เพิ่มที่อยู่จาก GPS'),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 20.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          _showMap();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 246, 243, 243),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                        child: const Text(
                          'GPS',
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                    child: Text(
                      'Latitude: ${latitude.toString()}, Longitude: ${longitude.toString()}',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Divider(color: Colors.black),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                    child: Text('ยืนยันรหัสผ่าน'),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 10),
                    child: TextFormField(
                      controller: confirmpasswordNoCtl,
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'กรุณายืนยันรหัสผ่าน';
                        } else if (value != passwordNoCtl.text) {
                          return 'รหัสผ่านไม่ตรงกัน';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        filled: true, // เปิดใช้งาน fill
                        fillColor: Colors.white, // ตั้งค่าสีพื้นหลังเป็นสีขาว
                        border: OutlineInputBorder(
                          borderSide: BorderSide(width: 1),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 20.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        // ถ้าผ่านการตรวจสอบ ให้ดำเนินการลงทะเบียน
                        register();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('กรุณากรอกข้อมูลให้ครบถ้วน'),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 255, 253, 253),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                    child: const Text(
                      'สมัครสมาชิก',
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _pickImage() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? pickedFile =
          await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
        });
        await _uploadImage(_image!);
        log("ImageUrl");
      } else {
        Get.snackbar('Message Error !!!', 'เลือกสักรุปสิ 🤔',
            snackPosition: SnackPosition.TOP);
        log("No image selected");
      }
    } catch (e) {
      log("Error picking image: $e");
    }
  }

  Future<void> _uploadImage(File image) async {
    try {
      log("filename");
      String fileName = '${Uuid().v4()}.jpg'; // เปลี่ยนชื่อไฟล์ให้ไม่ซ้ำ
      Reference ref = FirebaseStorage.instance.ref('userImage/$fileName');

      // อัปโหลดไฟล์ไปยัง Firebase Storage
      UploadTask uploadTask = ref.putFile(image);
      TaskSnapshot snapshot = await uploadTask;
      log("url");
      // ตรวจสอบสถานะการอัปโหลด
      if (snapshot.state == TaskState.success) {
        // รับ URL ของรูปภาพที่อัปโหลด
        _imageUrl = await ref.getDownloadURL();
        log('Image uploaded successfully: $_imageUrl'); // แสดง URL ใน log
      } else {
        log('Upload failed with state: ${snapshot.state}');
      }
    } catch (e) {
      log('Error uploading image: $e');
    }
  }

  Future<void> _showMap() async {
    showDialog(
      context: context,
      builder: (context) {
        LatLng tempLatLng = latLng; // ใช้ตำแหน่งอุปกรณ์เป็นค่าเริ่มต้น
        return AlertDialog(
          title: const Text('Map'),
          content: SizedBox(
            width: double.maxFinite,
            height: 400,
            child: StatefulBuilder(
              builder: (context, setState) {
                return FlutterMap(
                  options: MapOptions(
                    initialCenter: tempLatLng, // ใช้ตำแหน่งอุปกรณ์
                    initialZoom: 13.0,
                    onTap: (tapPosition, point) {
                      // อัปเดตค่าพิกัดเมื่อจิ้มบนแผนที่
                      setState(() {
                        tempLatLng = point;
                        latitude = point.latitude;
                        longitude = point.longitude;
                        _updateAddress(
                            point); // เรียกใช้งานฟังก์ชันเพื่ออัปเดตที่อยู่
                        log('Latitude: ${point.latitude}, Longitude: ${point.longitude}');
                      });
                    },
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                      subdomains: ['a', 'b', 'c'],
                    ),
                    MarkerLayer(
                      markers: [
                        Marker(
                          width: 80.0,
                          height: 80.0,
                          point: tempLatLng,
                          child: const Icon(
                            Icons.location_pin,
                            color: Colors.red,
                            size: 40.0,
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                // อัปเดตค่าพิกัดสุดท้ายก่อนปิด dialog
                setState(() {
                  latLng = tempLatLng;
                });
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _updateAddress(LatLng point) async {
    try {
      // แปลงพิกัด GPS เป็นที่อยู่
      List<Placemark> placemarks = await placemarkFromCoordinates(
        point.latitude,
        point.longitude,
      );

      // รับที่อยู่และอัปเดตใน TextField
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        String address =
            '${place.name}, ${place.locality}, ${place.postalCode}, ${place.country}';
        setState(() {
          addressNoCtl.text = address; // อัปเดตที่อยู่ใน TextField
        });
      }
    } catch (e) {
      log('Error getting address: $e');
    }
  }

  void _showCoordinates(LatLng point) {
    longitude = point.longitude;
    latitude = point.latitude;
  }

  Future<Position> _determinePosition() async {
    LocationPermission permission;

    // ตรวจสอบสถานะการอนุญาต
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        throw Exception('Location permissions are denied');
      }
    }

    // รับพิกัดปัจจุบัน
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  void register() async {
    // Validate inputs
    if (!_formKey.currentState!.validate()) return;

    String name = nameNoCtl.text.trim();
    String phone = phoneNoCtl.text.trim();
    String address = addressNoCtl.text.trim();
    String password = passwordNoCtl.text.trim();

    // Ensure latitude, longitude, and image URL are valid
    if (latitude == 0.0 || longitude == 0.0 || _imageUrl == null) {
      Get.snackbar('Message Error !!!', 'กรุณาเพิ่มที่อยู่จาก GPS และรูปภาพ',
          snackPosition: SnackPosition.TOP);
      return;
    }

    try {
      CollectionReference users =
          FirebaseFirestore.instance.collection('register');

      // Check if the phone number already exists
      DocumentSnapshot existingUser = await users.doc(phone).get();
      if (existingUser.exists) {
        Get.snackbar(
            'Message Error !!!', 'หมายเลขโทรศัพท์นี้มีการลงทะเบียนแล้ว',
            snackPosition: SnackPosition.TOP);
        return;
      }

      // Add the user to Firestore
      await users.doc(phone).set({
        // Store using phone number as the document ID
        'name': name,
        'phone': phone,
        'address': address,
        'password':
            password, // Consider using Firebase Auth for better security
        'image': _imageUrl,
        'latitude': latitude,
        'longitude': longitude,
        'type': 'user',
      });

      log('User registered successfully in Firestore');

      // Navigate to the login page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    } catch (error) {
      log('Error during registration: $error');
      Get.snackbar('Message Error !!!', 'Error during registration: $error',
          snackPosition: SnackPosition.TOP);
    }
  }
}
