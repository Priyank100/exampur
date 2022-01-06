import 'package:exampur_mobile/data/model/dummy_model.dart';
import 'package:exampur_mobile/data/model/paid_course_model.dart';
import 'package:exampur_mobile/data/model/paid_course_tab.dart';
import 'package:exampur_mobile/presentation/home/paid_courses/teaching_list.dart';
import 'package:exampur_mobile/presentation/widgets/custom_tab_bar.dart';
import 'package:exampur_mobile/provider/PaidCourseProvider.dart';
import 'package:exampur_mobile/utils/images.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'home_list.dart';

class PaidCourses extends StatefulWidget {
  const PaidCourses({Key? key}) : super(key: key);

  @override
  _PaidCoursesState createState() => _PaidCoursesState();
}

class _PaidCoursesState extends State<PaidCourses> with TickerProviderStateMixin {
  Set<String> selected = new Set<String>();
  List<Data> tabList = [];
  List<Courses> courseList = [];
  List<DummyModel> defenceList = [];
  List<DummyModel> allcourses = [];
  late TabController _controller;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    callProvider();
    _controller = TabController(length: 14, vsync: this);

    _controller.addListener(() async{
      print("Selected Index: " + _controller.index.toString());
      switch( _controller.index) {
        case 0:
          allcourses.add(DummyModel(imagePath: Images.exampur_logo,title: 't1',target: 'tg1'));
          allcourses.add(DummyModel(imagePath: Images.exampur_logo,title: 't2',target: 'tg2'));
          allcourses.add(DummyModel(imagePath: Images.exampur_logo,title: 't3',target: 'tg3'));
          allcourses.add(DummyModel(imagePath: Images.exampur_logo,title: 't4',target: 'tg4'));
          break;
        case 1:
          allcourses.add(DummyModel(imagePath: Images.exampur_logo,title: 't1',target: 'tg1'));
          allcourses.add(DummyModel(imagePath: Images.exampur_logo,title: 't2',target: 'tg2'));
          allcourses.add(DummyModel(imagePath: Images.exampur_logo,title: 't3',target: 'tg3'));
          allcourses.add(DummyModel(imagePath: Images.exampur_logo,title: 't4',target: 'tg4'));
          break;
        case 2:
          courseList = (await Provider.of<PaidCoursesProvider>(context, listen: false).getPaidCourseList(context))!;
          break;
        case 3:

          break;
        case 4:

          break;
        case 5:

          break;
        case 6:

          break;
        case 7:

          break;
        case 8:

          break;
        case 9:

          break;
        case 10:

          break;
        case 12:

          break;
        case 13:

          break;
        case 14:

          break;

      }
      setState(() {});
    });
  }
  Future<void> callProvider() async {
    tabList =
    (await Provider.of<PaidCoursesProvider>(context, listen: false)
        .getPaidCourseTabList(context))!;

    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarDemo(
        controller: _controller,
          length:14 ,
          names: ["Home", "AllCourse", "Teaching", "Defence", "Civil Services","Banking","UPSSSC","Rajasthan","Railways","All Competetive Exam","ENGINEERING","OFFLINE","State Police","IT"],
          routes: [
            courseList.length == 0 ? Center(child: CircularProgressIndicator()) :
            HomeList(allcourses),
            HomeList(allcourses),
            TeachingList(courseList),
            TeachingList(courseList),
            TeachingList(courseList),
            TeachingList(courseList),
            TeachingList(courseList),
            TeachingList(courseList),
            TeachingList(courseList),
            TeachingList(courseList),
            TeachingList(courseList),
            TeachingList(courseList),
            TeachingList(courseList),
            TeachingList(courseList),
          ],
          title: ""),
    );
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();}
}
