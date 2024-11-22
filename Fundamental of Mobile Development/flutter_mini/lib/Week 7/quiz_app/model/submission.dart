import 'quiz.dart';

class Answer {
  final Question question;
  final String questionAnswer;
  const Answer(this.question, this.questionAnswer);

  bool isCorrect() => questionAnswer == question.goodAnswer;
}

class Submission {
  final List<Answer> answers = [];
  Submission();

  int getScore() {
    int total = 0;
    for (Answer answer in answers) {
      if (answer.isCorrect()) total++;
    }
    return total;
  }

  Answer? getAnswerFor(Question question) {
    for (Answer answer in answers) {
      if (answer.question == question) return answer;
    }
    return null;
  }

  void addAnswer(Question question, String answer) {
    Answer newAnswer = Answer(question, answer);
    answers.add(newAnswer);
  }

  void removeAnswers() => answers.clear(); 
}
