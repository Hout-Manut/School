import 'package:stuffs/Week%206/EX-1/models/course_model.dart';

abstract class CoursesRepository {
  List<Course> getCourses();
  void addScore(Course course, CourseScore score);
}