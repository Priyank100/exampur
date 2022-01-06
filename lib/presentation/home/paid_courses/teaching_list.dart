// import 'package:exampur_mobile/data/model/DummyModel.dart';
import 'package:exampur_mobile/data/model/dummy_model.dart';
import 'package:exampur_mobile/data/model/paid_course_model.dart';
import 'package:exampur_mobile/shared/teaching_container.dart';
import 'package:flutter/material.dart';

class TeachingList extends StatefulWidget {
  final List<Courses> paidcourseList;
  const TeachingList(this.paidcourseList) : super();

  @override
  _TeachingListState createState() => _TeachingListState();
}

class _TeachingListState extends State<TeachingList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: widget.paidcourseList.length==0 ? Center(child: CircularProgressIndicator()) :
        ListView.builder(itemCount:widget.paidcourseList.length,
            itemBuilder: (BuildContext context,int index){
          return  TeachingContainer(widget.paidcourseList[index]);
        })
    );
  }
}
