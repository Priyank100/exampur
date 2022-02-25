import 'package:exampur_mobile/Localization/language_constrants.dart';
import 'package:exampur_mobile/data/model/booktitle.dart';
import 'package:exampur_mobile/presentation/my_courses/TeacherSubjectView/subjectView.dart';
import 'package:exampur_mobile/presentation/widgets/custom_tab_bar.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'LiveClass.dart';
import 'MyCourseNotificationView/myCourseNotification.dart';
import 'TestView.dart';
import 'TimeTable/TimetableView.dart';


class MyCourseTabView extends StatefulWidget {
  final String courseId;

  const MyCourseTabView(this.courseId) : super();

  @override
  _MyCourseTabViewState createState() => _MyCourseTabViewState();
}

class _MyCourseTabViewState extends State<MyCourseTabView> {
  List<Book> tabList = [];


  Future<String> loadJsonFromAssets() async {
    return await rootBundle.loadString('assets/LocalJson/myCourseTab.json');
  }

  void getTabList() async {
    String jsonString = await loadJsonFromAssets();
    final myCourseTabResponse = booktitleFromJson(jsonString);
    tabList = myCourseTabResponse.book!;
    setState(() {});
  }

  @override
  void initState() {
    getTabList();
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
                    LiveClass(),
                    SubjectView(widget.courseId),
                    MyCourseNotifications(widget.courseId),
                    TimeTableView(widget.courseId),
                  ],
                  title: '')
          );
        });
  }
}
