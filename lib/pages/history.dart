import 'package:flutter/material.dart';
import 'package:learningbinary/utils/binaryBackground.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
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

          //back buttons
          
          // Positioned(
          //   top: 0,
          //   left: 0,
          //   child: SafeArea(
          //     child: Padding(
          //       padding: const EdgeInsets.all(8.0),
          //       child: BackButton(color: Colors.white),
          //     ),
          //   ),
          // ),

          // Positioned(top: 30, left: 8, child: BackButton(color: Colors.white)),
          
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
