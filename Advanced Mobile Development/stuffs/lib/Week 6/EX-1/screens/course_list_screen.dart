import 'package:flutter/material.dart';
import 'package:stuffs/Week%206/EX-1/provider/courses_provider.dart';
import '../models/course_model.dart';
import 'course_screen.dart';

const Color mainColor = Colors.blue;

class CourseListScreen extends StatefulWidget {
  const CourseListScreen({super.key});

  @override
  State<CourseListScreen> createState() => _CourseListScreenState();
}

class _CourseListScreenState extends State<CourseListScreen> {
  late final List<Course> _allCourses;

  @override
  void initState() {
    _allCourses = CoursesProvider.getCourses();
    super.initState();
  }

  void _editCourse(String courseName) async {
    await Navigator.of(context).push<Course>(
      MaterialPageRoute(builder: (ctx) => CourseScreen(courseName: courseName)),
    );

    setState(() {
      // trigger a rebuild
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: mainColor,
        title: const Text('SCORE APP', style: TextStyle(color: Colors.white)),
      ),
      body: ListView.builder(
        itemCount: _allCourses.length,
        itemBuilder:
            (ctx, index) => Dismissible(
              key: Key(_allCourses[index].name),
              child: CourseTile(
                course: _allCourses[index],
                onEdit: _editCourse,
              ),
            ),
      ),
    );
  }
}

class CourseTile extends StatelessWidget {
  const CourseTile({super.key, required this.course, required this.onEdit});

  final Course course;
  final Function(String) onEdit;

  int get numberOfScores => course.scores.length;

  String get numberText {
    return course.hasScore ? "$numberOfScores scores" : 'No score';
  }

  String get averageText {
    String average = course.average.toStringAsFixed(1);
    return course.hasScore ? "Average : $average" : '';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: ListTile(
            onTap: () => onEdit(course.name),
            title: Text(course.name),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [Text(numberText), Text(averageText)],
            ),
          ),
        ),
      ),
    );
  }
}
