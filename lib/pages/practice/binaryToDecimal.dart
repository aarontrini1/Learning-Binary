import 'package:flutter/material.dart';
import 'dart:math';
import 'package:learningbinary/utils/practiceFeedbackPanel.dart';
import 'package:flutter/services.dart';

class PracticeBinaryToDecimalPage extends StatefulWidget {
  const PracticeBinaryToDecimalPage({super.key});

  @override
  State<PracticeBinaryToDecimalPage> createState() =>
      _PracticeBinaryToDecimalPageState();
}

class _PracticeBinaryToDecimalPageState
    extends State<PracticeBinaryToDecimalPage> {
  int? currentNumber;
  String? userInput;
  final TextEditingController _answerController = TextEditingController();
  bool? isCorrect;
  bool showFeedback = false;
  bool showPlaceValues = false;

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
    setState(() {
      isCorrect = (int.parse(_answerController.text) == currentNumber);
      showFeedback = true;
    });
  }

  void nextQuestion() {
    setState(() {
      isCorrect = null;
      showFeedback = false;
      currentNumber = getNumber();
      _answerController.clear();
    });
  }

  int getNumber() {
    return Random().nextInt(256);
  }

  String getBinaryNumber(num) {
    return num.toRadixString(2);
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
        child: Text(
          _answerController.text[i],
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }

  List<int> getPlaceValues(String binaryString) {
    List<int> values = [];
    int length = binaryString.length;
    for (int i = 0; i < length; i++) {
      int placeValue = pow(2, length - 1 - i).toInt();
      values.add(placeValue);
    }
    return values;
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
                    const Spacer(flex: 1),
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              showPlaceValues = !showPlaceValues;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              getBinaryNumber(currentNumber ?? 0),
                              style: TextStyle(
                                height: showPlaceValues ? 1.5 : 1,
                                letterSpacing: 1.5,
                                fontSize: 48,
                                color: Colors.black,
                                fontWeight: FontWeight.w900,
                                backgroundColor: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 55,
                          left: 17,
                          right: 0,
                          child: Column(
                            children: [
                              AnimatedOpacity(
                                opacity: showPlaceValues ? 1.0 : 0.0,
                                duration: const Duration(milliseconds: 200),
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  height: showPlaceValues ? 40 : 0,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: getPlaceValues(getBinaryNumber(currentNumber))
                                        .map((value) => SizedBox(width: 30, child: Text('$value')))
                                        .toList(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 60),
                    SizedBox(
                      height: 60,
                      width: double.infinity,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              for (int i = 0; i < _answerController.text.length; i++)
                                _buildDigitBoxes(i),
                            ],
                          ),
                          Opacity(
                            opacity: _answerController.text.isEmpty ? 1 : 0.0,
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
                                decoration: const InputDecoration(
                                  hintText: 'Answer in Decimal',
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.blue, width: 4),
                                  ),
                                ),
                                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(flex: 2),
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: _answerController.text.isEmpty ? null : checkAnswer,
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
                correctAnswer: '$currentNumber',
                explanation: binaryToDecimalExplanation(currentNumber!),
                onContinue: nextQuestion,
              ),
            ),
        ],
      ),
    );
  }
}