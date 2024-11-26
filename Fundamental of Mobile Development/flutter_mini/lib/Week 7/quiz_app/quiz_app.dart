import 'package:flutter/material.dart';
import 'package:flutter_mini/Week%207/quiz_app/model/submission.dart';
import 'model/quiz.dart';
import 'screens/welcome_screen.dart';
import 'screens/question_screen.dart';
import 'screens/result_screen.dart';
import 'screens/screens.dart';

Color appColor = Colors.blue[500] as Color;

class QuizApp extends StatefulWidget {
  const QuizApp(this.quiz, {super.key});

  final Quiz quiz;

  @override
  State<QuizApp> createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizApp> {
  Screen screen = Screen.notStarted;
  int currentQuestion = 0;
  late Submission submission;

  @override
  void initState() {
    submission = Submission();
    super.initState();
  }

  void changeScreen(Screen newScreen) {
    setState(() {
      screen = newScreen;
    });
  }

  void submitAnswer(Question question, String answer) {
    submission.addAnswer(question, answer);
    currentQuestion++;
    if (currentQuestion >= widget.quiz.questions.length) {
      changeScreen(Screen.finished);
      return;
    }
    setState(() {});
  }

  void restart() {
    currentQuestion = 0;
    submission = Submission();
    changeScreen(Screen.notStarted);
  }

  Widget getScreen() {
    switch (screen) {
      case Screen.notStarted:
        return WelcomeScreen(
          title: widget.quiz.title,
          onStart: () => changeScreen(Screen.started),
        );
      case Screen.started:
        return QuestionScreen(
          onTap: submitAnswer,
          onSkip: () => changeScreen(Screen.finished),
          question: widget.quiz.questions[currentQuestion],
        );
      case Screen.finished:
        return ResultScreen(
          onRestart: restart,
          submission: submission,
          quiz: widget.quiz,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: getScreen());
  }
}
