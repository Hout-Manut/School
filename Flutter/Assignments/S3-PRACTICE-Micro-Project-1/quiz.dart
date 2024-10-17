import 'dart:math';

enum QuestionType { SINGLE, MULTI }

/// A class made to store choices/answers and provide comparision
class Choices {
  final Set<Choice> choices;

  Choices(Iterable<Choice> answers) : choices = answers.toSet();
  Choices.one(Choice answers) : choices = {answers};

  int get length => choices.length;

  bool contains(Choices other) {
    if (choices.length < other.choices.length) return false;

    if (choices.length == 0) return true;

    for (Choice answer in other.choices)
      for (Choice correctAnswer in choices)
        if (answer != correctAnswer) return false;

    return true;
  }

  @override
  bool operator ==(covariant Choices other) {
    if (choices.length != other.choices.length) return false;

    if (choices.length == 0) return true;

    for (Choice answer in other.choices)
      for (Choice correctAnswer in choices)
        if (answer != correctAnswer) return false;

    return true;
  }

  List<String> getNames() {
    List<String> buffer = [];
    choices.forEach((choice) => buffer.add(choice.name));
    return buffer;
  }

  @override
  String toString() {
    return choices.toString();
  }
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
    // else if (type == QuestionType.MULTI && _correctAnswers.length == 1)
    //   throw "Error: invalid Question arguments. Expected multiple answers.";
  }

  Question.single({
    required int id,
    required this.title,
    required Choice answers,
    required Choices choices,
  })  : _id = id,
        type = QuestionType.SINGLE,
        _correctAnswers = Choices({answers}),
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
    return "Question($title, $type, $ans(REDACTED), $availibleChoices)";
  }

  Result answer({required Choices answers, required Player player}) {
    return Result(question: this, choices: answers, player: player);
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
  });

  bool get isCorrect {
    if (question.type == QuestionType.SINGLE)
      return question._correctAnswers.contains(choices);
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
  Quiz? quiz;

  Player({
    required this.firstName,
    required this.lastName,
    this.quiz,
  });

  @override
  bool operator ==(covariant Player other) {
    return firstName == other.firstName && lastName == other.lastName;
  }

  void link(Quiz quiz) => this.quiz = quiz;

  Result answer({
    required Choices choices,
    Question? question,
    int? questionId,
  }) {
    if (quiz == null) throw "Player is not linked to a quiz instance.";
    return quiz!.answer(
      player: this,
      choices: choices,
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
    int idToUse = id ?? this.generateNewId();
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
  }) {
    Player newPlayer =
        Player(firstName: firstName, lastName: lastName, quiz: this);
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
    players.add(player);
  }

  int generateNewId() {
    Set<int> existingIds = {};
    questions.forEach((q) => existingIds.add(q._id));
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
    required Choices choices,
    Question? question,
    int? questionId,
  }) {
    if (question == null && questionId == null)
      throw "Error: invalid Quiz.answer() arguments. Requires `question` or `questionId` to be entered.";
    else if (question != null)
      return question.answer(answers: choices, player: player);

    for (Question q in questions) {
      if (q._id == questionId)
        return q.answer(answers: choices, player: player);
    }
    throw "Error: no questions found with id $questionId.";
  }

  Question ask() {
    int length = questions.length;
    int randomIndex = _rand.nextInt(length);
    return questions.elementAt(randomIndex);
  }

  @override
  String toString() {
    return "Quiz($questions)";
  }
}

Quiz preset() {
  Quiz quiz = Quiz();

  quiz.addQuestion(
    Question(
      id: 0,
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
      title: "Whats the meaning of life?",
      type: QuestionType.SINGLE,
      answers: Choices.one(Choice.auto(42)),
      choices: Choices({
        Choice.auto(40),
        Choice.auto(41),
        Choice.auto(42),
        Choice.auto(43),
      }));

  return quiz;
}
