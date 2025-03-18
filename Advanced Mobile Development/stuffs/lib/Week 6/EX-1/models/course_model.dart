class Course {
  Course({required this.name});

  final String name;
  final List<CourseScore> scores = [];

  void addScore(CourseScore score) {
    scores.add(score);
  }

  bool get hasScore => scores.isNotEmpty;

  double get average {
    if (scores.isNotEmpty) {
      double total = scores.fold(0, (prev, score) => prev + score.studentScore);
      return total / scores.length;
    }
    return 0;
  }
}

class CourseScore {
  const CourseScore({required this.studentName, required this.studentScore});

  final String studentName;
  final double studentScore;
}
