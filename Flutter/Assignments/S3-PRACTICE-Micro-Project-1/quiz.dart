enum QuestionType { SINGLE, MULTI }

/// A class made to store answers and provide comparation
class Choices {
  final List<Choice> _answers;

  Choices(List<Choice> answers) : _answers = answers;

  int get length => _answers.length;

  @override
  bool operator ==(covariant Choices other) {
    if (_answers.length != other._answers.length) return false;

    if (_answers.length == 0) return true;

    for (Choice answer in other._answers)
      if (!_answers.contains(answer)) return false;

    return true;
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
}

class Question {
  final String title;
  final QuestionType type;
  final Choices _correctAnswers;
  final Choices availibleChoices;

  Question(
      {required this.title,
      required this.type,
      required Choices answers,
      required Choices choices})
      : _correctAnswers = answers,
        availibleChoices = choices;

  Question.single({
    required this.title,
    required Choice answers,
    required Choices choices,
  })  : type = QuestionType.SINGLE,
        _correctAnswers = Choices([answers]),
        availibleChoices = choices;
  Question.multi({
    required this.title,
    required Choices answers,
    required Choices choices,
  })  : type = QuestionType.MULTI,
        _correctAnswers = answers,
        availibleChoices = choices;

  @override
  String toString() {
    String ans = _correctAnswers.length == 1 ? "Answer" : "Answers";
    return "Question($title, $type, $ans(REDACTED))";
  }
}

class Result {
  final Question question;
  final Choices choices;

  Result({required this.question, required this.choices});

  bool get isCorrect => choices == question._correctAnswers;
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

  // Result answer({required Question question, required List<Choice> choices}) {}
}

class Quiz {
  final List<Player> players = [];

  Player createPlayer({required String firstName, required String lastName}) {
    return Player(firstName: firstName, lastName: lastName, quiz: this);
  }

  void answer({
    required Player player,
    required Question question,
    required List<Choice> choices,
  }) {}
}

void main() {
  Choice c1 = Choice(name: "Choice 1", value: 0);
  Choice c2 = Choice(name: "Choice 2", value: 2);
  Choice c3 = Choice(name: "Choice 3", value: "4");
  Choice c4 = Choice(name: "Choice 4", value: "8");

  Choices c1s = Choices([c1, c2]);
  Choices c2s = Choices([c1, c2]);
  Choices c3s = Choices([c1]);
  Choices c4s = Choices([c3]);

  print(c1s == c2s);
}
