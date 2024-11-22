import 'package:flutter/material.dart';

enum Screens { temperature, welcome }


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

class Welcome extends StatelessWidget {
  final void Function(Screens) callback;

  const Welcome({required this.callback, super.key});

  void changeScreen() {
    callback(Screens.temperature);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Padding(
          padding: EdgeInsets.all(20.0),
          child: Icon(
            Icons.thermostat_outlined,
            size: 120,
            color: Colors.white,
          ),
        ),
        const Text(
          "Welcome !",
          style: TextStyle(
            color: Colors.white,
            fontSize: 50,
          ),
        ),
        const SizedBox(height: 15),
        OutlinedButton(
          onPressed: changeScreen,
          style: OutlinedButton.styleFrom(
              side: const BorderSide(width: 1.0, color: Colors.white)),
          child: const Text('Start to convert',
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
              )),
        )
      ],
    ));
  }
}

class Temperature extends StatelessWidget {
  Temperature({super.key});
    @override
  Widget build(BuildContext context) {
    return Text("temp screen");
  }
}