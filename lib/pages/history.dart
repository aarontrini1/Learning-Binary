import 'package:flutter/material.dart';
import 'package:learningbinary/utils/binaryBackground.dart';
import 'package:learningbinary/utils/progressTracker.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  int _unlockedSections = 1;
  bool _isLoading = true;
  int _completedLearning = 0;

  // The 5 history sections
  final List<_HistorySection> _sections = [
    _HistorySection(
      title: 'Ancient Origins',
      icon: Icons.history_edu,
      content:
          'The concept of binary — a system using only two symbols — has roots stretching '
          'back thousands of years. Ancient cultures explored duality long before computers '
          'existed.\n\n'
          'In ancient India, the scholar Pingala (around 300-200 BC) developed a binary-like '
          'system to describe the metres of Sanskrit poetry. He used short and long syllables, '
          'much like our modern 0s and 1s, to catalogue every possible rhythmic pattern. His '
          'work is considered one of the earliest known descriptions of a binary numeral system.\n\n'
          'Similarly, the ancient Chinese text the "I Ching" (Book of Changes), dating back to '
          'around 1000 BC, uses a system of broken and unbroken lines arranged in sets of six '
          '(hexagrams) to represent 64 different states. Each line is essentially a binary digit — '
          'a broken line for yin (0) and an unbroken line for yang (1). This system was used for '
          'divination and philosophy, but its mathematical structure is unmistakably binary.',
    ),
    _HistorySection(
      title: 'Leibniz & Modern Binary',
      icon: Icons.auto_stories,
      content:
          'The formal binary number system as we know it today was invented by the German '
          'mathematician and philosopher Gottfried Wilhelm Leibniz in 1679. He published his '
          'article "Explication de l\'Arithmétique Binaire" in 1703, laying out the complete '
          'rules for binary arithmetic — addition, subtraction, multiplication, and division '
          'using only the digits 0 and 1.\n\n'
          'Leibniz was fascinated by the elegance of binary. He saw a deep philosophical '
          'meaning in it: 1 represented God (something) and 0 represented the void (nothing), '
          'and from these two alone, all numbers — and by extension all of creation — could '
          'be derived.\n\n'
          'Interestingly, Leibniz later learned about the I Ching from a French Jesuit '
          'missionary and was struck by the parallels between the ancient hexagrams and '
          'his own binary system. He saw this as confirmation of a universal truth underlying '
          'his mathematical discovery.',
    ),
    _HistorySection(
      title: 'Boolean Logic & Early Machines',
      icon: Icons.memory,
      content:
          'In 1854, English mathematician George Boole published "An Investigation of the '
          'Laws of Thought," which introduced what we now call Boolean algebra. Boole showed '
          'that logical reasoning could be expressed using just two values — TRUE and FALSE '
          '(or 1 and 0) — combined with operations like AND, OR, and NOT. This was a '
          'groundbreaking bridge between binary numbers and logical thinking.\n\n'
          'Decades later, in his landmark 1937 master\'s thesis at MIT, Claude Shannon '
          'demonstrated that Boolean algebra could be used to design electrical switching '
          'circuits. He showed that switches set to ON or OFF could represent 1s and 0s, and '
          'that combining these switches could perform any logical or arithmetic operation.\n\n'
          'This single insight — that electrical circuits could "think" in binary — became the '
          'foundation of all digital electronics. Shannon\'s work earned him the title "father '
          'of information theory" and paved the way for every computer that would follow.',
    ),
    _HistorySection(
      title: 'The Computer Revolution',
      icon: Icons.computer,
      content:
          'Binary truly came to life with the first electronic computers of the 1940s. The '
          'ENIAC (1945) was one of the earliest general-purpose electronic computers, though '
          'it actually used a decimal system internally. It was the later machines that fully '
          'embraced binary.\n\n'
          'John von Neumann\'s 1945 design for the EDVAC proposed storing both instructions '
          'and data in binary form in the same memory — the "stored-program" concept that '
          'virtually all modern computers still use. Every program you run, every file you '
          'open, and every message you send is ultimately a sequence of binary digits stored '
          'and processed according to principles Von Neumann described.\n\n'
          'Through the 1950s, 60s, and 70s, computers shrank from room-sized machines to '
          'desktop devices, but binary remained at the heart of every one. The invention of '
          'the transistor (1947) and later the integrated circuit (1958) allowed engineers '
          'to pack millions, then billions, of tiny binary switches onto a single chip — each '
          'one flipping between 0 and 1 billions of times per second.',
    ),
    _HistorySection(
      title: 'Binary in the Modern World',
      icon: Icons.public,
      content:
          'Today, binary is the invisible language behind nearly everything in the digital '
          'world. Every photo on your phone, every song you stream, every text message you '
          'send, and every web page you visit is ultimately represented as a massive sequence '
          'of 0s and 1s.\n\n'
          'Text is encoded in binary using standards like ASCII and Unicode — for example, '
          'the letter "A" is 01000001 in binary (decimal 65). Images are grids of pixels, '
          'each described by binary numbers for red, green, and blue colour values. Sound '
          'is captured as thousands of binary samples per second. Video combines both.\n\n'
          'Binary also underpins the internet itself. When data travels across networks, it '
          'is broken into packets of binary information, routed through switches and routers '
          '(all operating in binary), and reassembled at the destination.\n\n'
          'From self-driving cars to medical imaging, from artificial intelligence to space '
          'exploration — every breakthrough in modern computing still comes down to the '
          'same elegant idea Leibniz formalised over 300 years ago: everything can be '
          'expressed with just two simple digits, 0 and 1.',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _loadProgress();
  }

  Future<void> _loadProgress() async {
    final unlocked = await ProgressTracker.getUnlockedHistorySections();
    final completed = await ProgressTracker.getCompletedCount();
    if (mounted) {
      setState(() {
        _unlockedSections = unlocked;
        _completedLearning = completed;
        _isLoading = false;
      });
    }
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
                  'History of Binary',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade800,
                  ),
                ),
                const SizedBox(height: 6),
                // Progress indicator
                Text(
                  '$_unlockedSections of ${_sections.length} sections unlocked',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white.withOpacity(0.9),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 16),
                // Section list
                Expanded(
                  child: _isLoading
                      ? const Center(child: CircularProgressIndicator(color: Colors.white))
                      : ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          itemCount: _sections.length,
                          itemBuilder: (context, index) {
                            final section = _sections[index];
                            final isUnlocked = index < _unlockedSections;
                            return _buildSectionCard(section, index, isUnlocked);
                          },
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

  Widget _buildSectionCard(_HistorySection section, int index, bool isUnlocked) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GestureDetector(
        onTap: isUnlocked
            ? () => _openSection(context, section, index)
            : () => _showLockedMessage(context, index),
        child: Container(
          decoration: BoxDecoration(
            color: isUnlocked ? Colors.white : Colors.white.withOpacity(0.4),
            borderRadius: BorderRadius.circular(14),
            boxShadow: isUnlocked
                ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ]
                : [],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Section number circle
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: isUnlocked
                        ? Colors.blue.shade700
                        : Colors.grey.shade400,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: isUnlocked
                        ? Icon(section.icon, color: Colors.white, size: 22)
                        : const Icon(Icons.lock, color: Colors.white, size: 20),
                  ),
                ),
                const SizedBox(width: 14),
                // Section info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Section ${index + 1}',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: isUnlocked
                              ? Colors.blue.shade600
                              : Colors.grey.shade500,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        isUnlocked ? section.title : '???',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: isUnlocked
                              ? Colors.blue.shade800
                              : Colors.grey.shade500,
                        ),
                      ),
                    ],
                  ),
                ),
                // Arrow or lock
                Icon(
                  isUnlocked ? Icons.chevron_right : Icons.lock_outline,
                  color: isUnlocked
                      ? Colors.blue.shade700
                      : Colors.grey.shade400,
                  size: 26,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _openSection(BuildContext context, _HistorySection section, int index) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => _HistoryDetailPage(
          section: section,
          sectionIndex: index,
          totalSections: _sections.length,
        ),
      ),
    );
  }

  void _showLockedMessage(BuildContext context, int index) {
    final sectionsNeeded = index - _unlockedSections + 1;
    final label = sectionsNeeded == 1 ? 'learning section' : 'learning sections';
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        title: Row(
          children: [
            Icon(Icons.lock, color: Colors.orange.shade700),
            const SizedBox(width: 8),
            const Text('Section Locked'),
          ],
        ),
        content: Text(
          'Complete $sectionsNeeded more $label to unlock this section!\n\n'
          'Head to the Learning area and finish a lesson to earn your next unlock.',
          style: const TextStyle(fontSize: 16),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Got it'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue.shade700,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {
              Navigator.of(ctx).pop();
              Navigator.of(context).pop(); // Go back to home
              Navigator.of(context).pushNamed('learning');
            },
            child: const Text('Go to Learning'),
          ),
        ],
      ),
    );
  }
}

