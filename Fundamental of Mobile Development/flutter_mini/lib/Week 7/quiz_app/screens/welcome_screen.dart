import 'package:flutter/material.dart';
import '../widgets/app_button.dart';
import 'screen.dart';

class WelcomeScreen extends StatelessWidget {
  final void Function(Screen screen) changeScreen;
  final String title;

  const WelcomeScreen({
    super.key,
    required this.title,
    required this.changeScreen,
  });

  void startQuiz() {
    changeScreen(Screen.question);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Image.asset('assets/week7/quiz-logo.png'),
          Text(title),
          AppButton(
            "Start Quiz",
            onTap: startQuiz,
          ),
        ],
      ),
    );
  }
}
