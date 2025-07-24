import 'package:flutter/material.dart';
import 'dart:math';

class BinaryToDecimalPage extends StatefulWidget {
  const BinaryToDecimalPage({super.key});

  @override
  State<BinaryToDecimalPage> createState() => _BinaryToDecimalPageState();
}

class _BinaryToDecimalPageState extends State<BinaryToDecimalPage> {
  int getNumber() {
    return Random().nextInt(256);
  }

  String getBinaryNumber(num) {
    return num.toRadixString();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  // Light colour on top and dark on bottom
                  Colors.green.shade100,
                  const Color.fromARGB(255, 6, 132, 14),
                ],
              ),
            ),
          ),
          
          
          //back button
          Positioned(
            top: 0,
            left: 0,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, size: 28),
                  color: Colors.blueAccent,
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
