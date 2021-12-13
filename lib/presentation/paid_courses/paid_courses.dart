import 'package:exampur_mobile/shared/course_card.dart';
import 'package:flutter/material.dart';

class PaidCourses extends StatefulWidget {
  const PaidCourses({Key? key}) : super(key: key);

  @override
  _PaidCoursesState createState() => _PaidCoursesState();
}

class _PaidCoursesState extends State<PaidCourses> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          children: [
            CourseCard(subject: "English", name: "IAS PCS 2022-23 BATCH"),
            CourseCard(subject: "English", name: "IAS PCS 2022-23 BATCH"),
            CourseCard(subject: "English", name: "IAS PCS 2022-23 BATCH"),
          ],
        ),
      ),
    );
  }
}
