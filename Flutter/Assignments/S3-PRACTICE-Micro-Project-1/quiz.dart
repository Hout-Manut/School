import 'dart:io';
import 'dart:math';

enum QuestionType { SINGLE, MULTI }

/// A class made to store choices/answers and provide comparision
class Choices {
  final Set<Choice> choices;

  Choices(Iterable<Choice> answers) : choices = answers.toSet();
  Choices.one(Choice answers) : choices = {answers};

  int get length => choices.length;

  bool containsAll(Choices other) {
    if (choices.length < other.choices.length) return false;

    if (choices.isEmpty) return true;

    for (Choice answer in other.choices)
      if (!choices.any((correctAnswer) => correctAnswer == answer))
        return false;

    return true;
  }

  @override
  bool operator ==(covariant Choices other) {
    if (choices.length != other.choices.length) return false;

    if (choices.isEmpty) return true;

    for (Choice answer in other.choices)
      if (!choices.any((correctAnswer) => correctAnswer == answer))
        return false;

    return true;
  }

  List<String> getNames() {
    List<String> buffer = [];
    choices.forEach((choice) => buffer.add(choice.name));
    return buffer;
  }

  @override
  String toString() => choices.toString();

  Choices elementsAt(Iterable<int> indexes) {
    List<Choice> buffer = [];
    indexes.forEach((index) => buffer.add(choices.elementAt(index)));
    if (buffer.isEmpty)
      throw "Error: cannot find choices with index: $indexes.";
    return Choices(buffer);
  }

  Choice elementAt(int index) => choices.elementAt(index);
}

class Choice {
  final String name;
  final String value;

  Choice({
    required this.name,
    required dynamic value,
  }) : this.value = value.toString();

  Choice.auto(dynamic value)
      : value = value.toString(),
        name = value.toString();

  @override
  bool operator ==(covariant Choice other) {
    return value == other.value;
  }

  @override
  String toString() {
    return "Choice($name, $value)";
  }
}

class Question {
  final int _id;
  final String title;
  final QuestionType type; // Might be redundant
  final Choices _correctAnswers;
  final Choices availibleChoices;

  Question({
    required int id,
    required this.title,
    required this.type,
    required Choices answers,
    required Choices choices,
  })  : _id = id,
        _correctAnswers = answers,
        availibleChoices = choices {
    // if (type == QuestionType.SINGLE && _correctAnswers.length != 1)
    //   throw "Error: invalid Question arguments. Expected 1 answer.";
    if (type == QuestionType.MULTI && _correctAnswers.length == 1)
      throw "Error: invalid Question arguments. Expected multiple answers.";
  }

  Question.single({
    required int id,
    required this.title,
    required Choices answers,
    required Choices choices,
  })  : _id = id,
        type = QuestionType.SINGLE,
        _correctAnswers = answers,
        availibleChoices = choices;
  Question.multi({
    required int id,
    required this.title,
    required Choices answers,
    required Choices choices,
  })  : _id = id,
        type = QuestionType.MULTI,
        _correctAnswers = answers,
        availibleChoices = choices;

  @override
  String toString() {
    String ans = _correctAnswers.length == 1 ? "Answer" : "Answers";
    return "Question($title, $type, $ans{$_correctAnswers}, Choices{$availibleChoices)}";
  }

  Result _answer({required Iterable<int> choiceIndex, required Player player}) {
    Choices choices = availibleChoices.elementsAt(choiceIndex);
    return Result(question: this, choices: choices, player: player);
  }
}

class Result {
  final Question question;
  final Choices choices;
  final Player player;

  Result({
    required this.question,
    required this.choices,
    required this.player,
  }) {
    this.player.history.add(this);
  }

  bool get isCorrect {
    if (question.type == QuestionType.SINGLE)
      return question._correctAnswers.containsAll(choices);
    return question._correctAnswers == choices;
  }

  @override
  String toString() {
    return "Result(correct: $isCorrect, $question, guessed: $choices, by $player)";
  }
}

class Player {
  final String firstName;
  final String lastName;
  final List<Result> history = [];
  final int _id;
  Quiz? quiz;

  Player({
    required int id,
    required this.firstName,
    required this.lastName,
    this.quiz,
  }): _id = id;

  @override
  bool operator ==(covariant Player other) {
    return firstName == other.firstName && lastName == other.lastName;
  }

  void link(Quiz quiz) => this.quiz = quiz;

  Result answer({
    required Iterable<int> choiceIndex,
    Question? question,
    int? questionId,
  }) {
    if (quiz == null) throw "Player is not linked to a quiz instance.";
    return quiz!.answer(
      player: this,
      choiceIndex: choiceIndex,
      question: question,
      questionId: questionId,
    );
  }

  @override
  String toString() {
    return "Player($firstName $lastName)";
  }
}

class Quiz {
  final Set<Player> players = {};
  final Set<Question> questions = {};
  final Random _rand = Random();

  Question createQuestion({
    required String title,
    required QuestionType type,
    required Choices answers,
    required Choices choices,
    int? id,
  }) {
    int idToUse = id ?? this.generateNewId(questions);
    Question newQuestion = Question(
      id: idToUse,
      title: title,
      type: type,
      answers: answers,
      choices: choices,
    );
    this.addQuestion(newQuestion);
    return newQuestion;
  }

