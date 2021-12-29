import 'package:exampur_mobile/data/model/DummyModel.dart';
import 'package:exampur_mobile/presentation/home/current_affairs/bytes_ca.dart';
import 'package:exampur_mobile/presentation/home/current_affairs/daily_ca.dart';
import 'package:exampur_mobile/presentation/home/current_affairs/monthly_ca.dart';
import 'package:exampur_mobile/presentation/home/current_affairs/quiz_ca.dart';
import 'package:exampur_mobile/presentation/home/current_affairs/videos_ca.dart';
import 'package:exampur_mobile/presentation/home/paid_courses/teaching_list.dart';
import 'package:exampur_mobile/presentation/widgets/custom_tab_bar.dart';
import 'package:exampur_mobile/shared/video_card_ca.dart';
import 'package:exampur_mobile/utils/images.dart';
import 'package:flutter/material.dart';

class PaidCourses extends StatefulWidget {
  const PaidCourses({Key? key}) : super(key: key);

  @override
  _PaidCoursesState createState() => _PaidCoursesState();
}

class _PaidCoursesState extends State<PaidCourses> with TickerProviderStateMixin {
  Set<String> selected = new Set<String>();

  List<DummyModel> teachingList = [];
  List<DummyModel> defenceList = [];

  late TabController _controller;
  int _selectedIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // Create TabController for getting the index of current tab
    _controller = TabController(length: 14, vsync: this);

    _controller.addListener(() {
      setState(() {
        _selectedIndex = _controller.index;
      });
      print("Selected Index: " + _controller.index.toString());
      switch( _controller.index) {
        case 0:
          break;
        case 1:
          break;
        case 2:
          teachingList.add(DummyModel(imagePath: Images.exampur_logo,title: 't1',target: 'tg1'));
          teachingList.add(DummyModel(imagePath: Images.exampur_logo,title: 't2',target: 'tg2'));
          teachingList.add(DummyModel(imagePath: Images.exampur_logo,title: 't3',target: 'tg3'));
          teachingList.add(DummyModel(imagePath: Images.exampur_logo,title: 't4',target: 'tg4'));
          break;
        case 3:
          defenceList.add(DummyModel(imagePath: Images.exampur_logo,title: 'd1',target: 'dg1'));
          defenceList.add(DummyModel(imagePath: Images.exampur_logo,title: 'd2',target: 'dg2'));
          defenceList.add(DummyModel(imagePath: Images.exampur_logo,title: 'd3',target: 'dg3'));
          break;
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarDemo(
        controller: _controller,
          length:14 ,
          names: ["Home", "AllCourse", "Teaching", "Defence", "Civil Services","Banking","UPSSSC","Rajasthan","Railways","All Competetive Exam","ENGINEERING","OFFLINE","State Police","IT"],
          routes: [
            VideosCA(),
            DailyCA(),
            TeachingList(teachingList),
            TeachingList(defenceList),
            BytesCA(),
            VideosCA(),
            VideosCA(),
            VideosCA(),
            VideosCA(),
            VideosCA(),
            VideosCA(),
            VideosCA(),
            VideosCA(),
            VideosCA(),
          ],
          title: ""),
      // body: Center(
      //   child: ListView(
      //     children: [
      //       // todo:just pass the objects of the models (which are yet to be created)
      //       // CourseCard(subject: "English", name: "IAS PCS 2022-23 BATCH"),
      //       // BigCourseCard(subject: "English", name: "IAS PCS 2022-23 BATCH"),
      //       // BooksCard(subject: "English", name: "IAS PCS 2022-23 BATCH"),
      //       // EBooksCard(subject: "English", name: "April Magzine"),
      //       // FreeCourseCard(subject: "subject", name: "UPHES / General Studies"),
      //       // One2OneCard(subject: "subject", name: "BPSC TARGET BATCH 01"),
      //       // OnlineBatchesCard(subject: "subject", name: "AGRA"),
      //       // DropDownSelector(items: ["name", "address", "age", "class", "aadhar no.", "etc"], setValue: (value) {}),
      //       MultiSelect(
      //         function: (value) {
      //           setState(() {
      //             selected = value;
      //           });
      //         },
      //         options: [
      //           "subject1",
      //           "subject2",
      //           "subject3",
      //           "subject4",
      //           "subject5",
      //           "subject6",
      //           "subject7",
      //           "subject8"
      //         ],
      //         selected: selected,
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
