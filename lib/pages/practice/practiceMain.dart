import 'package:flutter/material.dart';
import 'package:learningbinary/utils/binaryBackground.dart';

class PracticePage extends StatefulWidget {
  const PracticePage({super.key});

  @override
  State<PracticePage> createState() => _PracticePageState();
}

class _PracticePageState extends State<PracticePage> {

  void _navigateToPracticeBinaryToDecimal(BuildContext context) {
    Navigator.of(context).pushNamed("practicebinarytodecimal");
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
                  ElevatedButton(
                    key: const Key('binaryToDecimal'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.blue.shade800,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      minimumSize: const Size(double.infinity, 100),
                      elevation: 8,
                    ),
                    onPressed: () => _navigateToPracticeBinaryToDecimal(context), // Setup Nav here
                    child: const Text(
                      'Binary to Numbers',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    key: const Key('TBAdecimalToBinary'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.blue.shade800,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      minimumSize: const Size(double.infinity, 100),
                      elevation: 8,
                    ),
                    onPressed: () => (), // Setup Nav here
                    child: const Text(
                      'TBA...',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
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
