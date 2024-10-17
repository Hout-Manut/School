enum QuestionType{ SINGLE, CHOISE }

class Question {
  final String title;
  final String answer;

  Question({required this.title, required this.answer});
}

class Player {
  final String firstName;
  final String lastName;
  final Quiz quiz;

  Player({required this.firstName, required this.lastName, required this.quiz});

  void answer({required Question question, required String answer}) {

  }
}

class Quiz {
  final List<Player> players = [];
}
