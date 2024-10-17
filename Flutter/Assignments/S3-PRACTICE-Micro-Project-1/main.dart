import 'dart:io';

import 'quiz.dart';

void main() {
  Quiz quiz = preset();

  Player guest = quiz.createPlayer(firstName: "Gue", lastName: "st");

  Question q1 = quiz.ask();

  print(q1.title);
  print("Choices:");
  q1.availibleChoices.getNames().forEach((name) => print("  $name"));
  String? answer = stdin.readLineSync();
  Result result = quiz.answer(
    player: guest,
    choices: Choices.one(
      Choice.auto(answer ?? 0),
    ),
    question: q1,
  );
  
  print(result.isCorrect ? "Correct" : "Incorrect");
}
