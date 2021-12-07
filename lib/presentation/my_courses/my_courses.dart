import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class MyCourses extends StatefulWidget {
  @override
  MyCoursesState createState() => MyCoursesState();
}

class MyCoursesState extends State<MyCourses> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(child: Text("My Courses"),)
    );
  }
}