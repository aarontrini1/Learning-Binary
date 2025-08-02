import 'dart:developer';

import 'package:flutter/material.dart';
import 'dart:math';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter/services.dart';

class BinaryToDecimalPage extends StatefulWidget {
  const BinaryToDecimalPage({super.key});

  @override
  State<BinaryToDecimalPage> createState() => _BinaryToDecimalPageState();
}

class _BinaryToDecimalPageState extends State<BinaryToDecimalPage> {
  String? currentCharacter;
  String? userInput;
  final TextEditingController _answerController = TextEditingController();
  bool? isCorrect;
  bool showFeedback = false;

  @override
  void initState() {
    super.initState();
    currentCharacter = getCharacter();
    _answerController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _answerController.dispose();
    super.dispose();
  }

  void checkAnswer() {
    setState(() {
      isCorrect = (_answerController.text) == currentCharacter;
      showFeedback = true;
    });
  }

  void nextQuestion() {
    setState(() {
      isCorrect = null;
      showFeedback = false;
      currentCharacter = getCharacter();
      _answerController.clear();
    });
  }

  String getCharacter() {
    return generateRandomString(1);
  }

  String generateRandomString(int len) {
    var r = Random();
    const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz';
  return List.generate(len, (index) => _chars[r.nextInt(_chars.length)]).join();
}

  String getBinaryNumber(char) {
    return char.toRadixString(2);
  }

  Widget _buildFeedbackPanel() {
    return Container(
      width: double.infinity,
      height: 200,
      color: Colors.black,
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          Row(
            children: [
              Image.asset(
                isCorrect ?? false
                    ? 'assets/check_mark.png'
                    : 'assets/incorrect_mark.png',
                height: 28,
                width: 28,
              ),
              SizedBox(width: 5),
              Text(
                isCorrect ?? false ? "Correct! " : "Incorrect",
                style: GoogleFonts.caveatBrush(
                  color: isCorrect ?? false ? Colors.green : Colors.red,
                  fontSize: 30,
                ),
              ),
            ],
          ),
          if (isCorrect == false)
            Text(
              "Correct Answer:",
              style: GoogleFonts.caveatBrush(color: Colors.red, fontSize: 24),
            ),
          if (isCorrect == false)
            Text(
              "\"$currentCharacter\"",
              style: TextStyle(
                color: Colors.red,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          SizedBox(height: 10),
          Spacer(flex: 1),
          ConstrainedBox(
            constraints: BoxConstraints.tightFor(
              height: 50,
              width: MediaQuery.of(context).size.width,
            ),
            child: ElevatedButton(
              onPressed: () => nextQuestion(),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: Text(
                "CONTINUE",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w900,
                  fontSize: 18,
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildDigitBoxes(i) {
    String text = _answerController.text;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 2),
          width: MediaQuery.of(context).size.width / 10,
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
            child: Text(
              _answerController.text[i],
              style: TextStyle(fontSize: 24),
            ),
          ),
        ),
      ],
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
                    // Light colour on top and dark on bottom
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
                    Spacer(flex: 1),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        getBinaryNumber(currentCharacter ?? 0),
                        style: TextStyle(
                          fontSize: 48,
                          color: Colors.black,
                          fontWeight: FontWeight.w900,
                          backgroundColor: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: 60),
                    SizedBox(
                      height: 60,
                      width: double.infinity,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              for (
                                int i = 0;
                                i < _answerController.text.length;
                                i++
                              )
                                _buildDigitBoxes(i),
                            ],
                          ),
                          Opacity(
                            opacity: _answerController.text.length < 1
                                ? 1
                                : 0.0,
                            child: SizedBox(
                              width: 200,
                              child: TextField(
                                autofocus: true,
                                controller: _answerController,
                                keyboardType: TextInputType.text,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]')),
                                  LengthLimitingTextInputFormatter(8),
                                ],
                                showCursor: false,
                                decoration: InputDecoration(
                                  hintText: 'Answer with a letter',
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.blue,
                                      width: 4,
                                    ),
                                  ),
                                ),
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Spacer(flex: 2),
                    ElevatedButton(
                      onPressed: _answerController.text.length < 1
                          ? null
                          : checkAnswer,

                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(
                          double.infinity,
                          MediaQuery.sizeOf(context).width / 7,
                        ),
                      ),
                      child: Text(
                        'Check',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ),

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
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
            ),
          ),

          // Feedback panel
          if (showFeedback)
            Positioned(
              bottom: showFeedback == false ? -200 : 0,
              left: 0,
              right: 0,
              height: isCorrect ?? false ? 150 : 200,
              child: _buildFeedbackPanel(),
            ),
        ],
      ),
    );
  }
}
