import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(title: const Text("My Hobbies")),
      body: Container(
        color: Colors.grey,
        child: const Padding(
          padding: EdgeInsets.all(40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              HobbyCard(
                text: "Listening to Music",
                icon: Icons.music_note_rounded,
                backgroundColor: Colors.green,
              ),
              SizedBox(height: 10),
              HobbyCard(
                text: "Photography",
                icon: Icons.camera_alt_rounded,
                backgroundColor: Colors.indigo,
              ),
            ],
          ),
        ),
      ),
    ),
  ));
}

class HobbyCard extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color backgroundColor;
  final Gradient? gradient;
  final double borderRadius;
  final Color color;

  const HobbyCard({
    required this.text,
    required this.icon,
    this.backgroundColor = Colors.blue,
    this.gradient,
    this.borderRadius = 20,
    this.color = Colors.white,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 74,
        decoration: BoxDecoration(
          color: backgroundColor,
          gradient: gradient,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.only(right: 20),
              child: Icon(
                icon,
                color: Colors.white,
              ),
            ),
            Text(
              text,
              style: TextStyle(
                color: color,
                fontSize: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
