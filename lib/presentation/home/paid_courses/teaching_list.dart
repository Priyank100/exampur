import 'package:exampur_mobile/data/model/paid_course_model.dart';
import 'package:exampur_mobile/provider/PaidCourseProvider.dart';
import 'package:exampur_mobile/shared/teaching_container.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TeachingList extends StatefulWidget {
  final int courseType;
  final String tabId;
  const TeachingList(this.courseType, this.tabId) : super();

  @override
  _TeachingListState createState() => _TeachingListState();
}

class _TeachingListState extends State<TeachingList> {
  List<Courses> paidCourseList = [];
  List<Courses> freeCourseList = [];

  Future<void> getLists() async {
    if(widget.courseType == 1) {
      paidCourseList = (await Provider.of<PaidCoursesProvider>(context, listen: false).getPaidCourseList(context, widget.tabId))!;
    } else {
      freeCourseList = (await Provider.of<PaidCoursesProvider>(context, listen: false).getFreeCourseList(context, widget.tabId))!;
    }
    setState(() {});
  }


  @override
  void initState() {
    getLists();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: widget.courseType==1 ?
        paidCourseList.length==0 ? Center(child: CircularProgressIndicator()) : listing(paidCourseList) :
        freeCourseList.length==0 ? Center(child: CircularProgressIndicator()) : listing(freeCourseList)
    );
  }

  Widget listing(list) {
    return ListView.builder(itemCount:list.length,
        itemBuilder: (BuildContext context,int index){
          return  TeachingContainer(list[index]);
        });
  }
}
