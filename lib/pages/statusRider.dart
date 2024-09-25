import 'package:flutter/material.dart';

class StatusPage extends StatelessWidget {
  final int orderId;

  StatusPage({required this.orderId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('สถานะการจัดส่ง'),
      ),
      body: Center(
        child: Text(
          'สถานะการจัดส่งของออเดอร์ที่ $orderId',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
