import 'dart:io';
import 'dart:math';

enum QuestionType { SINGLE, MULTI }

/// A class made to store choices/answers and provide comparision
class Choices extends Iterable<Choice> {
  final Set<Choice> choices;

  Choices(Iterable<Choice> answers) : choices = answers.toSet();

  /// For `Choices` object with 1 item.
  Choices.one(Choice answers) : choices = {answers};

  int get length => choices.length;

  @override
  bool operator ==(covariant Choices other) {
    if (choices.length != other.choices.length) return false;

    if (choices.isEmpty) return true;

    for (Choice answer in other.choices)
      if (!choices.any((correctAnswer) => correctAnswer == answer))
        return false;

    return true;
  }

  /// Returns the names of the choices as a list.
  List<String> getNames() {
    List<String> buffer = [];
    choices.forEach((choice) => buffer.add(choice.name));
    return buffer;
  }

  /// Like `elementAt()` but plural.
  Choices elementsAt(Iterable<int> indexes) {
    Set<Choice> buffer = {};
    indexes.forEach((index) => buffer.add(choices.elementAt(index)));
    if (buffer.isEmpty)
      throw Exception("Cannot find choices with index: $indexes.");
    return Choices(buffer);
  }

  @override
  Choice elementAt(int index) => choices.elementAt(index);

  @override
  String toString() => choices.toString();

  @override
  Iterator<Choice> get iterator => choices.iterator;
}

class Choice {
  final String name;
  final String value;

  Choice({
    required this.name,
    required dynamic value, // casted to String for comparision
  }) : this.value = value.toString();

  /// Automatically use the value as the name.
  Choice.auto(dynamic value)
      : this.value = value.toString(),
        this.name = value.toString();

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
  // Might be redundant, kept because it's in the question
  final QuestionType type;
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
    if (type == QuestionType.SINGLE && _correctAnswers.length != 1)
      throw Exception(
          "Invalid Question arguments. Expected 1 answer. Got ${_correctAnswers.length}.");
    else if (type == QuestionType.MULTI && _correctAnswers.length == 1)
      throw Exception("Invalid Question arguments. Expected multiple answers.");
  }

  Question.single({
    required int id,
    required this.title,
    required Choice answer,
    required Choices choices,
  })  : _id = id,
        type = QuestionType.SINGLE,
        _correctAnswers = Choices.one(answer),
        availibleChoices = choices;

  Question.multi({
    required int id,
    required this.title,
    required Choices answers,
    required Choices choices,
  })  : _id = id,
        type = QuestionType.MULTI,
        _correctAnswers = answers,
        availibleChoices = choices {
    if (_correctAnswers.length == 1)
      throw "Error: invalid Question arguments. Expected multiple answers.";
  }

  @override
  String toString() {
    String ans = _correctAnswers.length == 1 ? "Answer" : "Answers";
    return "Question($title, $type, $ans{$_correctAnswers}, Choices{$availibleChoices)}";
  }

  /// Private function, use `Quiz.answer()` instead.
  Result _answer({required Iterable<int> choiceIndex, required User user}) {
    Choices choices = availibleChoices.elementsAt(choiceIndex);
    return Result(question: this, choices: choices, user: user);
  }
}

class Result {
  final Question question;
  final Choices choices;
  final User user;

  Result({
    required this.question,
    required this.choices,
    required this.user,
  }) {
    // Add this `Result` object to the user's history.
    this.user.history.add(this);
  }

  bool get isCorrect => question._correctAnswers == choices;

  @override
  String toString() {
    return "Result(correct: $isCorrect, $question, guessed: $choices, by $user)";
  }
}

class User {
  final String firstName;
  final String lastName;
  final List<Result> history = [];
  final int _id;
  final Quiz quiz;

  User({
    required int id,
    required this.firstName,
    required this.lastName,
    required this.quiz,
  }) : _id = id;

  @override
  bool operator ==(covariant User other) {
    return firstName == other.firstName && lastName == other.lastName;
  }

  /// Check if this user has answered a question.
  /// Count how many times a question needs to be answered before it's marked as answered.
  ///
  /// At first, it's 1 so if the question has been answered once, the fucntion returns `true`.\
  /// If the length of history is longer than the amount of questions by a few, the counter will be 2.\
  /// Meaning the function will check if the question has been answered twice before returning `true`.\
  /// Same for 3.
  ///
  /// TLDR: This acts like a reset when the user has answered every questions.
  bool hasAnswered(Question question) {
    int counter = (history.length / quiz.questions.length).ceil();
    counter = counter < 1 ? 1 : counter;

    int occurrences = 0;
    for (Result r in this.history) {
      if (r.question._id == question._id) {
        occurrences++;
        if (occurrences >= counter) return true;
      }
    }
    return false;
  }

  /// Answer a question.
  ///
  /// One of `question` or `questionId` must be provided.
  Result answer({
    required Iterable<int> choiceIndex,
    Question? question,
    int? questionId,
  }) {
    return quiz.answer(
      user: this,
      choiceIndex: choiceIndex,
      question: question,
      questionId: questionId,
    );
  }

  @override
  String toString() {
    return "User($firstName $lastName)";
  }

  void printHistory() {
    print("$firstName's histories:");
    history.indexed.forEach((result) {
      String correct = result.$2.isCorrect ? "Correct" : "Incorrect";
      print(
          "${(result.$1 + 1).toString().padLeft(3)}: ${result.$2.question.title}");
      print("Correct answers:");
      print("     ${result.$2.question._correctAnswers.getNames()}");
      print("Answered:");
      print("     ${result.$2.choices.getNames()}");
      print("Result: $correct");
      print("");
    });
  }
}

