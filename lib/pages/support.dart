import 'package:flutter/material.dart';
import 'package:learningbinary/utils/binaryBackground.dart';

class SupportPage extends StatefulWidget {
  const SupportPage({super.key});
  @override
  State<SupportPage> createState() => _SupportPageState();
}

class _SupportPageState extends State<SupportPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Data organised by category
  static const List<_ChartCategory> _categories = [
    _ChartCategory(
      label: 'A - Z',
      icon: Icons.abc,
      entries: [
        _ChartEntry(65, 'A'), _ChartEntry(66, 'B'), _ChartEntry(67, 'C'),
        _ChartEntry(68, 'D'), _ChartEntry(69, 'E'), _ChartEntry(70, 'F'),
        _ChartEntry(71, 'G'), _ChartEntry(72, 'H'), _ChartEntry(73, 'I'),
        _ChartEntry(74, 'J'), _ChartEntry(75, 'K'), _ChartEntry(76, 'L'),
        _ChartEntry(77, 'M'), _ChartEntry(78, 'N'), _ChartEntry(79, 'O'),
        _ChartEntry(80, 'P'), _ChartEntry(81, 'Q'), _ChartEntry(82, 'R'),
        _ChartEntry(83, 'S'), _ChartEntry(84, 'T'), _ChartEntry(85, 'U'),
        _ChartEntry(86, 'V'), _ChartEntry(87, 'W'), _ChartEntry(88, 'X'),
        _ChartEntry(89, 'Y'), _ChartEntry(90, 'Z'),
      ],
    ),
    _ChartCategory(
      label: 'a - z',
      icon: Icons.text_fields,
      entries: [
        _ChartEntry(97, 'a'), _ChartEntry(98, 'b'), _ChartEntry(99, 'c'),
        _ChartEntry(100, 'd'), _ChartEntry(101, 'e'), _ChartEntry(102, 'f'),
        _ChartEntry(103, 'g'), _ChartEntry(104, 'h'), _ChartEntry(105, 'i'),
        _ChartEntry(106, 'j'), _ChartEntry(107, 'k'), _ChartEntry(108, 'l'),
        _ChartEntry(109, 'm'), _ChartEntry(110, 'n'), _ChartEntry(111, 'o'),
        _ChartEntry(112, 'p'), _ChartEntry(113, 'q'), _ChartEntry(114, 'r'),
        _ChartEntry(115, 's'), _ChartEntry(116, 't'), _ChartEntry(117, 'u'),
        _ChartEntry(118, 'v'), _ChartEntry(119, 'w'), _ChartEntry(120, 'x'),
        _ChartEntry(121, 'y'), _ChartEntry(122, 'z'),
      ],
    ),
    _ChartCategory(
      label: '0 - 9',
      icon: Icons.numbers,
      entries: [
        _ChartEntry(48, '0'), _ChartEntry(49, '1'), _ChartEntry(50, '2'),
        _ChartEntry(51, '3'), _ChartEntry(52, '4'), _ChartEntry(53, '5'),
        _ChartEntry(54, '6'), _ChartEntry(55, '7'), _ChartEntry(56, '8'),
        _ChartEntry(57, '9'),
      ],
    ),
    _ChartCategory(
      label: 'Symbols',
      icon: Icons.tag,
      entries: [
        _ChartEntry(32, 'Space'), _ChartEntry(33, '!'), _ChartEntry(34, '"'),
        _ChartEntry(35, '#'), _ChartEntry(36, '\$'), _ChartEntry(37, '%'),
        _ChartEntry(38, '&'), _ChartEntry(39, "'"), _ChartEntry(40, '('),
        _ChartEntry(41, ')'), _ChartEntry(42, '*'), _ChartEntry(43, '+'),
        _ChartEntry(44, ','), _ChartEntry(45, '-'), _ChartEntry(46, '.'),
        _ChartEntry(47, '/'), _ChartEntry(58, ':'), _ChartEntry(59, ';'),
        _ChartEntry(60, '<'), _ChartEntry(61, '='), _ChartEntry(62, '>'),
        _ChartEntry(63, '?'), _ChartEntry(64, '@'), _ChartEntry(91, '['),
        _ChartEntry(92, '\\'), _ChartEntry(93, ']'), _ChartEntry(94, '^'),
        _ChartEntry(95, '_'), _ChartEntry(96, '`'), _ChartEntry(123, '{'),
        _ChartEntry(124, '|'), _ChartEntry(125, '}'), _ChartEntry(126, '~'),
      ],
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _categories.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  String _toBinary(int decimal) {
    return decimal.toRadixString(2).padLeft(8, '0');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Gradient background
          Container(
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
          CustomPaint(size: Size.infinite, painter: BinaryPatternPainter()),

          // Main content
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 50),
                Text(
                  'Reference Chart',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Decimal  •  ASCII  •  Binary',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
                const SizedBox(height: 16),

                // Tab bar
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TabBar(
                    controller: _tabController,
                    indicator: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    indicatorSize: TabBarIndicatorSize.tab,
                    dividerColor: Colors.transparent,
                    labelColor: Colors.blue.shade800,
                    unselectedLabelColor: Colors.white,
                    labelStyle: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                    unselectedLabelStyle: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                    tabs: _categories
                        .map((c) => Tab(
                              text: c.label,
                              icon: Icon(c.icon, size: 18),
                              iconMargin: const EdgeInsets.only(bottom: 2),
                            ))
                        .toList(),
                  ),
                ),
                const SizedBox(height: 12),

                // Tab content
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: _categories
                        .map((cat) => _buildTable(cat))
                        .toList(),
                  ),
                ),
              ],
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
        ],
      ),
    );
  }

  Widget _buildTable(_ChartCategory category) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: Column(
          children: [
            // Table header
            Container(
              color: Colors.blue.shade700,
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
              child: Row(
                children: const [
                  Expanded(
                    flex: 2,
                    child: Text(
                      'DEC',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      'ASCII',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(
                      'BINARY',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Table rows
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: category.entries.length,
                itemBuilder: (context, index) {
                  final entry = category.entries[index];
                  final isEven = index % 2 == 0;
                  return Container(
                    color: isEven ? Colors.white : Colors.blue.shade50,
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 8,
                    ),
                    child: Row(
                      children: [
                        // Decimal
                        Expanded(
                          flex: 2,
                          child: Text(
                            '${entry.decimal}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey.shade800,
                            ),
                          ),
                        ),
                        // ASCII character
                        Expanded(
                          flex: 2,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 4,
                              horizontal: 8,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.blue.shade700.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              entry.ascii,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue.shade800,
                              ),
                            ),
                          ),
                        ),
                        // Binary
                        Expanded(
                          flex: 3,
                          child: Text(
                            _toBinary(entry.decimal),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'monospace',
                              fontWeight: FontWeight.w500,
                              color: Colors.grey.shade700,
                              letterSpacing: 1.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Data models

class _ChartEntry {
  final int decimal;
  final String ascii;
  const _ChartEntry(this.decimal, this.ascii);
}

class _ChartCategory {
  final String label;
  final IconData icon;
  final List<_ChartEntry> entries;
  const _ChartCategory({
    required this.label,
    required this.icon,
    required this.entries,
  });
}