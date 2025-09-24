import 'package:flutter/material.dart';
import 'dart:math';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter/services.dart';

class LearningBinaryToDecimalPage extends StatefulWidget {
  const LearningBinaryToDecimalPage({super.key});

  @override
  State<LearningBinaryToDecimalPage> createState() =>
      _LearningBinaryToDecimalPageState();
}

class _LearningBinaryToDecimalPageState
    extends State<LearningBinaryToDecimalPage> {
  PageController pageController = PageController();
  int? currentPageIndex;
  final int totalPages = 5;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
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
          ),
          Spacer(flex: 1),
          SafeArea(
            child: PageView.builder(
              controller: pageController,
              itemCount: totalPages,
              onPageChanged: (index) {
                setState(() {
                  currentPageIndex = index;
                });
              },
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.white,
                  ),
                  margin: EdgeInsets.only(
                    top: 70,
                    bottom: 100,
                    left: 20,
                    right: 20,
                  ),
                  child: Text('sadss')
                );
              },
            ),
          ),

          Spacer(flex: 1),

          // Back button
          Positioned(
            top: 0,
            left: 0,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, size: 28),
                  color: Colors.blueAccent,
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    Future.delayed(Duration(milliseconds: 250), () {
                      Navigator.of(context).pop();
                    });
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
