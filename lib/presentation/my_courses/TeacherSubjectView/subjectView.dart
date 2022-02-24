import 'package:exampur_mobile/presentation/my_courses/TeacherSubjectView/teachersubjectview.dart';
import 'package:exampur_mobile/utils/images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SubjectView extends StatefulWidget {
  const SubjectView({Key? key}) : super(key: key);

  @override
  _SubjectViewState createState() => _SubjectViewState();
}

class _SubjectViewState extends State<SubjectView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Select Subject',style: TextStyle(fontSize: 25)),
            GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
              itemBuilder: (_, index) => GridItem(),
              itemCount: 9,
            )
        ]),
      ),
    );
  }

  Widget GridItem() {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) =>
            TeacherSubjecjectView()
        ));
      },
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor:
            Colors.transparent,
            backgroundImage:AssetImage(Images.jobalert),
            radius: 40.0,
          ),
          Text('Teacher name', overflow: TextOverflow.ellipsis, maxLines: 1),
        ],
      ),
    );
  }
}