class Quiz {
  final Set<User> users = {};
  final Set<Question> questions = {};
  final Random _rand = Random();

  /// Returns a Question object and add it to the quiz instance.
  ///
  /// `id` is optional and will generate one if not provided.
  Question newQuestion({
    required String title,
    required QuestionType type,
    required Choices answers,
    required Choices choices,
    int? id,
  }) {
    int idToUse = id ?? this._generateNewId(this.questions);
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

  /// Returns a User object and add it to the quiz instance.
  ///
  /// `id` is optional and will generate one if not provided.
  User newUser({
    required String firstName,
    required String lastName,
    int? id,
  }) {
    int idToUse = id ?? this._generateNewId(this.users);
    User newUser =
        User(id: idToUse, firstName: firstName, lastName: lastName, quiz: this);
    this.addUser(newUser);
    return newUser;
  }

  /// Same as newQuestion but takes a question object.
  void addQuestion(Question question) {
    questions.forEach((q) {
      if (q._id == question._id)
        throw Exception("Question with ID ${q._id} already exists!");
    });
    questions.add(question);
  }

  /// Same as newUser but takes a User object.
  void addUser(User user) {
    users.forEach((p) {
      if (p == user) throw Exception("Name already taken.");
    });
    users.add(user);
  }

  /// Generates a random 6 digits number to be used as an id.
  int _generateNewId(Set<dynamic> questionsOrPlayers,
      {int min = 100000, int max = 999999}) {
    Set<int> existingIds = {};

    // Find existing ids that are of 6 digits.
    questionsOrPlayers.forEach((questionOrPlayer) {
      int id = questionOrPlayer._id;
      if (id >= min || id <= max) existingIds.add(id);
    });
    int newId;

    // If somehow there are 999,999 users/questions with 6 digits id already.
    if (existingIds.length >= max)
      throw Exception(
          "Unable to generate a new random id, program might loop forever.");
    while (true) {
      newId = _rand.nextInt(max - min) + min;
      if (existingIds.contains(newId)) continue;
      break;
    }
    return newId;
  }

  /// Answer a question as a user.
  ///
  /// One of `question` or `questionId` must be provided.
  Result answer({
    required User user,
    required Iterable<int> choiceIndex,
    Question? question,
    int? questionId,
  }) {
    if (question == null && questionId == null)
      throw Exception(
          "Invalid `answer` arguments. Requires `question` or `questionId` to be entered.");
    else if (question != null)
      return question._answer(choiceIndex: choiceIndex, user: user);

    for (Question q in questions) {
      if (q._id == questionId)
        return q._answer(choiceIndex: choiceIndex, user: user);
    }
    throw Exception("No questions found with id $questionId.");
  }

  /// Ask a user a question. If `question` is not provided, gets a random question.
  Result ask({required User user, Question? question}) {
    Question q = question ?? this.randomQuestion(user);

    Set<int> guesses = askAndGetIndexes(q);
    return this.answer(user: user, choiceIndex: guesses, question: q);
  }

  /// Private function for picking a random question of a list of questions.
  Question _trueRandomQuestion([Iterable<Question>? customQuestions]) {
    Iterable<Question> questionsToUse = customQuestions ?? this.questions;
    int length = questionsToUse.length;
    if (length == 0) throw Exception("Not enough questions to use.");
    int randomIndex = _rand.nextInt(length);
    return questionsToUse.elementAt(randomIndex);
  }

  /// Gets a random question from the list of questions.
  ///
  /// If `user` is passed, returns a random question that this user has never answered before.
  Question randomQuestion([User? user]) {
    if (user == null) return _trueRandomQuestion();

    Iterable<Question> unansweredQuestions =
        this.questions.where((q) => !user.hasAnswered(q));
    return _trueRandomQuestion(unansweredQuestions);
  }

  Question getQuestionWithId(int id) {
    for (Question question in questions) {
      if (question._id == id) return question;
    }
    throw Exception("no question found with id $id.");
  }

  User getUserWithId(int id) {
    for (User player in users) {
      if (player._id == id) return player;
    }
    throw Exception("no player found with id $id.");
  }

  /// Print the question and choices to the console
  /// and reads the input for indexes.
  ///
  /// Returns a set of indexes of the chosen choices.
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

    int choicesLength = question.availibleChoices.length;

    while (true) {
      try {
        stdout.write(prompt);
        indexes = this._parseInput(stdin.readLineSync(), choicesLength);
      } catch (e) {
        print(e);
        print("");
        continue;
      }
      break;
    }
    return indexes;
  }

  /// Parses the input string to extract integers and returns them as a set.
  ///
  /// Each integer is adjusted by subtracting 1 (i.e., input `n` becomes `n - 1`).
  Set<int> _parseInput(String? input, int? max) {
    String errorMessage = "Invalid input.";
    if (input == null) throw errorMessage;

    List<String> chunks = input.split(RegExp(r"[ ,]+"));
    Set<int> buffer = {};
    chunks.forEach((chunk) {
      int? index = int.tryParse(chunk);
      if (index == null || index < 1)
        throw errorMessage;
      else if (max != null && index > max) throw errorMessage;
      buffer.add(index - 1);
    });
    if (buffer.isEmpty) throw errorMessage;
    return buffer;
  }

  @override
  String toString() => "Quiz($questions)";
}
