enum QuestionType { SINGLE, MULTI }

class Question {
  final String title;
  final QuestionType type;
  final List<Choice> _answers;
  final List<Choice> availibleChoices;

  Question(
      {required this.title,
      required this.type,
      required List<Choice> answers,
      required List<Choice> choices})
      : _answers = answers,
        availibleChoices = choices;

  Question.single(
      {required this.title,
      required Choice answers,
      required List<Choice> choices})
      : type = QuestionType.SINGLE,
        _answers = [answers],
        availibleChoices = choices;
  Question.multi(
      {required this.title,
      required List<Choice> answers,
      required List<Choice> choices})
      : type = QuestionType.MULTI,
        _answers = answers,
        availibleChoices = choices;


}


class Result {
  final Question question;
  final List<Choice> choices;

  Result({required this.question, required this.choices});


}


class Choice {
  final String name;
  final dynamic value;

  Choice({required this.name, required this.value});
}

class Player {
  final String firstName;
  final String lastName;
  final Quiz quiz;

  Player({required this.firstName, required this.lastName, required this.quiz});

  void answer({required Question question, required List<Choice> choices}) {}
}

class Quiz {
  final List<Player> players = [];

  Player createPlayer({required String firstName, required String lastName}) {
    return Player(firstName: firstName, lastName: lastName, quiz: this);
  }

  void answer({required Player player, required Question question, required List<Choice> choices}) {

  }
}


void main() {

}
