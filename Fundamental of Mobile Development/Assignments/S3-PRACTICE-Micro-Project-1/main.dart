import 'dart:io';

import 'quiz.dart';

void main() {
  Quiz quiz = demo();

  Player player = quiz.createPlayer(firstName: "Manut", lastName: "Hout");

  while (true) {
    Result result = quiz.ask(player: player);
    print(result.isCorrect ? "Correct" : "Incorrect");

    print("Continue? (Enter):");
    String? opt = stdin.readLineSync();
    if (opt == "") continue;
    break;
  }


  print("${player.firstName}'s Histories:");
  player.history.forEach(print);
}
