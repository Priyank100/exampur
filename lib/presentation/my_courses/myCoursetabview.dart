import 'dart:convert';

import 'package:exampur_mobile/SharePref/shared_pref.dart';
import 'package:exampur_mobile/data/model/booktitle.dart';
import 'package:exampur_mobile/presentation/my_courses/TeacherSubjectView/subjectView.dart';
import 'package:exampur_mobile/presentation/widgets/custom_tab_bar.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'MyCourseNotificationView/myCourseNotification.dart';
import 'TimeTable/TimetableView.dart';
import 'feedbackView.dart';


class MyCourseTabView extends StatefulWidget {
  final String courseId;

  const MyCourseTabView(this.courseId) : super();

  @override
  _MyCourseTabViewState createState() => _MyCourseTabViewState();
}

class _MyCourseTabViewState extends State<MyCourseTabView> {
  List<Book> tabList = [];
  String userName = '';
  String userMobile = '';


  Future<String> loadJsonFromAssets() async {
    return await rootBundle.loadString('assets/LocalJson/myCourseTab.json');
  }

  void getTabList() async {
    String jsonString = await loadJsonFromAssets();
    final myCourseTabResponse = booktitleFromJson(jsonString);
    tabList = myCourseTabResponse.book!;
    setState(() {});
  }

  Future<void> getSharedPrefData() async {
    var jsonValue = jsonDecode(await SharedPref.getSharedPref(SharedPrefConstants.USER_DATA));
    userName = jsonValue[0]['data']['first_name'].toString();
    userMobile = jsonValue[0]['data']['phone'].toString();
    setState(() {});
  }

  @override
  void initState() {
    getTabList();
    getSharedPrefData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future:  Future.delayed(Duration.zero, () => getTabList()),
        builder: (context, snapshot) {
          return Scaffold(
              body: TabBarDemo(
                  length: tabList.length,
                  names: tabList.map((item) => item.name.toString()).toList(),
                  routes: tabList.length == 0 ? [] : [
                    TimeTableView(widget.courseId),
                    SubjectView(widget.courseId),
                    MyCourseNotifications(widget.courseId),
                    FeedbackView(userName, userMobile)
                  ],
                  title: '')
          );
        });
  }
}
