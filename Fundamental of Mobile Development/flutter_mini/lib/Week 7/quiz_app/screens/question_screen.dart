import 'package:flutter/material.dart';
import '../model/quiz.dart';

class QuestionScreen extends StatelessWidget {
  final void Function(Question, String) onTap;
  final void Function() onSkip;
  final Question question;

  const QuestionScreen({
    super.key,
    required this.onTap,
    required this.onSkip,
    required this.question,
  });

  void submit(String answer) {
    onTap(question, answer);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    question.title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 32, color: Colors.white),
                  ),
                  SizedBox(height: 40),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      for (String choice in question.possibleAnswers)
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: ElevatedButton(
                            onPressed: () => submit(choice),
                            style: OutlinedButton.styleFrom(
                              backgroundColor: Colors.blue.shade400,
                            ),
                            child: Text(
                              choice,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        )
                    ],
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
            child: ElevatedButton(
              onPressed: onSkip,
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.blue.shade400,
              ),
              child: Text("Skip to Result"),
            ),
          )
        ],
      ),
    );
  }
}
