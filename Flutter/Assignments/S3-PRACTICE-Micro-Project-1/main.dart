import 'dart:io';

import 'quiz.dart';

void main() {
  Quiz quiz = preset();

  Player guest = quiz.createPlayer(firstName: "Manut", lastName: "Hout");

  while (true) {
    Question q = quiz.randomQuestion();

    Set<int> indexes = quiz.askAndGetIndexes(q);
    Result result = quiz.answer(
      player: guest,
      choiceIndex: indexes,
      question: q,
    );

    print(result.isCorrect ? "Correct" : "Incorrect");

    print("Continue? (Enter):");
    String? opt = stdin.readLineSync();
    if (opt == "") continue;
    break;
  }

  print("${guest.firstName}'s Histories:");
  guest.history.forEach((data)=>print(data));
}
