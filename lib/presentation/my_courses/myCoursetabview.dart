import 'package:exampur_mobile/Localization/language_constrants.dart';
import 'package:exampur_mobile/data/model/booktitle.dart';
import 'package:exampur_mobile/presentation/my_courses/subjectView.dart';
import 'package:exampur_mobile/presentation/widgets/custom_tab_bar.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'LiveClass.dart';
import 'TimetableView.dart';

class MyCourseTabView extends StatefulWidget {
  const MyCourseTabView({Key? key}) : super(key: key);

  @override
  _MyCourseTabViewState createState() => _MyCourseTabViewState();
}

class _MyCourseTabViewState extends State<MyCourseTabView> {
  List<Book> tabList = [];


  Future<String> loadJsonFromAssets() async {
    return await rootBundle.loadString('assets/Statejson/booklist.json');
  }

  void getTabList() async {
    String jsonString = await loadJsonFromAssets();
    final BookResponse = booktitleFromJson(jsonString);
    tabList = BookResponse.book!;
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
                    SubjectView(),
                    TimeTableView(),
                  ],
                  title: '')
          );
        });
  }
}
