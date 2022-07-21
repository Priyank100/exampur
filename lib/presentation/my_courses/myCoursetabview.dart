import 'dart:convert';
import 'package:exampur_mobile/SharePref/shared_pref.dart';
import 'package:exampur_mobile/data/model/booktitle.dart';
import 'package:exampur_mobile/presentation/authentication/terms_condition.dart';
import 'package:exampur_mobile/presentation/home/practice_question/practice_question_category.dart';
import 'package:exampur_mobile/presentation/my_courses/TeacherSubjectView/subject_view.dart';
import 'package:exampur_mobile/presentation/widgets/custom_tab_bar.dart';
import 'package:exampur_mobile/presentation/widgets/web_view.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'MyCourseNotificationView/myCourseNotification.dart';
import 'Feedback/feedbackView.dart';
import 'Timeline/TimetableView.dart';


class MyCourseTabView extends StatefulWidget {
  final String courseId;
  final String testSeriesLink;
  final String token;
  const MyCourseTabView(this.courseId,this.testSeriesLink,this.token) : super();

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
                    WebViewOpen(widget.testSeriesLink, widget.token),
                    MyCourseNotifications(widget.courseId),
                    FeedbackView(userName, userMobile),

                  ],
                  title: '')
          );
        });
  }
}
