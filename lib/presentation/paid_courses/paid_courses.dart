import 'package:flutter/material.dart';
import 'package:exampur_mobile/presentation/home/home_page.dart';

class PaidCourses extends StatefulWidget {
  const PaidCourses({Key? key}) : super(key: key);

  @override
  _PaidCoursesState createState() => _PaidCoursesState();
}

class _PaidCoursesState extends State<PaidCourses> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Paid Courses'),
      ),
    );
  }
}
