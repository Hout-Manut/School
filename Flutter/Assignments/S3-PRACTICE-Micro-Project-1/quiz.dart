enum QuestionType { SINGLE, MULTI }

/// A class made to store choices/answers and provide comparision
class Choices {
  final Set<Choice> _answers;

  Choices(Iterable<Choice> answers) : _answers = answers.toSet();
  Choices.one(Choice answers) : _answers = {answers};

  int get length => _answers.length;

  @override
  bool operator ==(covariant Choices other) {
    if (_answers.length != other._answers.length) return false;

    if (_answers.length == 0) return true;

    for (Choice answer in other._answers)
      if (!_answers.contains(answer)) return false;

    return true;
  }

  @override
  String toString() {
    return _answers.toString();
  }
}

class Choice {
  final String name;
  final dynamic _value;

  Choice({required this.name, required dynamic value}) : _value = value;

  @override
  bool operator ==(covariant Choice other) {
    return name == other.name && _value == other._value;
  }

  @override
  String toString() {
    return "Choice($name)";
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
    return "Question($title, $type, $ans(REDACTED))";
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

  bool get isCorrect => choices == question._correctAnswers;

  @override
  String toString() {
    return "Result(correct: $isCorrect, $question, $choices)";
  }
}

class Player {
  final String firstName;
  final String lastName;
  final Quiz quiz;

  Player({
    required this.firstName,
    required this.lastName,
    required this.quiz,
  });

  @override
  bool operator ==(covariant Player other) {
    return firstName == other.firstName && lastName == other.lastName;
  }

  Result answer({
    required Choices choices,
    Question? question,
    int? questionId,
  }) {
    return quiz.answer(
      player: this,
      choices: choices,
      question: question,
      questionId: questionId,
    );
  }
}

class Quiz {
  final Set<Player> players = {};
  final Set<Question> questions = {};

  Player createPlayer({required String firstName, required String lastName}) {
    Player newPlayer =
        Player(firstName: firstName, lastName: lastName, quiz: this);
    players.forEach((p) {
      if (p == newPlayer) throw "Name already taken.";
    });
    players.add(newPlayer);
    return newPlayer;
  }

  void addQuestions(Question question) => questions.add(question);

  Result answer({
    required Player player,
    required Choices choices,
    Question? question,
    int? questionId,
  }) {
    if (question == null && questionId == null)
      throw "Error: invalid Quiz.answer() arguments. Requires `question` or `questionId` to be entered.";
    else if (question != null) return question.answer(answers: choices, player: player);

    for (Question q in questions) {
      if (q._id == questionId) return q.answer(answers: choices, player: player);
    }
    throw "Error: no questions found with id $questionId.";
  }
}

void main() {
  Quiz quiz = Quiz();

  Player p1 = quiz.createPlayer(firstName: "Manut", lastName: "Hout");

  quiz.addQuestions(
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

  print(p1.answer(
      choices: Choices.one(Choice(name: "21", value: 21)), questionId: 0));
}