  Player createPlayer({
    required String firstName,
    required String lastName,
    int? id,
  }) {
    int idToUse = id ?? this.generateNewId(this.players);
    Player newPlayer =
        Player(id: idToUse,firstName: firstName, lastName: lastName, quiz: this);
    this.addPlayer(newPlayer);
    return newPlayer;
  }

  void addQuestion(Question question) {
    questions.forEach((q) {
      if (q._id == question._id)
        throw "Error: Question with ID ${q._id} already exists!";
    });
    questions.add(question);
  }

  void addPlayer(Player player) {
    players.forEach((p) {
      if (p == player) throw "Name already taken.";
    });
    player.link(this);
    players.add(player);
  }

  int generateNewId(Set<dynamic> questionsOrPlayers) {
    Set<int> existingIds = {};
    questionsOrPlayers.forEach((q) => existingIds.add(q._id));
    int newId;
    while (true) {
      newId = _rand.nextInt(8999) + 1000;
      if (existingIds.contains(newId)) continue;
      break;
    }
    return newId;
  }

  Result answer({
    required Player player,
    required Iterable<int> choiceIndex,
    Question? question,
    int? questionId,
  }) {
    if (question == null && questionId == null)
      throw "Error: invalid `answer` arguments. Requires `question` or `questionId` to be entered.";
    else if (question != null)
      return question._answer(choiceIndex: choiceIndex, player: player);

    for (Question q in questions) {
      if (q._id == questionId)
        return q._answer(choiceIndex: choiceIndex, player: player);
    }
    throw "Error: no questions found with id $questionId.";
  }

  Result ask({required Player player, Question? question}) {
    Question q = question ?? this.randomQuestion();

    Set<int> guesses = askAndGetIndexes(q);
    return this.answer(player: player, choiceIndex: guesses, question: q);
  }

  Question randomQuestion() {
    int length = questions.length;
    int randomIndex = _rand.nextInt(length);
    return questions.elementAt(randomIndex);
  }

  Question questionWithId(int id) {
    for (Question question in questions) {
      if (question._id == id) return question;
    }
    throw "Error: no question found with id $id.";
  }

  Player playerWithId(int id) {
    for (Player player in players) {
      if (player._id == id) return player;
    }
    throw "Error: no player found with id $id.";
  }

  Set<int> askAndGetIndexes(Question question) {
    print(question.title);
    print("Choices:");
    question.availibleChoices
        .getNames()
        .indexed
        .forEach((name) => print("${name.$1 + 1}: ${name.$2}"));
    Set<int> indexes;
    String prompt;
    switch (question.type) {
      case QuestionType.SINGLE:
        prompt = "Choose only one: ";
      case QuestionType.MULTI:
        prompt = "Choose all matches: ";
    }

    while (true) {
      try {
        stdout.write(prompt);
        indexes = this.parseInput(stdin.readLineSync());
      } catch (e) {
        print(e);
        continue;
      }
      break;
    }
    return indexes;
  }

  Set<int> parseInput(String? input) {
    if (input == null) throw "Invalid input.";

    List<String> chunks = input.split(RegExp(r"[ ,]+"));
    Set<int> buffer = {};
    chunks.forEach((chunk) {
      int? index = int.tryParse(chunk);
      if (index != null) buffer.add(index - 1);
    });
    if (buffer.isEmpty) throw "Invalid input.";
    return buffer;
  }

  @override
  String toString() => "Quiz($questions)";
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

  quiz.createQuestion(
    title: "Whats the answer to life, the universe and everything?",
    type: QuestionType.SINGLE,
    answers: Choices.one(Choice.auto(42)),
    choices: Choices({
      Choice.auto(40),
      Choice.auto(41),
      Choice.auto(42),
      Choice.auto(43),
    }),
  );

  // Questions below graciously provided by ChatGPT.

  quiz.createQuestion(
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

  quiz.createQuestion(
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

  quiz.createQuestion(
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

  quiz.createQuestion(
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

  quiz.createQuestion(
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

  quiz.createQuestion(
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
  quiz.createQuestion(
    title: "What is a synonym for 'Happy'?",
    type: QuestionType.SINGLE,
    answers: Choices({
      Choice.auto("Joyful"),
      Choice.auto("Content"),
      Choice.auto("Glad"),
    }),
    choices: Choices({
      Choice.auto("Sad"),
      Choice.auto("Joyful"),
      Choice.auto("Angry"),
      Choice.auto("Glad"),
      Choice.auto("Content"),
    }),
  );

  quiz.createQuestion(
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

  quiz.createQuestion(
    id: 20,
    title: "Which numbers are considered even?",
    type: QuestionType.SINGLE,
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

  quiz.createQuestion(
    title: "Who discovered gravity?",
    type: QuestionType.SINGLE,
    answers: Choices({
      Choice.auto("Isaac Newton"),
      Choice.auto("Newton"),
    }),
    choices: Choices({
      Choice.auto("Albert Einstein"),
      Choice.auto("Galileo Galilei"),
      Choice.auto("Isaac Newton"),
      Choice.auto("Newton"),
    }),
  );

  return quiz;
}