// History Detail Page

class _HistoryDetailPage extends StatelessWidget {
  final _HistorySection section;
  final int sectionIndex;
  final int totalSections;

  const _HistoryDetailPage({
    required this.section,
    required this.sectionIndex,
    required this.totalSections,
  });

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

          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 50),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Header icon
                            Center(
                              child: Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  color: Colors.blue.shade50,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  section.icon,
                                  color: Colors.blue.shade700,
                                  size: 30,
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            // Section label
                            Center(
                              child: Text(
                                'Section ${sectionIndex + 1} of $totalSections',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.blue.shade400,
                                ),
                              ),
                            ),
                            const SizedBox(height: 6),
                            Center(
                              child: Text(
                                section.title,
                                style: TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue.shade800,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            const SizedBox(height: 20),
                            // Divider
                            Divider(color: Colors.blue.shade100, thickness: 1.5),
                            const SizedBox(height: 16),
                            // Content
                            Text(
                              section.content,
                              style: TextStyle(
                                fontSize: 16,
                                height: 1.6,
                                color: Colors.grey.shade800,
                              ),
                            ),
                            const SizedBox(height: 30),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
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
}

// Data Model

class _HistorySection {
  final String title;
  final IconData icon;
  final String content;

  const _HistorySection({
    required this.title,
    required this.icon,
    required this.content,
  });
}