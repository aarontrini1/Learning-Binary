import 'package:flutter/material.dart';

class LearningBinaryToDecimalPage extends StatefulWidget {
  const LearningBinaryToDecimalPage({super.key});

  @override
  State<LearningBinaryToDecimalPage> createState() =>
      _LearningBinaryToDecimalPageState();
}

class _LearningBinaryToDecimalPageState
    extends State<LearningBinaryToDecimalPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  final int _totalPages = 5;

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

  Widget _buildPage1() {
    return _buildPageContent(
      children: [
        Center(
          child: Text(
            'What is Binary?',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade800,
            ),
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          'You count with 10 digits every day:',
          style: TextStyle(fontSize: 16, height: 1.5),
        ),
        const SizedBox(height: 12),
        _buildDigitRow(
          digits: ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'],
          color: Colors.orange.shade100,
          borderColor: Colors.orange.shade400,
        ),
        const SizedBox(height: 8),
        Center(
          child: Text(
            'This is called Decimal (base 10)',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          'Computers only use 2 digits:',
          style: TextStyle(fontSize: 16, height: 1.5),
        ),
        const SizedBox(height: 12),
        _buildDigitRow(
          digits: ['0', '1'],
          color: Colors.green.shade100,
          borderColor: Colors.green.shade400,
        ),
        const SizedBox(height: 8),
        Center(
          child: Text(
            'This is called Binary (base 2)',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
              fontStyle: FontStyle.italic,
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
                'Every number you know (like 42 or 255) can be '
                'written using just 0s and 1s.',
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

  Widget _buildDigitRow({
    required List<String> digits,
    required Color color,
    required Color borderColor,
  }) {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 8,
      runSpacing: 8,
      children: digits.map((d) {
        return Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: borderColor, width: 1.5),
          ),
          alignment: Alignment.center,
          child: Text(
            d,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildPage2() {
    final placeValues = [128, 64, 32, 16, 8, 4, 2, 1];
    final powers = [7, 6, 5, 4, 3, 2, 1, 0];

    return _buildPageContent(
      children: [
        Center(
          child: Text(
            'Place Values',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade800,
            ),
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          'In decimal, each position is worth 10× more than the one to its right:',
          style: TextStyle(fontSize: 16, height: 1.5),
        ),
        const SizedBox(height: 12),
        _buildValueRow(
          labels: ['1000', '100', '10', '1'],
          color: Colors.orange.shade100,
          borderColor: Colors.orange.shade400,
        ),
        const SizedBox(height: 24),
        const Text(
          'In binary, each position is worth 2× more:',
          style: TextStyle(fontSize: 16, height: 1.5),
        ),
        const SizedBox(height: 12),
        _buildValueRow(
          labels: placeValues.map((v) => '$v').toList(),
          color: Colors.green.shade100,
          borderColor: Colors.green.shade400,
        ),
        const SizedBox(height: 8),
        Center(
          child: Text(
            'Each position doubles from right to left',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          'These values come from powers of 2:',
          style: TextStyle(fontSize: 16, height: 1.5),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(placeValues.length, (i) {
            return Expanded(
              child: Column(
                children: [
                  Text(
                    '2${_superscript(powers[i])}',
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 4),
                  const Icon(Icons.arrow_downward, size: 14, color: Colors.grey),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 2),
                    decoration: BoxDecoration(
                      color: Colors.green.shade100,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: Colors.green.shade400),
                    ),
                    child: Center(
                      child: Text(
                        '${placeValues[i]}',
                        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
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
                'An 8-digit binary number can represent any value from 0 to 255. \n'
                'Need bigger numbers? Just add more digits! '
                'For example, 16 digits gets you up to 65,535.',
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

  String _superscript(int number) {
    const superscripts = {
      '0': '⁰', '1': '¹', '2': '²', '3': '³', '4': '⁴',
      '5': '⁵', '6': '⁶', '7': '⁷', '8': '⁸', '9': '⁹',
    };
    return number.toString().split('').map((c) => superscripts[c] ?? c).join();
  }

  Widget _buildValueRow({
    required List<String> labels,
    required Color color,
    required Color borderColor,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: labels.map((label) {
        return Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 2),
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: borderColor, width: 1.5),
            ),
            alignment: Alignment.center,
            child: Text(
              label,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildPage3() {
    return _buildPageContent(children: [
      Center(child: Text('Page 3 – Reading Binary', style: TextStyle(fontSize: 22, color: Colors.grey))),
    ]);
  }

  Widget _buildPage4() {
    return _buildPageContent(children: [
      Center(child: Text('Page 4 – Adding It Up', style: TextStyle(fontSize: 22, color: Colors.grey))),
    ]);
  }

  Widget _buildPage5() {
    return _buildPageContent(children: [
      Center(child: Text('Page 5 – Try It Yourself', style: TextStyle(fontSize: 22, color: Colors.grey))),
    ]);
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
                          Navigator.of(context).pushReplacementNamed('practicebinarytodecimal');
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