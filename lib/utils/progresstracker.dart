import 'package:shared_preferences/shared_preferences.dart';

class ProgressTracker {
  static const String _keyPrefix = 'learning_completed_';
  
  // Learning section keys
  static const String binaryToDecimal = 'binary_to_decimal';
  static const String binaryToText = 'binary_to_text';
  static const String decimalToBinary = 'decimal_to_binary';
  static const String textToBinary = 'text_to_binary';

  // Mark a learning section as completed
  static Future<void> completeSection(String sectionKey) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('$_keyPrefix$sectionKey', true);
  }

  // Check if a specific learning section is completed
  static Future<bool> isSectionCompleted(String sectionKey) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('$_keyPrefix$sectionKey') ?? false;
  }

  // Get the total number of completed learning sections (0-4)
  static Future<int> getCompletedCount() async {
    final prefs = await SharedPreferences.getInstance();
    int count = 0;
    for (String key in [binaryToDecimal, binaryToText, decimalToBinary, textToBinary]) {
      if (prefs.getBool('$_keyPrefix$key') ?? false) {
        count++;
      }
    }
    return count;
  }

  // Get the number of unlocked history sections (1-5)
  // Section 1 is always unlocked, then each completed learning section unlocks one more
  static Future<int> getUnlockedHistorySections() async {
    int completed = await getCompletedCount();
    return 1 + completed; // 1 free + up to 4 from learning
  }

  // Reset all progress
  static Future<void> resetProgress() async {
    final prefs = await SharedPreferences.getInstance();
    for (String key in [binaryToDecimal, binaryToText, decimalToBinary, textToBinary]) {
      await prefs.remove('$_keyPrefix$key');
    }
  }
}