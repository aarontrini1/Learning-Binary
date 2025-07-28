import 'package:flutter/material.dart';
import 'package:learningbinary/utils/binaryBackground.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _navigateToLearning(BuildContext context) {
    Navigator.of(context).pushNamed("learning");
  }

  void _navigateToPractice(BuildContext context) {
    Navigator.of(context).pushNamed("practice");
  }

  void _navigateToHistory(BuildContext context) {
    Navigator.of(context).pushNamed("history");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildHomePage(context));
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
                // Light colour on top and dark on bottom
                Colors.green.shade100,
                const Color.fromARGB(255, 6, 132, 14),
              ],
            ),
          ),
        ),
        // Binary pattern overlay
        CustomPaint(size: Size.infinite, painter: BinaryPatternPainter()),
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
                      fontSize: 44,
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
                    key: const Key('learningButton'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.blue.shade800,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      minimumSize: const Size(double.infinity, 100),
                      elevation: 8,
                    ),
                    onPressed: () =>
                        _navigateToLearning(context), 
                    child: const Text(
                      'Learning',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    key: const Key('practiceButton'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.blue.shade800,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      minimumSize: const Size(double.infinity, 100),
                      elevation: 8,
                    ),
                    onPressed: () =>
                        _navigateToPractice(context),
                    child: const Text(
                      'Practice',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
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
                key: const Key('historyButton'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white.withOpacity(0.9),
                  foregroundColor: Colors.blue.shade800,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  minimumSize: const Size(100, 50),
                  elevation: 4,
                ),
                onPressed: () => _navigateToHistory(context), // Setup Nav here
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
