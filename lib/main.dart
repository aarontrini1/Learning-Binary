import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:learningbinary/pages/history.dart';
import 'package:learningbinary/pages/home.dart';
import 'package:learningbinary/pages/learning/binaryToDecimal.dart';
import 'package:learningbinary/pages/learning/learningMain.dart';
import 'package:learningbinary/pages/practice/binaryToDecimal.dart';
import 'package:learningbinary/pages/practice/binaryToText.dart';
import 'package:learningbinary/pages/practice/decimalToBinary.dart';
import 'package:learningbinary/pages/practice/practiceMain.dart';
import 'package:learningbinary/pages/practice/textToBinary.dart';
import 'package:learningbinary/pages/support.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({this.observer, this.tester, super.key});

  final NavigatorObserver? observer;
  final Widget? tester;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    return MaterialApp(
      title: "Learning Binary",
      onGenerateRoute: (settings) {
        Widget page;
        switch (settings.name) {
          case "home":
            page = const HomePage();
            break;
          // Practice Pages
          case "practice":
            page = PracticePage();
            break;
          case "practicebinarytodecimal":
            page = PracticeBinaryToDecimalPage();
            break;
          case "practicebinarytotext":
            page = PracticeBinaryToTextPage();
            break;
          case "practicedecimaltobinary":
            page = PracticeDecimalToBinaryPage();
            break;
          case "practicetexttobinary":
            page = PracticeTextToBinaryPage();
            break;
          //Learning
          case "learning":
            page = LearningPage();
            break;
          case "learningbinarytodecimal":
            page = LearningBinaryToDecimalPage();
            break;
          case "history":
            page = HistoryPage();
            break;
          case "support":
            page = SupportPage();
            break;          
          default:
            throw Exception("Unknown route used: ${settings.name}");
        }

        return MaterialPageRoute(builder: (context) => page, settings:settings);
      },
      navigatorObservers: widget.observer != null ? [widget.observer!] : [],
      home: widget.tester,
      initialRoute: widget.tester == null ? 'home' : null,

    );
  }
}
