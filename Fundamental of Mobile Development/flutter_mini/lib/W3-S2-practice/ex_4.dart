import 'package:flutter/material.dart';

import 'gradient_button.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        backgroundColor: const Color(0xffe0e0e0),
        body: Container(
          padding: const EdgeInsets.all(40),
          child: Center(
            child: Column(
              children: [
                Card(
                  "OOP",
                  color: Colors.blue[100]!,
                ),
                Card(
                  "DART",
                  color: Colors.blue[300]!,
                ),
                Card(
                  "FLUTTER",
                  gradient: LinearGradient(
                    colors: [
                      Colors.blue[100]!,
                      Colors.blue[800]!,
                    ],
                  ),
                ),
                const GradientButton(
                  "This is a gradient button",
                  start: Color(0xffe354ff),
                  middle: [
                    Color(0xffff546b),
                    Color(0xffcbd950),
                    Color(0xff546eff),
                  ],
                  end: Color(0xffe354ff),
                  borderRadius: 60,
                )
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

class Card extends StatelessWidget {
  final String text;
  final Color? color;
  final LinearGradient? gradient;

  const Card(
    this.text, {
    this.color,
    this.gradient,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color,
        gradient: gradient,
        borderRadius: BorderRadius.circular(40),
      ),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            decoration: TextDecoration.none,
            color: Colors.white,
            fontSize: 50,
          ),
        ),
      ),
    );
  }
}
