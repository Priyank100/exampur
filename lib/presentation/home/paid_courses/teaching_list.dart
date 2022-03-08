import 'package:exampur_mobile/data/model/paid_course_model.dart';
import 'package:exampur_mobile/provider/PaidCourseProvider.dart';
import 'package:exampur_mobile/shared/teaching_container.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TeachingList extends StatefulWidget {
  final int courseType;
  final String tabId;
  const TeachingList(this.courseType, this.tabId) : super();

  @override
  _TeachingListState createState() => _TeachingListState();
}

class _TeachingListState extends State<TeachingList> {
  List<Courses> paidCourseList = [];
  List<Courses> freeCourseList = [];
  var scrollController = ScrollController();
  bool isLoading = false;
  int isLoad = 0;

  int page = 0;
  bool isData = true;

  @override
  void initState() {
    scrollController.addListener(pagination);
    isLoad = 0;
    getLists(page);
    super.initState();
  }

  Future<void> getLists(pageNo) async {
    if(widget.courseType == 1) {
      List<Courses> list = (await Provider.of<PaidCoursesProvider>(context, listen: false).getPaidCourseList(context, widget.tabId, pageNo))!;
      if(list.length > 0) {
        isData = true;
        paidCourseList = paidCourseList + list;
      } else {
        isData = false;
      }
      isLoading = false;
    } else {
      List<Courses> list = (await Provider.of<PaidCoursesProvider>(context, listen: false).getFreeCourseList(context, widget.tabId, pageNo))!;
      if(list.length > 0) {
        isData = true;
        freeCourseList = freeCourseList + list;
      } else {
        isData = false;
      }
      isLoading = false;
    }
    isLoad++;
    setState(() {});
  }

  void pagination() {
    if ((scrollController.position.pixels == scrollController.position.maxScrollExtent)) {
      setState(() {
        if(isData) {
          page += 1;
        }
        isLoading = true;
        getLists(page);
        AppConstants.printLog('page>> ' + page.toString());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: widget.courseType==1 ?

        isLoad==0 ? Center(child: CircularProgressIndicator(color: AppColors.amber)) :
        paidCourseList.length==0 ? AppConstants.noDataFound() : listing(paidCourseList) :

        isLoad==0 ? Center(child: CircularProgressIndicator(color: AppColors.amber)) :
        freeCourseList.length==0 ? AppConstants.noDataFound() : listing(freeCourseList),

      bottomNavigationBar: isLoading ? Container(
         // padding: EdgeInsets.all(8),
          height:40,
          width: 40,
          child: Center(child: CircularProgressIndicator(color:AppColors.amber,))) :
      SizedBox(),
    );
  }

  Widget listing(list) {
    return ListView.builder(itemCount:list.length,controller: scrollController,
        itemBuilder: (BuildContext context,int index){
          return  TeachingContainer(list[index],widget.courseType);
        });
  }
}
