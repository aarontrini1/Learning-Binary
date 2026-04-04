import 'package:flutter/material.dart';

class PracticeFeedbackPanel extends StatelessWidget {
  final bool isCorrect;
  final String correctAnswer;
  final String? explanation;
  final VoidCallback onContinue;

  const PracticeFeedbackPanel({
    super.key,
    required this.isCorrect,
    required this.correctAnswer,
    required this.onContinue,
    this.explanation,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: isCorrect ? Colors.green.shade50 : Colors.red.shade50,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 12,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    isCorrect ? Icons.check_circle : Icons.cancel,
                    color: isCorrect ? Colors.green.shade700 : Colors.red.shade700,
                    size: 28,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    isCorrect ? 'Correct!' : 'Not quite!',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: isCorrect ? Colors.green.shade800 : Colors.red.shade800,
                    ),
                  ),
                ],
              ),
              if (!isCorrect) ...[
                const SizedBox(height: 12),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.red.shade200),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'The answer was:',
                        style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        correctAnswer,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.red.shade800,
                        ),
                      ),
                      if (explanation != null) ...[
                        const SizedBox(height: 8),
                        Divider(color: Colors.red.shade100),
                        const SizedBox(height: 4),
                        Text(
                          explanation!,
                          style: TextStyle(
                            fontSize: 14,
                            height: 1.5,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: onContinue,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isCorrect ? Colors.green.shade600 : Colors.red.shade600,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'CONTINUE',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, letterSpacing: 1),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Generates an explanation string for binary-to-decimal conversions
String binaryToDecimalExplanation(int number) {
  final binary = number.toRadixString(2).padLeft(8, '0');
  final placeValues = [128, 64, 32, 16, 8, 4, 2, 1];
  final onValues = <String>[];

  for (int i = 0; i < 8; i++) {
    if (binary[i] == '1') {
      onValues.add('${placeValues[i]}');
    }
  }

  return 'The binary was $binary.\n'
      'The ON place values are: ${onValues.join(', ')}.\n'
      '${onValues.join(' + ')} = $number';
}

// Generates an explanation string for decimal-to-binary conversions
String decimalToBinaryExplanation(int number) {
  final binary = number.toRadixString(2).padLeft(8, '0');
  final placeValues = [128, 64, 32, 16, 8, 4, 2, 1];
  final steps = <String>[];
  int remaining = number;

  for (int i = 0; i < 8; i++) {
    if (remaining >= placeValues[i]) {
      steps.add('${placeValues[i]} fits into $remaining');
      remaining -= placeValues[i];
    }
  }

  return 'Start with $number and subtract place values that fit:\n'
      '${steps.join(', ')}.\n'
      'Result: $binary';
}

// Generates an explanation string for binary-to-text conversions
String binaryToTextExplanation(String character) {
  final code = character.codeUnitAt(0);
  final binary = code.toRadixString(2).padLeft(8, '0');
  final prefix = binary.substring(0, 3);
  final isUpper = prefix == '010';
  final position = code - (isUpper ? 64 : 96);

  return 'The binary was $binary.\n'
      'Prefix $prefix = ${isUpper ? "uppercase" : "lowercase"}.\n'
      'Last 5 digits = $position = '
      '${position}${_ordinal(position)} letter of the alphabet = "$character"';
}

// Generates an explanation string for text-to-binary conversions
String textToBinaryExplanation(String character) {
  final code = character.codeUnitAt(0);
  final binary = code.toRadixString(2).padLeft(8, '0');
  final isUpper = character.toUpperCase() == character;
  final position = code - (isUpper ? 64 : 96);

  return '"$character" is ${isUpper ? "uppercase" : "lowercase"} → prefix ${isUpper ? "010" : "011"}.\n'
      'It is the ${position}${_ordinal(position)} letter → ${binary.substring(3)} in binary.\n'
      'Combined: $binary';
}

String _ordinal(int n) {
  if (n >= 11 && n <= 13) return 'th';
  switch (n % 10) {
    case 1: return 'st';
    case 2: return 'nd';
    case 3: return 'rd';
    default: return 'th';
  }
}