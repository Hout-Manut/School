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


Quiz demo() {
  Quiz quiz = Quiz();

  quiz.addQuestion(
    Question(
      id: 0, // optionally add an id.
      title: "Whats 9 + 10?",
      type: QuestionType.SINGLE,
      answers: Choices.one(Choice(name: "21", value: 21)),
      choices: Choices({
        Choice(name: "19", value: 19),
        Choice(name: "20", value: 20),
        Choice(name: "21", value: 21),
      }),
    ),
  );

  // If `id` is known. you can retrieve it back.
  // Question wrongQuestion = quiz.getQuestionWithId(0);
  // quiz.questions.remove(wrongQuestion);

  quiz.newQuestion(
    title: "Whats the answer to life, the universe and everything?",
    type: QuestionType.SINGLE,
    answers: Choices.one(Choice.auto(42)), // auto() will use "42" as both name and value.
    choices: Choices({
      Choice.auto(40),
      Choice.auto(41),
      Choice.auto(42),
      Choice.auto(43),
    }),
  );

  // Questions below graciously provided by ChatGPT.

  quiz.newQuestion(
    title: "What are the primary colors?",
    type: QuestionType.MULTI,
    answers: Choices({
      Choice.auto("Red"),
      Choice.auto("Blue"),
      Choice.auto("Yellow"),
    }),
    choices: Choices({
      Choice.auto("Green"),
      Choice.auto("Orange"),
      Choice.auto("Red"),
      Choice.auto("Blue"),
      Choice.auto("Yellow"),
    }),
  );

  quiz.newQuestion(
    title: "Which animals are mammals?",
    type: QuestionType.MULTI,
    answers: Choices({
      Choice.auto("Dolphin"),
      Choice.auto("Bat"),
    }),
    choices: Choices({
      Choice.auto("Dolphin"),
      Choice.auto("Shark"),
      Choice.auto("Bat"),
      Choice.auto("Eagle"),
    }),
  );

  quiz.newQuestion(
    title: "Who wrote 'To Kill a Mockingbird'?",
    type: QuestionType.SINGLE,
    answers: Choices.one(Choice.auto("Harper Lee")),
    choices: Choices({
      Choice.auto("Mark Twain"),
      Choice.auto("Harper Lee"),
      Choice.auto("Ernest Hemingway"),
      Choice.auto("F. Scott Fitzgerald"),
    }),
  );

  quiz.newQuestion(
    title: "Which of these are programming languages?",
    type: QuestionType.MULTI,
    answers: Choices({
      Choice.auto("Python"),
      Choice.auto("Java"),
    }),
    choices: Choices({
      Choice.auto("Python"),
      Choice.auto("Java"),
      Choice.auto("HTML"),
      Choice.auto("CSS"),
    }),
  );

  quiz.newQuestion(
    title: "How many continents are there?",
    type: QuestionType.SINGLE,
    answers: Choices.one(Choice.auto(7)),
    choices: Choices({
      Choice.auto(5),
      Choice.auto(6),
      Choice.auto(7),
      Choice.auto(8),
    }),
  );

  quiz.newQuestion(
    title: "Which numbers are prime?",
    type: QuestionType.MULTI,
    answers: Choices({
      Choice.auto(2),
      Choice.auto(5),
    }),
    choices: Choices({
      Choice.auto(2),
      Choice.auto(4),
      Choice.auto(5),
      Choice.auto(6),
    }),
  );

  quiz.newQuestion(
    title: "Which city is known as 'The Big Apple'?",
    type: QuestionType.SINGLE,
    answers: Choices({
      Choice.auto("New York"),
    }),
    choices: Choices({
      Choice.auto("Los Angeles"),
      Choice.auto("New York"),
      Choice.auto("Chicago"),
    }),
  );

  quiz.newQuestion(
    id: 20,
    title: "Which numbers are considered even?",
    type: QuestionType.MULTI,
    answers: Choices({
      Choice.auto(2),
      Choice.auto(4),
      Choice.auto(6),
    }),
    choices: Choices({
      Choice(name: "< Look here", value: 1),
      Choice(name: "", value: 2),
      Choice(name: "", value: 3),
      Choice(name: "", value: 4),
      Choice(name: "", value: 5),
      Choice(name: "", value: 6),
    }),
  );

  return quiz;
}
