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

  /// Equivalent to `.containsAll()`.
  bool operator >=(Choices other) {
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

  /// Returns the names of the choices as a list.
  List<String> getNames() {
    List<String> buffer = [];
    choices.forEach((choice) => buffer.add(choice.name));
    return buffer;
  }

  Choices elementsAt(Iterable<int> indexes) {
    List<Choice> buffer = [];
    indexes.forEach((index) => buffer.add(choices.elementAt(index)));
    if (buffer.isEmpty)
      throw "Error: cannot find choices with index: $indexes.";
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
  final QuestionType type; // Might be redundant, kept because it's in the question
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
      throw "Error: invalid Question arguments. Expected 1 answer. Got ${_correctAnswers.length}.";
    else if (type == QuestionType.MULTI && _correctAnswers.length == 1)
      throw "Error: invalid Question arguments. Expected multiple answers.";
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

  /// If the question type is SINGLE, returns `true` if what answered is a subset of the correct answers.\
  /// Else, returns `true` if what answered is the same as the correct answers.\
  /// Else else, `false`.
  bool get isCorrect {

    if (question.type == QuestionType.SINGLE)
      return question._correctAnswers >= choices;
    return question._correctAnswers == choices;
  }

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

  /// Check if the user has answered a question.
  bool hasAnswered(Question question) {
    // Fall back to true random if the user has answered every questions.
    if (quiz.questions.length <= history.length) return false;

    for (Result r in this.history) {
      if (r.question._id == question._id) return true;
    }
    return false;
  }


  /// Answer a question.\
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
      print("${(result.$1 + 1).toString().padLeft(3)}: ${result.$2.question.title}");
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

  /// Returns a Question object and add it to the quiz instance.\
  /// `id` is optional and will generate one if not provided.
  Question newQuestion({
    required String title,
    required QuestionType type,
    required Choices answers,
    required Choices choices,
    int? id,
  }) {
    int idToUse = id ?? this.generateNewId(this.questions);
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

  /// Returns a User object and add it to the quiz instance.\
  /// `id` is optional and will generate one if not provided.
  User newUser({
    required String firstName,
    required String lastName,
    int? id,
  }) {
    int idToUse = id ?? this.generateNewId(this.users);
    User newUser = User(
        id: idToUse, firstName: firstName, lastName: lastName, quiz: this);
    this.addUser(newUser);
    return newUser;
  }

  /// Same as newQuestion but takes a question object.
  void addQuestion(Question question) {
    questions.forEach((q) {
      if (q._id == question._id)
        throw "Error: Question with ID ${q._id} already exists!";
    });
    questions.add(question);
  }

  /// Same as newUser but takes a User object.
  void addUser(User user) {
    users.forEach((p) {
      if (p == user) throw "Name already taken.";
    });
    users.add(user);
  }

  int generateNewId(Set<dynamic> questionsOrPlayers) {
    Set<int> existingIds = {};
    questionsOrPlayers.forEach((q) => existingIds.add(q._id));
    int newId;

    // If somehow there are 999,999 users/questions with 6 digits id already.
    if (existingIds.length >= 999999) throw Exception("Error: Unable to generate a new random id, program might loop forever.");
    while (true) {
      newId = _rand.nextInt(899999) + 100000;
      if (existingIds.contains(newId)) continue;
      break;
    }
    return newId;
  }

  Result answer({
    required User user,
    required Iterable<int> choiceIndex,
    Question? question,
    int? questionId,
  }) {
    if (question == null && questionId == null)
      throw "Error: invalid `answer` arguments. Requires `question` or `questionId` to be entered.";
    else if (question != null)
      return question._answer(choiceIndex: choiceIndex, user: user);

    for (Question q in questions) {
      if (q._id == questionId)
        return q._answer(choiceIndex: choiceIndex, user: user);
    }
    throw "Error: no questions found with id $questionId.";
  }

  Result ask({required User user, Question? question}) {
    Question q = question ?? this.randomQuestion(user);

    Set<int> guesses = askAndGetIndexes(q);
    return this.answer(user: user, choiceIndex: guesses, question: q);
  }

  Question trueRandomQuestion([Iterable<Question>? customQuestions]) {
    Iterable<Question> questionsToUse = customQuestions ?? this.questions;
    int length = questionsToUse.length;
    if (length == 0) throw Exception("Not enough questions to use.");
    int randomIndex = _rand.nextInt(length);
    return questionsToUse.elementAt(randomIndex);
  }

  Question randomQuestion([User? player]) {
    if (player == null) return trueRandomQuestion();

    Iterable<Question> unansweredQuestions =
        this.questions.where((q) => !player.hasAnswered(q));
    return trueRandomQuestion(unansweredQuestions);
  }

  Question getQuestionWithId(int id) {
    for (Question question in questions) {
      if (question._id == id) return question;
    }
    throw "Error: no question found with id $id.";
  }

  User getUserWithId(int id) {
    for (User player in users) {
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

/// Returns a quiz object with predefined questions
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

  quiz.newQuestion(
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
