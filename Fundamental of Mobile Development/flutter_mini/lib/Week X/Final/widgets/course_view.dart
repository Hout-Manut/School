import 'package:flutter/material.dart';
import 'score_form.dart';

import '../models/course.dart';

class CourseView extends StatefulWidget {
  final Course course;
  final void Function(StudentScore newScore) onScoreCreate;
  final void Function(int index) onScoreDelete;
  const CourseView(
    this.course, {
    super.key,
    required this.onScoreCreate,
    required this.onScoreDelete,
  });

  @override
  State<CourseView> createState() => _CourseViewState();
}

class _CourseViewState extends State<CourseView> {
  Course get course => widget.course;

  void onCreateNew() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return ScoreForm(
            onCreate: (newScore) {
              setState(() {
                widget.onScoreCreate(newScore);
              });
            },
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(course.name),
        actions: [IconButton(onPressed: onCreateNew, icon: Icon(Icons.add))],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView.builder(
          itemCount: course.scores.length,
          itemBuilder: (context, index) {
            StudentScore score = course.scores[index];
            return StudentScoreCard(score);
          },
        ),
      ),
    );
  }
}

class StudentScoreCard extends StatelessWidget {
  final StudentScore score;
  const StudentScoreCard(this.score, {super.key});

  Color get scoreColor {
    if (score.score >= 50) {
      return Colors.green;
    } else if (score.score >= 30) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            score.name,
            style: const TextStyle(fontSize: 16),
          ),
          Text(
            score.score.toInt().toString(),
            textAlign: TextAlign.right,
            style: TextStyle(
              color: scoreColor,
              fontSize: 16,
            ),
          )
        ],
      ),
    );
  }
}
