import 'package:exampur_mobile/data/model/paid_course_model_new.dart';
import 'package:exampur_mobile/presentation/widgets/loading_indicator.dart';
import 'package:exampur_mobile/provider/PaidCourseProvider.dart';
import 'package:exampur_mobile/shared/teaching_container.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/analytics_constants.dart';

class TeachingList extends StatefulWidget {
  final int courseType;
  final String tabId;
  final String tabName;
  const TeachingList(this.courseType, this.tabId, this.tabName) : super();

  @override
  _TeachingListState createState() => _TeachingListState();
}

class _TeachingListState extends State<TeachingList> {
  List<PaidCourseData> paidCourseList = [];
  List<PaidCourseData> freeCourseList = [];
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

    var map = {
      'Page_Name':'Course_List',
      'Course_Category':widget.tabName,
      'Mobile_Number':AppConstants.userMobile,
      'Language':AppConstants.langCode,
      'User_ID':AppConstants.userMobile,
    };

    if(widget.courseType == 1) {
    AnalyticsConstants.trackEventMoEngage(AnalyticsConstants.Course_List,map);
    }
    super.initState();
  }

  Future<void> getLists(pageNo) async {
    if(widget.courseType == 1) {
      List<PaidCourseData> list = (await Provider.of<PaidCoursesProvider>(context, listen: false).getPaidCourseList(context, widget.tabId, pageNo))!;
      // for(int i=0; i<list.length; i++) {
      //   print('>>>>' + list[i].purchase.toString());
      // }
      if(list.length > 0) {
        isData = true;
        paidCourseList = paidCourseList + list;
      } else {
        isData = false;
      }
      isLoading = false;
    } else {
      List<PaidCourseData> list = (await Provider.of<PaidCoursesProvider>(context, listen: false).getFreeCourseList(context, widget.tabId, pageNo))!;
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
          page += 10;
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

        isLoad==0 ? Center(child: LoadingIndicator(context)) :
        paidCourseList.length==0 ? AppConstants.noDataFound() : listing(paidCourseList) :

        isLoad==0 ? Center(child:LoadingIndicator(context)) :
        freeCourseList.length==0 ? AppConstants.noDataFound() : listing(freeCourseList),

      bottomNavigationBar: isLoading ? Container(
         // padding: EdgeInsets.all(8),
          height:40,
          width: 40,
          child: Center(child: LoadingIndicator(context))) :
      SizedBox(),
    );
  }

  Widget listing(list) {
    return ListView.builder(itemCount:list.length,controller: scrollController,
        itemBuilder: (BuildContext context,int index){
          return  TeachingContainer(list[index],widget.courseType,widget.tabId, widget.tabName);
        });
  }
}
