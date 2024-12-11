import 'package:flutter/material.dart';

class qrcode extends StatefulWidget {
  const qrcode({super.key});

  @override
  State<qrcode> createState() => _qrcodeState();
}

class _qrcodeState extends State<qrcode> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text("data")
        ],
      ),
    );
  }
}