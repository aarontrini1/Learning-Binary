import 'package:flutter/material.dart';
import 'dart:math';
import 'package:learningbinary/utils/practiceFeedbackPanel.dart';

class PracticeTextToBinaryPage extends StatefulWidget {
  const PracticeTextToBinaryPage({super.key});

  @override
  State<PracticeTextToBinaryPage> createState() => _PracticeTextToBinaryPageState();
}

class _PracticeTextToBinaryPageState extends State<PracticeTextToBinaryPage> {
  String? currentCharacter;
  String userInput = "";
  bool? isCorrect;
  bool showFeedback = false;

  @override
  void initState() {
    super.initState();
    currentCharacter = getCharacter();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void checkAnswer() {
    setState(() {
      isCorrect = userInput == getBinaryNumber(currentCharacter);
      showFeedback = true;
    });
  }

  void nextQuestion() {
    setState(() {
      isCorrect = null;
      showFeedback = false;
      currentCharacter = getCharacter();
      userInput = "";
    });
  }

  String getCharacter() {
    return generateRandomString(1);
  }

  String getBinaryNumber(char) {
    int codeUnit = char.codeUnitAt(0);
    return codeUnit.toRadixString(2).padLeft(8, "0");
  }

  String generateRandomString(int len) {
    var r = Random();
    const chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz';
    return List.generate(len, (index) => chars[r.nextInt(chars.length)]).join();
  }

  Widget _buildDigitBoxes(i) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2),
      width: 36,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: showFeedback
              ? (isCorrect ?? false ? Colors.green : Colors.red)
              : Colors.grey,
          width: 2,
        ),
      ),
      child: Center(
        child: Text(userInput[i], style: const TextStyle(fontSize: 24)),
      ),
    );
  }

  Widget _buildBinaryButton(String digit) {
    return Expanded(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 200),
        child: AspectRatio(
          aspectRatio: 0.8,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
            ),
            onPressed: () {
              if (userInput.length < 8) {
                setState(() {
                  userInput += digit;
                });
              }
            },
            child: Text(digit, style: const TextStyle(fontSize: 64)),
          ),
        ),
      ),
    );
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
                    Colors.green.shade100,
                    const Color.fromARGB(255, 6, 132, 14),
                  ],
                ),
              ),
            ),
          ),
          Center(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 80),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        "$currentCharacter",
                        style: const TextStyle(
                          fontSize: 48,
                          color: Colors.black,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    const Spacer(flex: 1),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for (int i = 0; i < userInput.length; i++)
                          _buildDigitBoxes(i),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              if (userInput.isNotEmpty) {
                                userInput = userInput.substring(0, userInput.length - 1);
                              }
                            });
                          },
                          child: const Icon(Icons.backspace, size: 24),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        _buildBinaryButton("0"),
                        const SizedBox(width: 20),
                        _buildBinaryButton("1"),
                      ],
                    ),
                    const Spacer(flex: 1),
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: userInput.isEmpty ? null : checkAnswer,
                        child: const Text(
                          'Check',
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ),
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
                    Future.delayed(const Duration(milliseconds: 250), () {
                      Navigator.of(context).pop();
                    });
                  },
                ),
              ),
            ),
          ),
          if (showFeedback)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: PracticeFeedbackPanel(
                isCorrect: isCorrect ?? false,
                correctAnswer: getBinaryNumber(currentCharacter),
                explanation: textToBinaryExplanation(currentCharacter!),
                onContinue: nextQuestion,
              ),
            ),
        ],
      ),
    );
  }
}