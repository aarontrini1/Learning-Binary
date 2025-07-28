import 'package:flutter/material.dart';
import 'dart:math';

import 'package:flutter/services.dart';

class BinaryToDecimalPage extends StatefulWidget {
  const BinaryToDecimalPage({super.key});

  @override
  State<BinaryToDecimalPage> createState() => _BinaryToDecimalPageState();
}

class _BinaryToDecimalPageState extends State<BinaryToDecimalPage> {
  int? currentNumber;
  String? userInput;
  final TextEditingController _answerController = TextEditingController();
  bool? isCorrect;
  bool? showFeedback;

  @override
  void initState() {
    super.initState();
    currentNumber = getNumber();
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
    if (int.parse(_answerController.text) == currentNumber) {
      //correct
      print("CORRECT");
    } else {
      //incorrect
      print("INCORRECT");
    }
  }

  int getNumber() {
    return Random().nextInt(256);
  }

  String getBinaryNumber(num) {
    return num.toRadixString(2);
  }

  Widget _buildFeedbackPanel() {
    return Container(
      color: Colors.black,
      // margin: EdgeInsets.all(2),
      // width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            isCorrect == true ? "Correct!" : "Incorrect",
            style: TextStyle(
              color: isCorrect == true ? Colors.green : Colors.red,
            ),
          ),
          if (isCorrect == false)
            Text(
              "The answer was ${currentNumber}",
              style: TextStyle(color: Colors.white),
            ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {},
            child: Text(
              "Continue",
              style: TextStyle(
                backgroundColor: Colors.green,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDigitBoxes(i) {
    String text = _answerController.text;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // for (int i = 0; i < _answerController.text.length; i++)
        Container(
          margin: EdgeInsets.symmetric(horizontal: 2),
          width: MediaQuery.of(context).size.width / 10,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey),
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
                        getBinaryNumber(currentNumber ?? 0),
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
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly,
                                  LengthLimitingTextInputFormatter(8),
                                ],
                                showCursor: false,
                                decoration: InputDecoration(
                                  hintText: 'Answer in Decimal',
                                  // enabledBorder: UnderlineInputBorder(
                                  //   borderSide: BorderSide(color: Colors.pink),
                                  // ),
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
          Positioned(
            bottom: showFeedback == null || showFeedback == false ? -200 : 0,
            child: _buildFeedbackPanel(),
          ),
        ],
      ),
    );
  }
}
