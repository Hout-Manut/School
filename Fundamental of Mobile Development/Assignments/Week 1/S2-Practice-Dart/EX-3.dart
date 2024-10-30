void main() {
  // List of student scores
  List<int> scores = [45, 67, 82, 49, 51, 78, 92, 30];

  // You code
  final List<int> passedScores = List.from(scores.where((score) => score >= 50));
  final int numberOfPassed = passedScores.length;
  final String message = numberOfPassed == 1 ? "student" : "students";
  
  print(passedScores);
  print("$numberOfPassed $message passed");
}