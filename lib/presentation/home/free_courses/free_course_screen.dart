import 'package:exampur_mobile/data/model/ChooseCategoryModel.dart';
import 'package:exampur_mobile/data/model/dummy_model.dart';
import 'package:exampur_mobile/presentation/home/paid_courses/teaching_list.dart';
import 'package:exampur_mobile/presentation/widgets/custom_tab_bar.dart';
import 'package:exampur_mobile/utils/images.dart';
import 'package:flutter/material.dart';

class FreeCourseScreen extends StatefulWidget {
  final int courseType;
  const FreeCourseScreen(this.courseType) : super();

  @override
  _FreeCourseScreenState createState() => _FreeCourseScreenState();
}

class _FreeCourseScreenState extends State<FreeCourseScreen> with SingleTickerProviderStateMixin {
  late TabController _controller;

  List<DummyModel> paidCourseList = [];
  List<DummyModel> freeCourseList = [];

  Future<List> getLists() async {
    // booksList = (await Provider.of<BooksEBooksProvider>(context, listen: false).getBooksList(context))!;
    // return booksList;
    if(widget.courseType == 1) {
      paidCourseList.clear();
      paidCourseList.add(DummyModel(imagePath:'', target: '123456', title: 'Teaching'));
      paidCourseList.add(DummyModel(imagePath:'', target: '234567', title: 'Civil Services'));
      paidCourseList.add(DummyModel(imagePath:'', target: '345678', title: 'Banking'));
      return paidCourseList;
    } else {
      freeCourseList.clear();
      freeCourseList.add(DummyModel(imagePath:'', target: '123456', title: 'Giveaway'));
      freeCourseList.add(DummyModel(imagePath:'', target: '234567', title: 'Teaching'));
      freeCourseList.add(DummyModel(imagePath:'', target: '345678', title: 'Airman'));
      freeCourseList.add(DummyModel(imagePath:'', target: '456789', title: 'SSC'));
      freeCourseList.add(DummyModel(imagePath:'', target: '567890', title: 'UPSSSC'));
      return freeCourseList;
    }
  }

  @override
  void initState() {
    super.initState();
    getLists();
    _controller = TabController(
        length: widget.courseType==1?paidCourseList.length:freeCourseList.length,
        vsync: this
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getLists(),
        builder: (context, snapshot) {
          return Scaffold(
              body: TabBarDemo(
                  controller: _controller,
                  length: widget.courseType==1?paidCourseList.length:freeCourseList.length,
                  names:
                    widget.courseType==1?
                    [
                      for (var i = 0; i < paidCourseList.length; i++) paidCourseList[i].title.toString()
                    ] :
                    [
                      for (var i = 0; i < freeCourseList.length; i++) freeCourseList[i].title.toString()
                    ],
                  routes:
                    widget.courseType==1?
                    [
                      // for (var i = 0; i < paidCourseList.length; i++) TeachingList(paidCourseList)
                    ]:
                    [
                      // for (var i = 0; i < freeCourseList.length; i++) TeachingList(freeCourseList)
                    ],
                  title: "")
          );
        });
  }
}
