import 'package:flutter/material.dart';

class LearningTextToBinaryPage extends StatefulWidget {
  const LearningTextToBinaryPage({super.key});

  @override
  State<LearningTextToBinaryPage> createState() =>
      _LearningTextToBinaryPageState();
}

class _LearningTextToBinaryPageState
    extends State<LearningTextToBinaryPage> {
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

  // Page 1 – Going Backwards
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
          'Before, we used the 3+5 shortcut to read binary as text:',
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
              '01001010 → J',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.green.shade800),
            ),
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          'Now we need to go the other way. Given a letter, how do we write it in binary?',
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
              'J → ???',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.orange.shade800),
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
                'The same 3+5 shortcut works in reverse! '
                'Just build the prefix and position instead of reading them.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, height: 1.5, color: Colors.blue.shade900),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Page 2 – The Method
  Widget _buildPage2() {
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
          'Given any letter, ask two questions:',
          style: TextStyle(fontSize: 16, height: 1.5),
        ),
        const SizedBox(height: 20),
        _buildStep('1', 'Is it uppercase or lowercase?'),
        const SizedBox(height: 12),
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
        const SizedBox(height: 24),
        _buildStep('2', 'What position is it in the alphabet?'),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('A = 1', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.green.shade800)),
              Text('B = 2', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.green.shade800)),
              Text('C = 3', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.green.shade800)),
              Text('...', style: TextStyle(fontSize: 16, color: Colors.grey.shade400)),
            ],
          ),
        ),
        const SizedBox(height: 24),
        _buildStep('3', 'Convert that position to 5-digit binary'),
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
                'Then just combine the 3-digit prefix with the 5-digit position. Done!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, height: 1.5, color: Colors.blue.shade900),
              ),
            ],
          ),
        ),
      ],
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
            Text(prefix, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, fontFamily: 'monospace', color: color.shade800)),
            const SizedBox(height: 4),
            Text(label, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: color.shade700)),
          ],
        ),
      ),
    );
  }

  // Page 3 – Converting the Position
  Widget _buildPage3() {
    final placeValues = [16, 8, 4, 2, 1];
    final fits = [false, true, false, true, false]; // 10 = 01010
    final remaining = [10, 10, 2, 2, 0];

    return _buildPageContent(
      children: [
        Center(
          child: Text(
            'Converting the Position',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade800,
            ),
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          'The position number needs to become 5 binary digits. '
          'Use the same subtraction method from Decimal to Binary, '
          'but with only 5 place values:',
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
              child: Text('$v', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.green.shade800)),
            );
          }).toList(),
        ),
        const SizedBox(height: 24),
        Center(
          child: RichText(
            text: TextSpan(
              style: const TextStyle(fontSize: 16, height: 1.5, color: Colors.black),
              children: [
                const TextSpan(text: 'Example: convert position '),
                TextSpan(
                  text: '10',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.orange.shade800),
                ),
                const TextSpan(text: ' (letter J):'),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        ...List.generate(5, (i) {
          final isOn = fits[i];
          return Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Row(
              children: [
                Container(
                  width: 30,
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
                    border: Border.all(color: isOn ? Colors.green.shade400 : Colors.grey.shade300),
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
              'Position 10 = 01010',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green.shade800),
            ),
          ),
        ),
      ],
    );
  }

  // Page 4 – Full Example (M = uppercase, 13th letter)
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
          "Let's convert the letter M to binary:",
          style: TextStyle(fontSize: 16, height: 1.5),
        ),
        const SizedBox(height: 8),
        Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text(
              'M',
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.w900),
            ),
          ),
        ),
        const SizedBox(height: 24),
        _buildExampleStep(
          '1',
          'Uppercase or lowercase?',
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
                Text('M is uppercase', style: TextStyle(fontSize: 16, color: Colors.grey.shade700)),
                const SizedBox(width: 8),
                Icon(Icons.arrow_forward, size: 16, color: Colors.grey.shade400),
                const SizedBox(width: 8),
                Text('010', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'monospace', color: Colors.purple.shade800)),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        _buildExampleStep(
          '2',
          'What position in the alphabet?',
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.orange.shade50,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.orange.shade200),
            ),
            child: Text(
              'M is the 13th letter',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.orange.shade800),
            ),
          ),
        ),
        const SizedBox(height: 20),
        _buildExampleStep(
          '3',
          'Convert 13 to 5-digit binary',
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.green.shade200),
            ),
            child: Text(
              '13 → 01101',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'monospace', color: Colors.green.shade800),
            ),
          ),
        ),
        const SizedBox(height: 20),
        _buildExampleStep(
          '4',
          'Combine prefix + position',
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ...'010'.split('').map((d) => _buildSplitDigit(d, Colors.purple)),
                  const SizedBox(width: 8),
                  ...'01101'.split('').map((d) => _buildSplitDigit(d, Colors.green)),
                ],
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.green.shade300),
                ),
                child: Text(
                  'M = 01001101',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green.shade800),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Page 5 – Try It Yourself (r = lowercase, 18th letter = 011 10010)
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
          'Convert this letter to binary using the shortcut:',
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
              'r',
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.w900),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Center(
          child: Text(
            'Hint: Is it upper or lower? What position in the alphabet?',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: Colors.grey.shade500, fontStyle: FontStyle.italic),
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
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text('Case: ', style: TextStyle(fontSize: 16, color: Colors.grey.shade600)),
                        Text('lowercase', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.orange.shade800)),
                        Text(' → ', style: TextStyle(color: Colors.grey.shade400)),
                        Text('011', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'monospace', color: Colors.purple.shade800)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Text('Position: ', style: TextStyle(fontSize: 16, color: Colors.grey.shade600)),
                        Text('r is 18th', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.orange.shade800)),
                        Text(' → ', style: TextStyle(color: Colors.grey.shade400)),
                        Text('10010', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'monospace', color: Colors.green.shade800)),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ...'011'.split('').map((d) => _buildSplitDigit(d, Colors.purple)),
                  const SizedBox(width: 8),
                  ...'10010'.split('').map((d) => _buildSplitDigit(d, Colors.green)),
                ],
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.green.shade300),
                ),
                child: Text(
                  'r = 01110010',
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.green.shade800),
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
                "You've learned text to binary! "
                "Head to Practice to test your skills.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, height: 1.5, color: Colors.blue.shade900),
              ),
            ],
          ),
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
          child: Text(text, style: const TextStyle(fontSize: 16, height: 1.4)),
        ),
      ],
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
              child: Text(number, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
            ),
            const SizedBox(width: 10),
            Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.blue.shade800)),
          ],
        ),
        const SizedBox(height: 10),
        Center(child: content),
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
                          Navigator.of(context).pushReplacementNamed('practicetexttobinary');
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