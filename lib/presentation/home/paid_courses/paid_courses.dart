import 'package:exampur_mobile/data/model/paid_course_tab.dart';
import 'package:exampur_mobile/presentation/home/paid_courses/home_list.dart';
import 'package:exampur_mobile/presentation/home/paid_courses/teaching_list.dart';
import 'package:exampur_mobile/presentation/widgets/custom_tab_bar.dart';
import 'package:exampur_mobile/provider/PaidCourseProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PaidCourses extends StatefulWidget {
  final int courseType;

  const PaidCourses(this.courseType) : super();

  @override
  _PaidCoursesState createState() => _PaidCoursesState();
}

class _PaidCoursesState extends State<PaidCourses> with SingleTickerProviderStateMixin {
  TabController? _controller;
  List<Data> paidCourseTabList = [];
  List<Data> freeCourseTabList = [];

  Future<void> getLists() async {
    if (widget.courseType == 1) {
      paidCourseTabList = (await Provider.of<PaidCoursesProvider>(context, listen: false).getPaidCourseTabList(context))!;
    } else {
      freeCourseTabList = (await Provider.of<PaidCoursesProvider>(context, listen: false).getFreeCourseTabList(context))!;
    }
  }

  @override
  void initState() {
    getLists();
    // _controller = TabController(
    //               length: widget.courseType == 1
    //                   ? paidCourseTabList.length
    //                   : freeCourseTabList.length,
    //               vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        // future: getLists(),
        future: Future.delayed(Duration.zero, () => getLists()),
        builder: (context, snapshot) {
          return Scaffold(
              body: TabBarDemo(
                  controller: _controller,
                  length: widget.courseType == 1 ? paidCourseTabList.length : freeCourseTabList.length,
                  names: widget.courseType == 1
                      ? paidCourseTabList.map((item) => item.name.toString()).toList()
                      : freeCourseTabList.map((item) => item.name.toString()).toList(),
                  routes: widget.courseType == 1
                      ? paidCourseTabList.map((item) => TeachingList(1, item.id.toString())).toList()
                      : freeCourseTabList.map((item) => TeachingList(0, item.id.toString())).toList(),
                  title: "")
          );
        });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}
