import 'package:flutter/material.dart';

class SenderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('หน้าผู้ส่งสินค้า'),
      ),
      body: Center(
        child: const Text(
          'ยินดีต้อนรับสู่หน้าผู้ส่ง!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
