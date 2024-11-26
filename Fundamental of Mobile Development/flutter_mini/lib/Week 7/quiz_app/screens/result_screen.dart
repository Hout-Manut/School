import 'package:flutter/material.dart';
import '../model/quiz.dart';
import '../model/submission.dart';

class ResultScreen extends StatelessWidget {
  final void Function() onRestart;
  final Submission submission;
  final Quiz quiz;
  const ResultScreen({
    super.key,
    required this.onRestart,
    required this.submission,
    required this.quiz,
  });

  @override
  Widget build(BuildContext context) {
    int correctCount = submission.getScore();
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
                child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "You answered $correctCount of ${submission.answers.length}!",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 500,
                    child: ListView(
                      children: [
                        for ((int, Answer) answer in submission.answers.indexed)
                          Result(
                            answer: answer.$2,
                            displayIndex: (answer.$1 + 1).toString(),
                          )
                      ],
                    ),
                  )
                ],
              ),
            )),
            ElevatedButton.icon(
              onPressed: onRestart,
              label: Text("Restart Quiz"),
              icon: Icon(Icons.restart_alt),
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.blue.shade400,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Result extends StatelessWidget {
  final Answer answer;
  final String displayIndex;

  static const Color correctColor = Color(0xFF81C784);
  static const Color incorrectColor = Colors.red;

  const Result({super.key, required this.answer, required this.displayIndex});

  Widget buildAnswer(String choice) {
    bool isCorrectAnswer = answer.question.goodAnswer == choice;
    return Row(
      children: [
        SizedBox(
          width: 24,
          child: isCorrectAnswer ? Icon(Icons.check) : null,
        ),
        Expanded(
          child: Text(
            choice,
            style: TextStyle(
              color:
                  answer.questionAnswer == choice ? getColor() : Colors.black,
            ),
          ),
        )
      ],
    );
  }

  Color getColor() {
    return answer.isCorrect() ? Result.correctColor : Result.incorrectColor;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: getColor(),
            ),
            child: Center(
                child: Text(
              displayIndex,
              style: const TextStyle(color: Colors.white),
            )),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  answer.question.title,
                  style: const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                Column(
                  children: [
                    for (String choice in answer.question.possibleAnswers)
                      buildAnswer(choice)
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
