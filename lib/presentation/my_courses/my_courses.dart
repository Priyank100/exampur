import 'dart:io';
import 'package:exampur_mobile/presentation/theme/custom_text_style.dart';
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
        appBar: AppBar(
            title: Text(
              "My Courses",
              style: CustomTextStyle.headingBold(context),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0),
        body: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [Text("My courses class")],
            )));
  }
}