import 'package:exampur_mobile/data/model/paid_course_tab.dart';
import 'package:exampur_mobile/presentation/home/paid_courses/teaching_list.dart';
import 'package:exampur_mobile/presentation/widgets/custom_tab_bar.dart';
import 'package:exampur_mobile/provider/PaidCourseProvider.dart';
import 'package:exampur_mobile/utils/appBar.dart';
import 'package:exampur_mobile/utils/app_colors.dart';
import 'package:exampur_mobile/utils/app_constants.dart';


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/analytics_constants.dart';

class PaidCourses extends StatefulWidget {
  final int courseType;
  final String? categoryId;

  const PaidCourses(this.courseType, {this.categoryId}) : super();

  @override
  _PaidCoursesState createState() => _PaidCoursesState();
}

class _PaidCoursesState extends State<PaidCourses> with SingleTickerProviderStateMixin {
  TabController? _controller;
  List<Data> paidCourseTabList = [];
  List<Data> freeCourseTabList = [];
  bool isPaidData = false;
  bool isFreeData = false;

  int tabIndex = 0;

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
    for(int i=0; i<paidCourseTabList.length; i++) {
      if(widget.categoryId == paidCourseTabList[i].id) {
        tabIndex = i;
      }
      if(paidCourseTabList[i].name!.toLowerCase().contains('offline')){
        paidCourseTabList.remove(paidCourseTabList[i]);
      }
      if(paidCourseTabList[i].name!.toLowerCase().contains('recorded')){
        paidCourseTabList.remove(paidCourseTabList[i]);
      }
    }
    for(int i=0; i<freeCourseTabList.length; i++) {
      if(widget.categoryId == freeCourseTabList[i].id) {
        tabIndex = i;
      }
    }
    isPaidData = true;
    isFreeData = true;
  }

  @override
  void initState() {
    getLists();
    var map = {
      'Page_Name':'Home_Page',
      'Mobile_Number':AppConstants.userMobile,
      'Language':AppConstants.langCode,
      'Course_Category':AppConstants.selectedCategoryNameList.toString(),
      'User_ID':AppConstants.userMobile
    };
    widget.courseType == 1? AnalyticsConstants.trackEventMoEngage(AnalyticsConstants.Click_Paid_Courses,map):null;
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
            ? paidCourseTabList.map((item) => TeachingList(1, item.id.toString(),item.name.toString())).toList()
            : freeCourseTabList.map((item) => TeachingList(0, item.id.toString(), item.name.toString())).toList(),

        title: "",
        selectedTabIndex: tabIndex);
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
