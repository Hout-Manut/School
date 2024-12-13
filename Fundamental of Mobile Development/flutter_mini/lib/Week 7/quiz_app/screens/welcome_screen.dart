import 'package:flutter/material.dart';
import '../widgets/app_button.dart';

class WelcomeScreen extends StatelessWidget {
  final void Function() onStart;
  final String title;

  const WelcomeScreen({
    super.key,
    required this.title,
    required this.onStart,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Column(
          children: [
            Image.asset(
              'assets/week-7/quiz-logo.png',
              height: 600,
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 40),
            AppButton(
              icon: Icons.arrow_right_alt_rounded,
              "Start Quiz",
              onTap: onStart,
            ),
          ],
        ),
      ),
    );
  }
}
