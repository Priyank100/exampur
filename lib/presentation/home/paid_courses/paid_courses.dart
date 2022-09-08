import 'package:exampur_mobile/data/model/paid_course_tab.dart';
import 'package:exampur_mobile/presentation/home/paid_courses/teaching_list.dart';
import 'package:exampur_mobile/presentation/widgets/custom_tab_bar.dart';
import 'package:exampur_mobile/provider/PaidCourseProvider.dart';
import 'package:exampur_mobile/utils/appBar.dart';
import 'package:exampur_mobile/utils/app_colors.dart';
import 'package:exampur_mobile/utils/app_constants.dart';


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
  bool isPaidData = false;
  bool isFreeData = false;

  Future<void> getLists() async {
    if (widget.courseType == 1) {
      paidCourseTabList = (await Provider.of<PaidCoursesProvider>(context, listen: false).getPaidCourseTabList(context))!;
    } else {
      freeCourseTabList = (await Provider.of<PaidCoursesProvider>(context, listen: false).getFreeCourseTabList(context))!;
    }

    List<Data> newList1 = [];
    List<Data> newList2 = [];
    for(int i=0; i<paidCourseTabList.length; i++) {
      if(AppConstants.selectedCategoryList.contains(paidCourseTabList[i].id.toString())) {
        newList1.add(paidCourseTabList[i]);
        paidCourseTabList.remove(paidCourseTabList[i]);
      }
    }
    for(int i=0; i<freeCourseTabList.length; i++) {
      if(AppConstants.selectedCategoryList.contains(freeCourseTabList[i].id.toString())) {
        newList2.add(freeCourseTabList[i]);
        freeCourseTabList.remove(freeCourseTabList[i]);
      }
    }
    paidCourseTabList.insertAll(0,newList1);
    freeCourseTabList.insertAll(0,newList2);
    isPaidData = true;
    isFreeData = true;
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
        future: Future.delayed(Duration.zero, () => getLists()),//Center(child: AppConstants.noDataFound())
        builder: (context, snapshot) {
          return Scaffold(
              body:
              widget.courseType == 1 ?
              !isPaidData ? Center(child: CircularProgressIndicator(color: AppColors.amber,)) :
              paidCourseTabList.length == 0 ? Center(child: AppConstants.noDataFound()) : tabBar()
              :
              !isFreeData ? Center(child: CircularProgressIndicator(color: AppColors.amber)) :
              freeCourseTabList.length == 0 ? noData() : tabBar()

          );
        });
  }

  Widget tabBar() {
    return TabBarDemo(
        controller: _controller,
        length: widget.courseType == 1 ? paidCourseTabList.length : freeCourseTabList.length,

        names: widget.courseType == 1
            ? paidCourseTabList.map((item) => item.name.toString()).toList()
            : freeCourseTabList.map((item) => item.name.toString()).toList(),

        routes: widget.courseType == 1
            ? paidCourseTabList.map((item) => TeachingList(1, item.id.toString(),'')).toList()
            : freeCourseTabList.map((item) => TeachingList(0, item.id.toString(), item.name.toString())).toList(),

        title: "");
  }

  Widget noData() {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Center(
        child: AppConstants.noDataFound(),
      ),
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

}
