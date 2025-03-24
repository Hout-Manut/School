import 'package:flutter/material.dart';
import 'package:stuffs/Week%206/EX-1/provider/courses_provider.dart';
import '../models/course_model.dart';
import 'course_score_form.dart';

class CourseScreen extends StatefulWidget {
  const CourseScreen({super.key, required this.courseName});

  final String courseName;

  @override
  State<CourseScreen> createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  late final Course course;
  
  List<CourseScore> get scores => course.scores;

  @override
  void initState() {
    course = CoursesProvider.getCourseFor(widget.courseName);
    super.initState();
  }


  void _addScore() async {
    CourseScore? newScore = await Navigator.of(context).push<CourseScore>(
      MaterialPageRoute(builder: (ctx) => const CourseScoreForm()),
    );

    if (newScore != null) {
      setState(() {
        CoursesProvider.addScore(widget.courseName, newScore);
      });
    }
  }

  Color scoreColor(double score) {
    return score > 50 ? Colors.green : Colors.orange;
  }

  @override
  Widget build(BuildContext context) {
    Widget content = const Center(child: Text('No Scores added yet.'));

    if (scores.isNotEmpty) {
      content = ListView.builder(
        itemCount: scores.length,
        itemBuilder:
            (ctx, index) => ListTile(
              title: Text(scores[index].studentName),
              trailing: Text(
                scores[index].studentScore.toString(),
                style: TextStyle(
                  color: scoreColor(scores[index].studentScore),
                  fontSize: 15,
                ),
              ),
            ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: mainColor,
        title: Text(
          course.name,
          style: const TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(onPressed: _addScore, icon: const Icon(Icons.add)),
        ],
      ),
      body: content,
    );
  }
}
