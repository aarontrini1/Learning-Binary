import 'package:flutter/material.dart';
import 'dart:math' as math;

class BinaryPatternPainter extends CustomPainter {
  final math.Random random = math.Random(
    42,
  ); // Fixed seed for consistent pattern

  @override
  void paint(Canvas canvas, Size size) {
    final textPainter = TextPainter(textDirection: TextDirection.ltr);

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
