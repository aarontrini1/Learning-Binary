import 'package:flutter/material.dart';
import 'package:learningbinary/pages/home.dart';

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
    return MaterialApp(
      onGenerateRoute: (settings) {
        Widget page;
        switch (settings.name) {
          case "home":
            page = const HomePage();
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
