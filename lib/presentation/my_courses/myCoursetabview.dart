
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exampur_mobile/SharePref/shared_pref.dart';
import 'package:exampur_mobile/data/model/booktitle.dart';
import 'package:exampur_mobile/presentation/authentication/terms_condition.dart';
import 'package:exampur_mobile/presentation/home/practice_question/practice_question_category.dart';
import 'package:exampur_mobile/presentation/my_courses/Feedback/newFeedbackView.dart';
import 'package:exampur_mobile/presentation/my_courses/TeacherSubjectView/subject_view.dart';
import 'package:exampur_mobile/presentation/widgets/custom_tab_bar.dart';
import 'package:exampur_mobile/presentation/widgets/web_view.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:exampur_mobile/presentation/my_courses/Doubts/DoubtsPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'Doubts/DoubtsPage.dart';
import 'MyCourseNotificationView/myCourseNotification.dart';
import 'Feedback/feedbackView.dart';
import 'Timeline/TimetableView.dart';

class MyCourseTabView extends StatefulWidget {
  final String courseId;
  final String courseName;
  final String testSeriesLink;
  final String token;
  final String? tabTitle;


  const MyCourseTabView(this.courseId, this.courseName, this.testSeriesLink, this.token, {this.tabTitle})
      : super();

  @override
  _MyCourseTabViewState createState() => _MyCourseTabViewState();
}

class _MyCourseTabViewState extends State<MyCourseTabView> {
  List<Book> tabList = [];
  String userName = '';
  String userMobile = '';
  bool tabname = false;
  List<Widget> tabroutes =[];
  String courseId = '';
  String webId = '';

  Future<String> loadJsonFromAssets() async {
    return await rootBundle.loadString('assets/LocalJson/myCourseTab.json');
  }

  void getTabList() async {
    bool isDoubtsRequired = false;
    AppConstants.doubtCourseIdList.forEach((data) {
      if (widget.courseId == data.courseId) {
        courseId = data.courseId!;
        webId = data.webId!.toString();
        isDoubtsRequired = true;
      }
      // print('??????????????????????');
      // print(firebaseId);
    });

    if(isDoubtsRequired && tabList.length != 6){
      tabList.insert(1, Book(id: "1", name: "Doubts"));
      tabroutes =[
        TimeTableView(widget.courseId),
        DoubtsPage(widget.token, webId, 'True'),
        SubjectView(widget.courseId),
        WebViewOpen(widget.testSeriesLink, widget.token),
        MyCourseNotifications(widget.courseId),
        // FeedbackView(userName, userMobile, widget.token),
        NewFeedbackView(widget.courseId, widget.courseName)
      ];
    }
  }

  Future<void> getSharedPrefData() async {
    var jsonValue =
    jsonDecode(await SharedPref.getSharedPref(SharedPref.USER_DATA));
    userName = jsonValue[0]['data']['first_name'].toString();
    userMobile = jsonValue[0]['data']['phone'].toString();
    setState(() {});
  }


  @override
  void initState() {
    loadStaticDetails();
    getTabList();
    getSharedPrefData();
    super.initState();
  }

  loadStaticDetails() async{
    String jsonString = await loadJsonFromAssets();
    final myCourseTabResponse = booktitleFromJson(jsonString);
    tabList = myCourseTabResponse.book!;
    tabroutes = [
      TimeTableView(widget.courseId),
      SubjectView(widget.courseId),
      WebViewOpen(widget.testSeriesLink, widget.token),
      MyCourseNotifications(widget.courseId),
      // FeedbackView(userName, userMobile, widget.token)
      NewFeedbackView(widget.courseId, widget.courseName)
    ];
  }


  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
        future: Future.delayed(Duration.zero, () => getTabList()),
        builder: (context, snapshot) {
          return Scaffold(
              body: MyCourseTabBar(
                  selectedTabIndex: 1,
                  length: tabList.length,
                  names: tabList.map((item) => item.name.toString()).toList(),
                  routes: tabList.length == 0
                      ? []
                      : tabroutes,
                  title: '')
          );
        });
  }
}
