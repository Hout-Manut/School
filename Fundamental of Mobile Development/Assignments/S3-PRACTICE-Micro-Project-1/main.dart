import 'dart:io';

import 'quiz.dart';

void main() {
  Quiz quiz = demo();

  User player = quiz.newUser(firstName: "Manut", lastName: "Hout");

  while (true) {
    Result result = quiz.ask(user: player);
    print(result.isCorrect ? "Correct" : "Incorrect");

    print("Continue? (Enter):");
    String? opt = stdin.readLineSync();
    if (opt == "") continue;
    break;
  }

  print("\n\n\n\n");
  player.printHistory();
}
