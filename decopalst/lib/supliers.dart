import 'package:flutter/material.dart';

class subperson extends StatefulWidget {
  const subperson({super.key});

  @override
  State<subperson> createState() => _subpersonState();
}

class _subpersonState extends State<subperson> {
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