import 'package:flutter/material.dart';
import 'dart:math';

class LearningBinaryToTextPage extends StatefulWidget {
  const LearningBinaryToTextPage({super.key});

  @override
  State<LearningBinaryToTextPage> createState() =>
      _LearningBinaryToTextPageState();
}

class _LearningBinaryToTextPageState
    extends State<LearningBinaryToTextPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  final int _totalPages = 5;
  bool _showAnswer = false;

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

  // Page 1 – What is ASCII?
  Widget _buildPage1() {
    return _buildPageContent(
      children: [
        Center(
          child: Text(
            'What is ASCII?',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade800,
            ),
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          'Computers only understand numbers. So every letter is assigned a number using a system called ASCII.',
          style: TextStyle(fontSize: 16, height: 1.5),
        ),
        const SizedBox(height: 20),
        _buildCharMapRow('A', 65),
        const SizedBox(height: 8),
        _buildCharMapRow('B', 66),
        const SizedBox(height: 8),
        _buildCharMapRow('C', 67),
        const SizedBox(height: 8),
        Center(
          child: Text('...', style: TextStyle(fontSize: 20, color: Colors.grey.shade400)),
        ),
        const SizedBox(height: 8),
        _buildCharMapRow('Z', 90),
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
                "You could convert binary to decimal, then look up the character. "
                "But there's a much faster shortcut!",
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

  Widget _buildCharMapRow(String char, int code) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: Colors.green.shade100,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.green.shade400, width: 1.5),
          ),
          alignment: Alignment.center,
          child: Text(
            char,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green.shade800),
          ),
        ),
        const SizedBox(width: 12),
        Icon(Icons.arrow_forward, size: 18, color: Colors.grey.shade400),
        const SizedBox(width: 12),
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: Colors.orange.shade100,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.orange.shade400, width: 1.5),
          ),
          alignment: Alignment.center,
          child: Text(
            '$code',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.orange.shade800),
          ),
        ),
      ],
    );
  }

  // Page 2 – The 3+5 Split
  Widget _buildPage2() {
    return _buildPageContent(
      children: [
        Center(
          child: Text(
            'The 3 + 5 Split',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade800,
            ),
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          'Every letter in binary is 8 digits. The shortcut is to split it into two parts:',
          style: TextStyle(fontSize: 16, height: 1.5),
        ),
        const SizedBox(height: 24),
        _buildSplitDiagram(
          prefix: '010',
          suffix: '00111',
          prefixLabel: 'First 3 digits',
          suffixLabel: 'Last 5 digits',
          prefixDesc: 'Upper or lowercase?',
          suffixDesc: 'Position in alphabet',
        ),
        const SizedBox(height: 32),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.purple.shade50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.purple.shade200),
          ),
          child: Row(
            children: [
              _buildPrefixBadge('010', 'Uppercase', Colors.blue),
              const SizedBox(width: 16),
              _buildPrefixBadge('011', 'Lowercase', Colors.orange),
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
              Icon(Icons.lightbulb_outline, color: Colors.blue.shade700, size: 28),
              const SizedBox(height: 8),
              Text(
                'Just two prefixes to remember: '
                '010 for UPPER, 011 for lower.',
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

  Widget _buildSplitDiagram({
    required String prefix,
    required String suffix,
    required String prefixLabel,
    required String suffixLabel,
    required String prefixDesc,
    required String suffixDesc,
  }) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...prefix.split('').map((d) => _buildSplitDigit(d, Colors.purple)),
            const SizedBox(width: 12),
            ...suffix.split('').map((d) => _buildSplitDigit(d, Colors.green)),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: prefix.length * 38.0,
              child: Column(
                children: [
                  Text(prefixLabel, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.purple.shade700)),
                  Text(prefixDesc, style: TextStyle(fontSize: 11, color: Colors.purple.shade400, fontStyle: FontStyle.italic)),
                ],
              ),
            ),
            const SizedBox(width: 12),
            SizedBox(
              width: suffix.length * 38.0,
              child: Column(
                children: [
                  Text(suffixLabel, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.green.shade700)),
                  Text(suffixDesc, style: TextStyle(fontSize: 11, color: Colors.green.shade400, fontStyle: FontStyle.italic)),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSplitDigit(String digit, MaterialColor color) {
    return Container(
      width: 34,
      height: 40,
      margin: const EdgeInsets.symmetric(horizontal: 2),
      decoration: BoxDecoration(
        color: color.shade100,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.shade400, width: 1.5),
      ),
      alignment: Alignment.center,
      child: Text(
        digit,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: color.shade800),
      ),
    );
  }

  Widget _buildPrefixBadge(String prefix, String label, MaterialColor color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: color.shade50,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: color.shade300),
        ),
        child: Column(
          children: [
            Text(
              prefix,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, fontFamily: 'monospace', color: color.shade800),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: color.shade700),
            ),
          ],
        ),
      ),
    );
  }

  // Page 3 – The Last 5 Digits
  Widget _buildPage3() {
    final placeValues = [16, 8, 4, 2, 1];
    final examples = [
      {'bits': [0, 0, 0, 0, 1], 'pos': 1, 'letter': 'A'},
      {'bits': [0, 0, 1, 1, 0], 'pos': 6, 'letter': 'F'},
      {'bits': [1, 1, 0, 1, 0], 'pos': 26, 'letter': 'Z'},
    ];

    return _buildPageContent(
      children: [
        Center(
          child: Text(
            'The Last 5 Digits',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade800,
            ),
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          'The last 5 digits tell you the position in the alphabet. Convert them to decimal using the place values:',
          style: TextStyle(fontSize: 16, height: 1.5),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: placeValues.map((v) {
            return Container(
              width: 42,
              margin: const EdgeInsets.symmetric(horizontal: 3),
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: Colors.green.shade100,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.green.shade400, width: 1.5),
              ),
              alignment: Alignment.center,
              child: Text(
                '$v',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.green.shade800),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 24),
        ...examples.map((ex) {
          final bits = ex['bits'] as List<int>;
          final pos = ex['pos'] as int;
          final letter = ex['letter'] as String;
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Row(
                children: [
                  ...bits.map((b) => Container(
                    width: 28,
                    height: 28,
                    margin: const EdgeInsets.only(right: 4),
                    decoration: BoxDecoration(
                      color: b == 1 ? Colors.green.shade100 : Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: b == 1 ? Colors.green.shade400 : Colors.grey.shade300),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '$b',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: b == 1 ? Colors.green.shade800 : Colors.grey.shade400,
                      ),
                    ),
                  )),
                  const SizedBox(width: 8),
                  Icon(Icons.arrow_forward, size: 16, color: Colors.grey.shade400),
                  const SizedBox(width: 8),
                  Text(
                    '$pos',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.orange.shade800),
                  ),
                  const SizedBox(width: 4),
                  Icon(Icons.arrow_forward, size: 16, color: Colors.grey.shade400),
                  const SizedBox(width: 4),
                  Text(
                    letter,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue.shade800),
                  ),
                  Text(
                    '  (${pos}${_ordinalSuffix(pos)} letter)',
                    style: TextStyle(fontSize: 13, color: Colors.grey.shade500),
                  ),
                ],
              ),
            ),
          );
        }),
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
                'The last 5 digits give you a number from 1–26, '
                'which matches A–Z perfectly!',
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

  String _ordinalSuffix(int n) {
    if (n >= 11 && n <= 13) return 'th';
    switch (n % 10) {
      case 1: return 'st';
      case 2: return 'nd';
      case 3: return 'rd';
      default: return 'th';
    }
  }

  // Page 4 – Full Example (01001010 = J)
  Widget _buildPage4() {
    return _buildPageContent(
      children: [
        Center(
          child: Text(
            'Full Example',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade800,
            ),
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          "Let's convert this binary to a letter:",
          style: TextStyle(fontSize: 16, height: 1.5),
        ),
        const SizedBox(height: 20),
        _buildSplitDiagram(
          prefix: '010',
          suffix: '01010',
          prefixLabel: 'Prefix',
          suffixLabel: 'Position',
          prefixDesc: '',
          suffixDesc: '',
        ),
        const SizedBox(height: 28),
        _buildExampleStep(
          '1',
          'Check the prefix',
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.blue.shade200),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '010',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'monospace', color: Colors.purple.shade800),
                ),
                const SizedBox(width: 8),
                Icon(Icons.arrow_forward, size: 16, color: Colors.grey.shade400),
                const SizedBox(width: 8),
                Text(
                  'Uppercase',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.blue.shade800),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        _buildExampleStep(
          '2',
          'Convert last 5 digits',
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildSmallBitBox(0, false), _buildSmallBitBox(1, true),
                  _buildSmallBitBox(0, false), _buildSmallBitBox(1, true),
                  _buildSmallBitBox(0, false),
                ],
              ),
              const SizedBox(height: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.orange.shade50,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.orange.shade200),
                ),
                child: Text(
                  '8 + 2 = 10',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.orange.shade800),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        _buildExampleStep(
          '3',
          'Find the 10th letter',
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.green.shade300),
            ),
            child: Text(
              '10th letter → J',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.green.shade800,
              ),
            ),
          ),
        ),
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
              '01001010 = J',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.green.shade800,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSmallBitBox(int bit, bool isOn) {
    return Container(
      width: 34,
      height: 34,
      margin: const EdgeInsets.symmetric(horizontal: 2),
      decoration: BoxDecoration(
        color: isOn ? Colors.green.shade100 : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: isOn ? Colors.green.shade400 : Colors.grey.shade300),
      ),
      alignment: Alignment.center,
      child: Text(
        '$bit',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: isOn ? Colors.green.shade800 : Colors.grey.shade400,
        ),
      ),
    );
  }

  Widget _buildExampleStep(String number, String title, Widget content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
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
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.blue.shade800),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Center(child: content),
      ],
    );
  }

  // Page 5 – Try It Yourself (01010011 = S, 19th letter, uppercase)
  Widget _buildPage5() {
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
          'Use the shortcut to figure out what letter this is:',
          style: TextStyle(fontSize: 16, height: 1.5),
        ),
        const SizedBox(height: 24),
        _buildSplitDiagram(
          prefix: '011',
          suffix: '01000',
          prefixLabel: 'Prefix',
          suffixLabel: 'Position',
          prefixDesc: 'Upper or lower?',
          suffixDesc: 'Which letter?',
        ),
        const SizedBox(height: 28),
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
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text('Prefix: ', style: TextStyle(fontSize: 16, color: Colors.grey.shade600)),
                        Text('011', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'monospace', color: Colors.purple.shade800)),
                        Text(' → ', style: TextStyle(color: Colors.grey.shade400)),
                        Text('Lowercase', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.orange.shade800)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Text('Position: ', style: TextStyle(fontSize: 16, color: Colors.grey.shade600)),
                        Text('01000', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'monospace', color: Colors.green.shade800)),
                        Text(' → ', style: TextStyle(color: Colors.grey.shade400)),
                        Text('8', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.orange.shade800)),
                        Text('th letter', style: TextStyle(fontSize: 16, color: Colors.grey.shade600)),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.green.shade300),
                ),
                child: Text(
                  '01101000 = h',
                  style: TextStyle(
                    fontSize: 26,
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
                "You've learned the shortcut! "
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
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
          ),
        ),
        const SizedBox(width: 12),
        Flexible(
          child: Text(
            text,
            style: const TextStyle(fontSize: 16, height: 1.4),
          ),
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
                          Navigator.of(context).pushReplacementNamed('practicebinarytotext');
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