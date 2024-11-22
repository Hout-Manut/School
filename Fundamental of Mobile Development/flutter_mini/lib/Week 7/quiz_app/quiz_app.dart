import 'package:flutter/material.dart';
import 'model/quiz.dart';
import 'screens/welcome_screen.dart';
import 'screens/question_screen.dart';
import 'screens/result_screen.dart';
import 'screens/screen.dart';

Color appColor = Colors.blue[500] as Color;
 
class QuizApp extends StatefulWidget {
  const QuizApp(this.quiz, {super.key});

  final Quiz quiz;

  @override
  State<QuizApp> createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizApp> {
  Screen screen = Screen.welcome;

  void changeScreen(Screen newScreen) {
    screen = newScreen;
  }

  Widget getScreen() {
    switch (screen) {
      case Screen.welcome:
      return WelcomeScreen(title: "CRAZY QUIZZZ.", changeScreen: changeScreen,);
      case Screen.question:
      return QuestionScreen();
      case Screen.result:
      return ResultScreen();
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: appColor,
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('TODO !'),
            ],
          ),
        ),
      ),
    );
  }
}
