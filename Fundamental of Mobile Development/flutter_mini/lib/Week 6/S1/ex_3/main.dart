import 'package:flutter/material.dart';
import 'package:flutter_mini/Week%206/S1/ex_3/screen/screens.dart';

class TemperatureApp extends StatefulWidget {
  const TemperatureApp({super.key});

  @override
  State<TemperatureApp> createState() => _TemperatureAppState();
}

class _TemperatureAppState extends State<TemperatureApp> {
  Screens state = Screens.welcome;

  void switchScreen(Screens)

  Widget getScreen() {
    switch (state) {
      case Screens.temperature:
      return Temperature();
      case Screens.welcome:
      return Welcome(onPressed: enter);
    }
  }

  @override
  Widget build(context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF16C062),
                Color(0xFF00BCDC),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: getScreen(),
        ),
      ),
    );
  }
}

void main() {
  runApp(const TemperatureApp());
}
