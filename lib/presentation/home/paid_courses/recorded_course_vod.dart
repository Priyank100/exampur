import 'package:flutter/material.dart';

import '../../../data/model/paid_course_model_new.dart';
import '../../../provider/PaidCourseProvider.dart';
import '../../../shared/teaching_container.dart';
import '../../../utils/analytics_constants.dart';
import '../../../utils/appBar.dart';
import '../../../utils/app_constants.dart';
import '../../widgets/loading_indicator.dart';
import 'package:provider/provider.dart';

class RecordedCourseVod extends StatefulWidget {
  const RecordedCourseVod({Key? key}) : super(key: key);

  @override
  State<RecordedCourseVod> createState() => _RecordedCourseVodState();
}

class _RecordedCourseVodState extends State<RecordedCourseVod> {
  List<PaidCourseData> paidCourseList = [];
  var scrollController = ScrollController();
  bool isLoading = false;
  int isLoad = 0;

  int page = 0;
  bool isData = true;
  String vodTabId = '';
  String vodName = '';
  void initState() {
    var map = {
      'Page_Name':'Course_List',
      'Mobile_Number':AppConstants.userMobile,
      'Language':AppConstants.langCode,
      'Course_Category':AppConstants.selectedCategoryNameList.toString(),
      'User_ID':AppConstants.userMobile
    };
    //AnalyticsConstants.trackEventMoEngage(AnalyticsConstants.Course_List,map);
    scrollController.addListener(pagination);
    isLoad = 0;
    getLists(page);}

  Future<void> getLists(pageNo) async {
    await Provider.of<PaidCoursesProvider>(context, listen: false).getPaidCourseTabList(context).then((tabList) async {

      for(var i=0;i<tabList!.length;i++){
        if(tabList[i].name!.toLowerCase().contains('recorded')){
          vodTabId = tabList[i].id.toString();
          vodName = tabList[i].name.toString();
        }
      }
      List<PaidCourseData> list = (await Provider.of<PaidCoursesProvider>(context, listen: false).getPaidCourseList(context, vodTabId, pageNo))!;
      if(list.length > 0) {
        isData = true;
        paidCourseList = paidCourseList + list;
      } else {
        isData = false;
      }
      isLoading = false;
      isLoad++;
      setState(() {});
    });

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
        appBar: CustomAppBar(),
        body:   isLoad==0 ? Center(child: LoadingIndicator(context)) :
        paidCourseList.length==0 ? AppConstants.noDataFound() : listing(paidCourseList)
    );
  }
  Widget listing(list) {
    return ListView.builder(itemCount:list.length,controller: scrollController,
        itemBuilder: (BuildContext context,int index){
          return  TeachingContainer(list[index],3,vodTabId, vodName);
        });
  }
}