import 'package:flutter/material.dart';
import 'package:learningbinary/utils/binaryBackground.dart';

class SupportPage extends StatefulWidget {
  const SupportPage({super.key});
  @override
  State<SupportPage> createState() => _SupportPageState();
}

class _SupportPageState extends State<SupportPage> {
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
          // Binary pattern overlay
          CustomPaint(size: Size.infinite, painter: BinaryPatternPainter()),
          Center(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 150),
                  Text("Support"),
                ],
              ),
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
