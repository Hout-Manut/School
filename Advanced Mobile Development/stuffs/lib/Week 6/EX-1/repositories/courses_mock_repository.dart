import 'package:stuffs/Week%206/EX-1/models/course_model.dart';
import 'package:stuffs/Week%206/EX-1/repositories/courses_repository.dart';

class CoursesMockRepository extends CoursesRepository {

  List<Course> courses = [
    Course(name: 'Dart'),
    Course(name: 'Python'),
    Course(name: 'C#'),
    Course(name: 'Java'),
  ];


  @override
  void addScore(Course course, CourseScore score) {
    course.addScore(score);
  }

  @override
  List<Course> getCourses() => courses;
}