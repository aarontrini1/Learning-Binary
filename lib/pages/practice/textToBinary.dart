import 'package:flutter/material.dart';
import 'dart:math';
import 'package:google_fonts/google_fonts.dart';

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
    const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz';
    return List.generate(
      len,
      (index) => _chars[r.nextInt(_chars.length)],
    ).join();
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
              "${getBinaryNumber(currentCharacter)}",
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
    String text = userInput;
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
            child: Text(userInput[i], style: TextStyle(fontSize: 24)),
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
                    // Spacer(flex: 1),
                    SizedBox(height: 100),
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
                        "$currentCharacter",
                        style: TextStyle(
                          fontSize: 48,
                          color: Colors.black,
                          fontWeight: FontWeight.w900,
                          backgroundColor: Colors.white,
                        ),
                      ),
                    ),

                    SizedBox(height: MediaQuery.of(context).size.height * 0.1),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for (int i = 0; i < userInput.length; i++)
                          _buildDigitBoxes(i),
                      ],
                    ),

                    SizedBox(height: MediaQuery.of(context).size.height * 0.08),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(
                              MediaQuery.of(context).size.width * 0.03,
                              MediaQuery.of(context).size.height * 0.05,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              if (userInput.isNotEmpty) {
                                userInput = userInput.substring(
                                  0,
                                  userInput.length - 1,
                                );
                              }
                            });
                          },
                          child: Icon(Icons.backspace, size: 24),
                        ),
                      ],
                    ),

                    SizedBox(height: 5),

                    SizedBox(
                      width: double.infinity,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          SizedBox(height: 100),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            textBaseline: TextBaseline.alphabetic,
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    minimumSize: Size(
                                      MediaQuery.of(context).size.width / 3,
                                      MediaQuery.of(context).size.height / 3,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                  ),
                                  onPressed: () {
                                    if (userInput.length < 8) {
                                      setState(() {
                                        userInput += "0";
                                      });
                                    }
                                  },
                                  child: Text(
                                    "0",
                                    style: TextStyle(fontSize: 64),
                                  ),
                                ),
                              ),

                              SizedBox(width: 25),

                              Expanded(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    minimumSize: Size(
                                      MediaQuery.of(context).size.width / 3,
                                      MediaQuery.of(context).size.height / 3,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                  ),
                                  onPressed: () {
                                    if (userInput.length < 8) {
                                      setState(() {
                                        userInput += "1";
                                      });
                                    }
                                  },
                                  child: Text(
                                    "1",
                                    style: TextStyle(fontSize: 64),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Spacer(flex: 2),
                    ElevatedButton(
                      onPressed: userInput.length < 1 ? null : checkAnswer,

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
