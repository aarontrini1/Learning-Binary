import 'package:flutter/material.dart';
import 'package:learningbinary/utils/progresstracker.dart';

class LearningDecimalToBinaryPage extends StatefulWidget {
  const LearningDecimalToBinaryPage({super.key});

  @override
  State<LearningDecimalToBinaryPage> createState() =>
      _LearningDecimalToBinaryPageState();
}

class _LearningDecimalToBinaryPageState
    extends State<LearningDecimalToBinaryPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  final int _totalPages = 5;
  bool _showAnswer = false;
  bool _sectionCompleted = false;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _goToPage(int page) {
    _pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  Widget _buildPageContent({required List<Widget> children}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      margin: const EdgeInsets.only(top: 70, bottom: 100, left: 20, right: 20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: children,
          ),
        ),
      ),
    );
  }

  // Page 1 – The Reverse
  Widget _buildPage1() {
    return _buildPageContent(
      children: [
        Center(
          child: Text(
            'Going Backwards',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade800,
            ),
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          'Before, we converted binary to decimal by adding up place values.',
          style: TextStyle(fontSize: 16, height: 1.5),
        ),
        const SizedBox(height: 16),
        Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.green.shade300),
            ),
            child: Text(
              '00010101 → 21',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.green.shade800,
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          'Now we need to go the other way. Given a decimal number, how do we write it in binary?',
          style: TextStyle(fontSize: 16, height: 1.5),
        ),
        const SizedBox(height: 16),
        Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.orange.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.orange.shade300),
            ),
            child: Text(
              '21 → ???',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.orange.shade800,
              ),
            ),
          ),
        ),
        const SizedBox(height: 32),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.blue.shade200),
          ),
          child: Column(
            children: [
              Icon(Icons.lightbulb_outline, color: Colors.blue.shade700, size: 28),
              const SizedBox(height: 8),
              Text(
                'The trick is to use the same place values, '
                'but this time we subtract instead of add.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  height: 1.5,
                  color: Colors.blue.shade900,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Page 2 – The Method
  Widget _buildPage2() {
    final placeValues = [128, 64, 32, 16, 8, 4, 2, 1];

    return _buildPageContent(
      children: [
        Center(
          child: Text(
            'The Method',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade800,
            ),
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          'Start with your place values:',
          style: TextStyle(fontSize: 16, height: 1.5),
        ),
        const SizedBox(height: 12),
        Row(
          children: placeValues.map((v) {
            return Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 2),
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.green.shade100,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.green.shade400, width: 1.5),
                ),
                alignment: Alignment.center,
                child: Text(
                  '$v',
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 24),
        const Text(
          'Then go left to right and ask one question for each position:',
          style: TextStyle(fontSize: 16, height: 1.5),
        ),
        const SizedBox(height: 16),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.orange.shade50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.orange.shade300),
          ),
          child: Text(
            '"Does this value fit into what I have left?"',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              fontStyle: FontStyle.italic,
              color: Colors.orange.shade900,
            ),
          ),
        ),
        const SizedBox(height: 24),
        _buildStep('1', 'YES → write 1, subtract the value'),
        const SizedBox(height: 8),
        _buildStep('2', 'NO → write 0, move on'),
        const SizedBox(height: 8),
        _buildStep('3', 'Repeat for every position'),
        const SizedBox(height: 32),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.blue.shade200),
          ),
          child: Column(
            children: [
              Icon(Icons.lightbulb_outline, color: Colors.blue.shade700, size: 28),
              const SizedBox(height: 8),
              Text(
                "That's the whole method! Let's walk through an example.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  height: 1.5,
                  color: Colors.blue.shade900,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Page 3 – Step by Step (convert 42)
  Widget _buildPage3() {
    final placeValues = [128, 64, 32, 16, 8, 4, 2, 1];
    final fits =        [false, false, true, false, true, false, true, false];
    final remaining =   [42, 42, 42, 10, 10, 2, 2, 0];

    return _buildPageContent(
      children: [
        Center(
          child: Text(
            'Step by Step',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade800,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Center(
          child: RichText(
            text: TextSpan(
              style: const TextStyle(fontSize: 16, height: 1.5, color: Colors.black),
              children: [
                const TextSpan(text: "Let's convert "),
                TextSpan(
                  text: '42',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.orange.shade800,
                  ),
                ),
                const TextSpan(text: ' to binary:'),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        ...List.generate(8, (i) {
          final isOn = fits[i];
          return Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Row(
              children: [
                Container(
                  width: 42,
                  alignment: Alignment.centerRight,
                  child: Text(
                    '${placeValues[i]}',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: isOn ? Colors.green.shade800 : Colors.grey.shade500,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: isOn ? Colors.green.shade100 : Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      color: isOn ? Colors.green.shade400 : Colors.grey.shade300,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    isOn ? '1' : '0',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: isOn ? Colors.green.shade800 : Colors.grey.shade400,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    isOn
                        ? '${remaining[i]} ≥ ${placeValues[i]} ✓  →  ${remaining[i]} - ${placeValues[i]} = ${remaining[i] - placeValues[i]}'
                        : '${remaining[i]} < ${placeValues[i]}  →  skip',
                    style: TextStyle(
                      fontSize: 13,
                      color: isOn ? Colors.green.shade700 : Colors.grey.shade500,
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
        const SizedBox(height: 24),
        Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.green.shade300),
            ),
            child: Text(
              '42 = 00101010',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.green.shade800,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Page 4 – Another Example (convert 13)
  Widget _buildPage4() {
    final placeValues = [128, 64, 32, 16, 8, 4, 2, 1];
    final fits =        [false, false, false, false, true, true, false, true];
    final remaining =   [13, 13, 13, 13, 13, 5, 1, 1];

    return _buildPageContent(
      children: [
        Center(
          child: Text(
            'Another Example',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade800,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Center(
          child: RichText(
            text: TextSpan(
              style: const TextStyle(fontSize: 16, height: 1.5, color: Colors.black),
              children: [
                const TextSpan(text: "Let's convert "),
                TextSpan(
                  text: '13',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.orange.shade800,
                  ),
                ),
                const TextSpan(text: ' to binary:'),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        ...List.generate(8, (i) {
          final isOn = fits[i];
          return Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Row(
              children: [
                Container(
                  width: 42,
                  alignment: Alignment.centerRight,
                  child: Text(
                    '${placeValues[i]}',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: isOn ? Colors.green.shade800 : Colors.grey.shade500,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: isOn ? Colors.green.shade100 : Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      color: isOn ? Colors.green.shade400 : Colors.grey.shade300,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    isOn ? '1' : '0',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: isOn ? Colors.green.shade800 : Colors.grey.shade400,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    isOn
                        ? '${remaining[i]} ≥ ${placeValues[i]} ✓  →  ${remaining[i]} - ${placeValues[i]} = ${remaining[i] - placeValues[i]}'
                        : '${remaining[i]} < ${placeValues[i]}  →  skip',
                    style: TextStyle(
                      fontSize: 13,
                      color: isOn ? Colors.green.shade700 : Colors.grey.shade500,
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
        const SizedBox(height: 24),
        Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.green.shade300),
            ),
            child: Text(
              '13 = 00001101',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.green.shade800,
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.blue.shade200),
          ),
          child: Column(
            children: [
              Icon(Icons.lightbulb_outline, color: Colors.blue.shade700, size: 28),
              const SizedBox(height: 8),
              Text(
                'The same method works for any number 0–255. '
                'Just work through each place value left to right!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  height: 1.5,
                  color: Colors.blue.shade900,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Page 5 – Try It Yourself (convert 77)
  Widget _buildPage5() {
    final placeValues = [128, 64, 32, 16, 8, 4, 2, 1];
    final bits = [0, 1, 0, 0, 1, 1, 0, 1]; // 77 = 01001101

    return _buildPageContent(
      children: [
        Center(
          child: Text(
            'Try It Yourself!',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade800,
            ),
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          'Convert this decimal number to binary. '
          'Work through each place value, then tap to check!',
          style: TextStyle(fontSize: 16, height: 1.5),
        ),
        const SizedBox(height: 24),
        Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text(
              '77',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),
        AnimatedCrossFade(
          duration: const Duration(milliseconds: 300),
          crossFadeState: _showAnswer
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst,
          firstChild: Center(
            child: ElevatedButton.icon(
              onPressed: () => setState(() => _showAnswer = true),
              icon: const Icon(Icons.visibility),
              label: const Text('Show Answer'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade700,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          secondChild: Column(
            children: [
              Row(
                children: List.generate(8, (i) {
                  final isOn = bits[i] == 1;
                  return Expanded(
                    child: Column(
                      children: [
                        Text(
                          '${placeValues[i]}',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: isOn ? Colors.green.shade800 : Colors.grey.shade400,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 2),
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: isOn ? Colors.green.shade100 : Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: isOn ? Colors.green.shade400 : Colors.grey.shade300,
                              width: 1.5,
                            ),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            '${bits[i]}',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: isOn ? Colors.green.shade800 : Colors.grey.shade400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.green.shade300),
                ),
                child: Text(
                  '77 = 01001101',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.green.shade800,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.blue.shade200),
          ),
          child: Column(
            children: [
              Icon(Icons.emoji_events_outlined, color: Colors.blue.shade700, size: 28),
              const SizedBox(height: 8),
              Text(
                "You've learned decimal to binary! "
                "Head to Practice to test your skills.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  height: 1.5,
                  color: Colors.blue.shade900,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStep(String number, String text) {
    return Row(
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: Colors.blue.shade700,
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Text(
            number,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Text(
          text,
          style: const TextStyle(fontSize: 16, height: 1.4),
        ),
      ],
    );
  }

  Widget _buildPage(int index) {
    switch (index) {
      case 0: return _buildPage1();
      case 1: return _buildPage2();
      case 2: return _buildPage3();
      case 3: return _buildPage4();
      case 4: return _buildPage5();
      default: return _buildPage1();
    }
  }

  Widget _buildDotIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(_totalPages, (index) {
        final isActive = index == _currentPage;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: isActive ? 24 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: isActive ? Colors.white : Colors.white54,
            borderRadius: BorderRadius.circular(4),
          ),
        );
      }),
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
          SafeArea(
            child: PageView.builder(
              controller: _pageController,
              itemCount: _totalPages,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                  if (index != 4) _showAnswer = false;
                });
                if (index == _totalPages - 1 && !_sectionCompleted) {
                  _sectionCompleted = true;
                  ProgressTracker.completeSection(
                    ProgressTracker.decimalToBinary,
                  ); 
                }
              },
              itemBuilder: (context, index) => _buildPage(index),
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
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Opacity(
                      opacity: _currentPage > 0 ? 1.0 : 0.0,
                      child: IgnorePointer(
                        ignoring: _currentPage == 0,
                        child: TextButton.icon(
                          onPressed: () => _goToPage(_currentPage - 1),
                          icon: const Icon(Icons.arrow_back_ios, size: 16),
                          label: const Text('Back'),
                          style: TextButton.styleFrom(foregroundColor: Colors.white),
                        ),
                      ),
                    ),
                    _buildDotIndicator(),
                    TextButton.icon(
                      onPressed: () {
                        if (_currentPage < _totalPages - 1) {
                          _goToPage(_currentPage + 1);
                        } else {
                          Navigator.of(context).pushReplacementNamed('practicedecimaltobinary');
                        }
                      },
                      label: Text(_currentPage < _totalPages - 1 ? 'Next' : 'Practice'),
                      icon: Icon(
                        _currentPage < _totalPages - 1
                            ? Icons.arrow_forward_ios
                            : Icons.play_arrow,
                        size: 16,
                      ),
                      style: TextButton.styleFrom(foregroundColor: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}