import 'package:flutter/material.dart';

class emki extends StatefulWidget {
  const emki({super.key});

  @override
  State<emki> createState() => _emkiState();
}

class _emkiState extends State<emki> {
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