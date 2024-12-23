import 'package:flutter/material.dart';
import 'package:flutter_mini/Week%20X/Final/widgets/course_view.dart';
import '../data/dummy_data.dart';
import '../models/course.dart';

class CoursesView extends StatefulWidget {
  const CoursesView({super.key});

  @override
  State<CoursesView> createState() => _CoursesViewState();
}

class _CoursesViewState extends State<CoursesView> {
  List<Course> courses = [];

  @override
  void initState() {
    courses.add(htmlCourse);
    courses.add(javaCourse);
    courses.add(pythonCourse);
    courses.add(cppCourse);
    super.initState();
  }

  void onTap(int index) {
    Course target = courses[index];

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return CourseView(
            target,
            onScoreCreate: (newScore) {
              setState(() {
                courses[index].scores.add(newScore);
              });
            },
            onScoreDelete: (index) {
              setState(() {
                courses[index].scores.removeAt(index);
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
        title: const Text("Score App"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView.builder(
            itemCount: courses.length,
            itemBuilder: (context, index) {
              final Course course = courses[index];
              return CourseCard(course, onTap: () => onTap(index));
            }),
      ),
    );
  }
}

class CourseCard extends StatelessWidget {
  final Course course;
  final void Function() onTap;
  const CourseCard(this.course, {super.key, required this.onTap});

  List<Widget> buildChild() {
    if (course.scores.isEmpty) {
      return [const SubText("No score")];
    } else {
      String scoreStr = course.scores.length == 1 ? "score" : "scores";

      return [
        SubText("${course.scores.length} $scoreStr"),
        SubText("Average: ${course.averageScore.toStringAsFixed(1)}"),
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 4),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                course.name,
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
              ...buildChild(),
            ],
          ),
        ),
      ),
    );
  }
}

class SubText extends StatelessWidget {
  final String data;
  const SubText(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: TextStyle(
        fontSize: 14,
        color: Color(0xFF4D4D4D),
      ),
    );
  }
}
