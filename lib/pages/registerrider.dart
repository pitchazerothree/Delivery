import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:uuid/uuid.dart';

class RegisterRider extends StatefulWidget {
  @override
  _RegisterRiderState createState() => _RegisterRiderState();
}

class _RegisterRiderState extends State<RegisterRider> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController vehicleController = TextEditingController();
  final CollectionReference users =
      FirebaseFirestore.instance.collection('register');

  File? _image; // Store the selected image
  String? _imageUrl; // Variable to store image URL
  final ImagePicker _picker = ImagePicker(); // Initialize ImagePicker

  // Function to pick an image from gallery or camera
  void pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(source: source);

      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
        });
        await _uploadImage(_image!);
      } else {
        Get.snackbar('Message Error !!!', 'เลือกสักรุปสิ 🤔',
            snackPosition: SnackPosition.TOP);
      }
    } catch (e) {
      log("Error picking image: $e" as num);
    }
  }

  Future<void> _uploadImage(File image) async {
    try {
      String fileName = '${Uuid().v4()}.jpg'; // Create a unique filename
      Reference ref = FirebaseStorage.instance.ref('userImage/$fileName');

      // Upload file to Firebase Storage
      UploadTask uploadTask = ref.putFile(image);
      TaskSnapshot snapshot = await uploadTask;

      if (snapshot.state == TaskState.success) {
        // Get the URL of the uploaded image
        _imageUrl = await ref.getDownloadURL();
        log('Image uploaded successfully: $_imageUrl' as num);
      } else {
        log('Upload failed with state: ${snapshot.state}' as num);
      }
    } catch (e) {
      log('Error uploading image: $e' as num);
    }
  }

  // Function to register user in Firestore with validation
  Future<void> registerRider() async {
    // Check if any field is empty or image URL is not available
    if (nameController.text.isEmpty ||
        passwordController.text.isEmpty ||
        phoneController.text.isEmpty ||
        vehicleController.text.isEmpty ||
        _imageUrl == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('กรุณากรอกข้อมูลให้ครบทุกช่อง และเลือกภาพโปรไฟล์'),
        ),
      );
      return; // Stop further execution if validation fails
    }

    // Check if phone number is exactly 10 digits
    if (phoneController.text.length != 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('หมายเลขโทรศัพท์ต้องมีความยาว 10 ตัว')),
      );
      return; // Stop further execution if phone number is invalid
    }

    // Check if phone number already exists
    QuerySnapshot snapshot =
        await users.where('phone', isEqualTo: phoneController.text).get();
    if (snapshot.docs.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('หมายเลขโทรศัพท์นี้เคยสมัครแล้ว!')),
      );
      return; // Stop further execution if phone number already exists
    }

    try {
      await users.add({
        'name': nameController.text,
        'password': passwordController.text,
        'phone': phoneController.text,
        'vehicle': vehicleController.text,
        'profileImage': _imageUrl, // Store image URL
        'type': 'Rider', // Add user type as 'Rider'
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('ลงทะเบียนสำเร็จ!')),
      );
      Navigator.of(context).pop(); // Go back after registration
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('การลงทะเบียนล้มเหลว: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(254, 172, 195, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(254, 172, 195, 1),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'สมัครสมาชิก(rider)',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              CircleAvatar(
                radius: 50,
                backgroundImage:
                    _image != null ? FileImage(_image!) : null, // Show image
                backgroundColor: Colors.white,
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () => pickImage(ImageSource.gallery),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                    child: const Text(
                      'เพิ่มรูปจากแกลเลอรี',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () => pickImage(ImageSource.camera),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                    child: const Text(
                      'ถ่ายรูป',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              buildTextField("ชื่อ :", nameController),
              buildTextField("รหัสผ่าน :", passwordController,
                  isPassword: true),
              buildTextField("หมายเลขโทรศัพท์ :", phoneController,
                  keyboardType: TextInputType.phone),
              buildTextField("ทะเบียนรถ :", vehicleController),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: registerRider,
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'สมัครสมาชิก',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String labelText, TextEditingController controller,
      {bool isPassword = false,
      TextInputType keyboardType = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              labelText,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 5),
          TextFormField(
            controller: controller,
            obscureText: isPassword,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.white),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
