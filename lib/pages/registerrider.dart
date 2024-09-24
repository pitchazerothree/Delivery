import 'package:flutter/material.dart';

class RegisterRider extends StatefulWidget {
  @override
  _RegisterRiderState createState() => _RegisterRiderState();
}

class _RegisterRiderState extends State<RegisterRider> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController vehicleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 198, 207, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(255, 198, 207, 1),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'สมัครสมาชิก(rider)',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold), // Bold title text
        ),
        centerTitle: true, // Center the title
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.white,
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  // Function to upload image
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'เพิ่มรูปภาพ',
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold), // Bold button text
                ),
              ),
              SizedBox(height: 20),
              buildTextField("ชื่อ :", nameController),
              buildTextField("รหัสผ่าน :", passwordController, isPassword: true),
              buildTextField("หมายเลขโทรศัพท์ :", phoneController, keyboardType: TextInputType.phone),
              buildTextField("ทะเบียนรถ :", vehicleController),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  // Submit form logic
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text(
                  'สมัครสมาชิก',
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold), // Bold button text
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String labelText, TextEditingController controller,
      {bool isPassword = false, TextInputType keyboardType = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              labelText,
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold, // Bold label text
              ),
            ),
          ),
          SizedBox(height: 5),
          TextFormField(
            controller: controller,
            obscureText: isPassword,
            keyboardType: keyboardType,  // Use the passed keyboardType here
            decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: Colors.white, // Border color when not focused
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: Colors.black, // Border color when focused
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
