class Course {
  final String name;
  final List<StudentScore> scores;

  Course({required this.name, required this.scores});

  double get totalScore {
    double buffer = 0;
    for (StudentScore score in scores) {
      buffer += score.score;
    }
    return buffer;
  }

  double get averageScore => totalScore / scores.length;
}

class StudentScore {
  final String name;
  final double score;

  const StudentScore({required this.name, required this.score});
}
