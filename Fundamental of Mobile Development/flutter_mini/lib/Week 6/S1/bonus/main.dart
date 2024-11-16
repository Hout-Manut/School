import 'package:flutter/material.dart';
import 'package:flutter_mini/Week%206/S1/bonus/screen/screens.dart';
import 'package:flutter_mini/Week%206/S1/bonus/screen/welcome.dart';
import 'package:flutter_mini/Week%206/S1/bonus/screen/temperature.dart';

class TemperatureApp extends StatefulWidget {
  const TemperatureApp({super.key});

  @override
  State<TemperatureApp> createState() => _TemperatureAppState();
}

class _TemperatureAppState extends State<TemperatureApp> {
  Screens state = Screens.welcome;

  void switchScreen(Screens screen) {
    setState(() {
      state = screen;
    });
  }

  Widget getScreen() {
    switch (state) {
      case Screens.temperature:
      return Temperature();
      case Screens.welcome:
      return Welcome(callback: switchScreen);
    }
  }

  @override
  Widget build(context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
