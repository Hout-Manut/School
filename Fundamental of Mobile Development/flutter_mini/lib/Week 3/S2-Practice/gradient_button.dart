import 'package:flutter/material.dart';

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
                GradientButton(
                  "OOP",
                  start: Colors.blue[100]!,
                  end: Colors.red[100]!,
                ),
                GradientButton(
                  "DART",
                  start: Colors.blue[300]!,
                  end: Colors.red[300]!,
                  width: 240,
                ),
                const GradientButton(
                  "HAO",
                  start: Color(0xffe354ff),
                  middle: [
                    Color(0xffff546b),
                    Color(0xffcbd950),
                    Color(0xff546eff),
                  ],
                  end: Color(0xffe354ff),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

class GradientButton extends StatelessWidget {
  final String text;
  final Color start;
  final List<Color>? middle;
  final Color end;
  final EdgeInsets margin;
  final EdgeInsets? padding;
  final TextDecoration textDecoration;
  final Color color;
  final double fontSize;
  final double? width;
  final double height;
  final double borderRadius;

  const GradientButton(
    this.text, {
    required this.start,
    this.middle,
    required this.end,
    this.width,
    this.height = 64,
    this.margin = const EdgeInsets.all(24),
    this.padding,
    this.textDecoration = TextDecoration.none,
    this.color = Colors.white,
    this.fontSize = 32,
    this.borderRadius = 16,
    super.key,
  });

  List<Color> unwrapColors() {
    final List<Color> colors = [start];
    final List<Color> middleColors = middle ?? [];
    colors.addAll(middleColors);
    colors.add(end);
    return colors;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: unwrapColors()),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            decoration: textDecoration,
            color: color,
            fontSize: fontSize
          ),
        ),
      ),
    );
  }
}
