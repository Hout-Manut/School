import 'package:flutter/material.dart';
import 'package:stuffs/Week%206/EX-1/provider/courses_provider.dart';
import 'package:stuffs/Week%206/EX-1/repositories/courses_mock_repository.dart';

import 'screens/course_list_screen.dart';

void main() {
  CoursesProvider.initialize(CoursesMockRepository());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CourseListScreen(),
    );
  }
}
