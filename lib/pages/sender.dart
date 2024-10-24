import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore package
import 'package:flutter_delivery/pages/SendProduct.dart';
import 'package:flutter_delivery/pages/PackThings.dart'; // Import the PackThings page

class SenderPage extends StatefulWidget {
  @override
  _SenderPageState createState() => _SenderPageState();
}

class _SenderPageState extends State<SenderPage> {
  int _selectedIndex = 0; // To track the currently selected index
  final TextEditingController phoneNoCtl =
      TextEditingController(); // ใช้ phoneNoCtl สำหรับค้นหา

  // Create TextEditingControllers for name and address
  TextEditingController nameNoCtl = TextEditingController();
  TextEditingController addressNoCtl = TextEditingController();

  List<Map<String, String>> searchResults = []; // Store search results

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Update the selected index
    });

    // Navigate to the appropriate page based on the selected index
    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SenderPage()), // Current Page
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => SenderProductPage()), // Product Page
      );
    }
  }

  Future<void> _searchUser() async {
    // Clear previous search results
    searchResults.clear();

    // Get the input from the phoneNoCtl TextField
    String phoneNumber = phoneNoCtl.text;

    // Query the Firestore database
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('register')
        .where('phone',
            isEqualTo: phoneNumber) // Adjust this field name as necessary
        .get();

    // Process the results
    for (var doc in snapshot.docs) {
      // Add each user to the search results
      searchResults.add({
        'name': doc[
            'name'], // Adjust field names according to your Firestore structure
        'phone': doc['phone'],
        'address': doc['address'],
      });
    }

    // Refresh the UI
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ค้นหาผู้รับ'), // App bar title
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              Image.asset(
                'assets/images/logo.png',
                height: 150,
                fit: BoxFit.contain,
              ),
              SizedBox(height: 20),
              const Text(
                'ค้นหาผู้รับโดยใช้หมายเลขโทรศัพท์',
                style: TextStyle(fontSize: 15),
              ),
              SizedBox(height: 10),
              TextField(
                controller: phoneNoCtl, // Set the controller here
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color(0xFFFFC0CB),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                  ),
                ),
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: _searchUser, // Call search function
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFFFC0CB),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                ),
                child: Text(
                  'ค้นหา',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              SizedBox(height: 20),
              // Align text to the left
              Align(
                alignment: Alignment.centerLeft, // Move text to the left
                child: const Text(
                  'ผลการค้นหา',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 10),
              // Display search results
              if (searchResults.isEmpty)
                Text('ไม่พบผู้รับที่ค้นหา') // Message when no results found
              else
                Column(
                  children: searchResults
                      .map((recipient) => buildRecipientCard(
                            recipient['name']!,
                            recipient['phone']!,
                            recipient['address']!,
                          ))
                      .toList(),
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
        currentIndex: _selectedIndex, // Highlight the current index
        backgroundColor: Color.fromRGBO(254, 172, 195, 1),
        selectedItemColor: Colors.black,
        onTap: _onItemTapped, // Handle tap events
      ),
    );
  }

  Widget buildRecipientCard(String name, String phone, String address) {
    // Set the text fields with the found recipient's information
    nameNoCtl.text = name;
    phoneNoCtl.text = phone; // Optional: You can display this as well
    addressNoCtl.text = address;

    return Card(
      color: Color(0xFFFFC0CB),
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              // Allow text to take available space
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis, // Prevent overflow
                  ),
                  Text(
                    phone,
                    style: TextStyle(fontSize: 16),
                    overflow: TextOverflow.ellipsis, // Prevent overflow
                  ),
                  Text(
                    address,
                    style: TextStyle(fontSize: 14),
                    overflow: TextOverflow.ellipsis, // Prevent overflow
                  ),
                ],
              ),
            ),
            SizedBox(width: 10), // Add spacing between text and button
            ElevatedButton(
              onPressed: () {
                // Navigate to the PackThings page when selected
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        PackThingsPage(), // Navigate to PackThings
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0.0),
                ),
              ),
              child: Text(
                'เลือก',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
