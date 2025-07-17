import 'package:flutter/material.dart';
import 'dart:math' as math;

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildHomePage(context),
    );
  }

  Widget _buildHomePage(BuildContext context) {
    return Stack(
      children: [
        // Gradient background
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.blue.shade100, // Light color at top
                Colors.blue.shade900, // Dark color at bottom
              ],
            ),
          ),
        ),
        // Binary pattern overlay
        CustomPaint(
          size: Size.infinite,
          painter: BinaryPatternPainter(),
        ),
        // Main content
        Center(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 150),
                  const Text(
                    'Learning Binary',
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          offset: Offset(2, 2),
                          blurRadius: 4,
                          color: Colors.black26,
                        ),
                      ],
                    ),
                  ),
                  const Text(
                    'Made Simple',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          offset: Offset(2, 2),
                          blurRadius: 4,
                          color: Colors.black26,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 150),
                  ElevatedButton(
                    key: const Key('listRegionsButton'),
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
                      'Learning',
                      style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    key: const Key('searchButton'),
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
                      'Practice',
                      style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        // History button
        Positioned(
          top: 0,
          left: 0,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: ElevatedButton(
                key: const Key('history'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white.withOpacity(0.9),
                  foregroundColor: Colors.blue.shade800,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  minimumSize: const Size(100, 50),
                  elevation: 4,
                ),
                onPressed: () => (), // Setup Nav here
                child: const Text(
                  'History',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class BinaryPatternPainter extends CustomPainter {
  final math.Random random = math.Random(42); // Fixed seed for consistent pattern

  @override
  void paint(Canvas canvas, Size size) {
    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
    );

    const fontSize = 20.0;
    const spacing = 30.0;
    
    for (double y = 0; y < size.height; y += spacing) {
      for (double x = 0; x < size.width; x += spacing) {
        // Calculate opacity based on vertical position (more visible at bottom)
        final opacity = (y / size.height) * 0.3; // Max 30% opacity
        
        // Randomly choose 1 or 0
        final binary = random.nextBool() ? '1' : '0';
        
        textPainter.text = TextSpan(
          text: binary,
          style: TextStyle(
            color: Colors.white.withOpacity(opacity),
            fontSize: fontSize,
            fontFamily: 'monospace',
            fontWeight: FontWeight.bold,
          ),
        );
        
        textPainter.layout();
        
        // Add slight random offset for more organic look
        final offsetX = x + (random.nextDouble() - 0.5) * 10;
        final offsetY = y + (random.nextDouble() - 0.5) * 10;
        
        textPainter.paint(canvas, Offset(offsetX, offsetY));
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}