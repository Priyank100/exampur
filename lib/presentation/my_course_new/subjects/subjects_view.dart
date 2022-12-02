import 'package:exampur_mobile/Localization/language_constrants.dart';
import 'package:exampur_mobile/data/model/my_course_subject_model.dart';
import 'package:exampur_mobile/presentation/my_course_new/subjects/chapters_view.dart';
import 'package:exampur_mobile/presentation/widgets/custom_bottomsheet.dart';
import 'package:exampur_mobile/presentation/widgets/loading_indicator.dart';
import 'package:exampur_mobile/provider/new_my_course_provider.dart';
import 'package:exampur_mobile/utils/analytics_constants.dart';
import 'package:exampur_mobile/utils/app_colors.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:exampur_mobile/utils/images.dart';
import 'package:exampur_mobile/utils/lang_string.dart';
import 'package:exampur_mobile/utils/refreshwidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/delivery_detail_screen_param.dart';

class SubjectsView extends StatefulWidget {
  final String courseId;
  const SubjectsView(this.courseId) : super();

  @override
  State<SubjectsView> createState() => _SubjectsViewState();
}

class _SubjectsViewState extends State<SubjectsView> {
  List<SubjectData> subjectList = [];
  bool isLoading = false;
  final keyRefresh = GlobalKey<RefreshIndicatorState>();
  // int unlockValue = 0;

  @override
  void initState() {
    var map = {
      'Page_Name':'My_Courses_Subjects',
      'Mobile_Number':AppConstants.userMobile,
      'Language':AppConstants.langCode,
      'User_ID':AppConstants.userMobile,
      'Course_Name': AppConstants.courseName,
      'Course_Type':'Demo'
    };
    AnalyticsConstants.trackEventMoEngage(AnalyticsConstants.My_Courses_Subjects,map);
    callProvider();
    super.initState();
  }

  Future<void> callProvider() async {
    isLoading = true;
    subjectList = (await Provider.of<NewMyCourseProvider>(context, listen: false).getSubjectList(context, widget.courseId))!;
    isLoading = false;
    // subjectList.length == 0 ? unlockValue = 0 : unlockValue = AppConstants.unlockItem(subjectList.length);
    setState(() {});
  }
  Future<void>_refreshScreen() async{
    subjectList.clear();
    return callProvider();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:RefreshWidget(
          keyRefresh: keyRefresh,
          onRefresh:_refreshScreen,
          child: isLoading ? Center(child: LoadingIndicator(context)) : subjectList.length == 0 ?
          AppConstants.noDataFound() :
          SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(getTranslated(context, LangString.selectSubject)!,style: TextStyle(fontSize: 25)),
                  ),
                  GridView.builder(
                    padding: EdgeInsets.all(8),
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                    itemBuilder: (_, index) => GridItem(index),
                    itemCount: subjectList.length,
                  )
                ]),
          ),
        ));
  }

  Widget GridItem(index) {
    return InkWell(
      onTap: () {
        var analytics = {
          'Page_Name': 'My_Courses_Subjects',
          'Course_Category': AppConstants.paidTabName,
          'Course_Name': SamplingBottomSheetParam.getDeliveryDetailParam['title'].toString(),
          'Mobile_Number': AppConstants.userMobile,
          'Language': AppConstants.langCode,
          'User_ID': AppConstants.userMobile,
          'Course_Type':'Demo',
          // 'Locked':index < unlockValue ? 'Flase' : 'True',
          'Locked':'Flase',
          'Subject_Name':subjectList[index].title.toString(),
        };
        AnalyticsConstants.trackEventMoEngage(AnalyticsConstants.Click_Subject, analytics);
        // if(index < unlockValue) {
          AppConstants.subjectName = subjectList[index].title.toString();
          Navigator.push(context, MaterialPageRoute(builder: (_) =>
              ChaptersView(widget.courseId, subjectList[index].id.toString())
          ));
        // } else {
        //   ModalBottomSheet.moreModalBottomSheet(context,'Subject_View');
        // }
      },
      child: Column(
        children: [
          ClipOval(
            child: Stack(
              children: [
                subjectList[index].logoPath.toString().contains('http') ?
                AppConstants.image(subjectList[index].logoPath.toString(), width: 80.0,height: 80.0,boxfit: BoxFit.fill) :
                AppConstants.image(AppConstants.BANNER_BASE + subjectList[index].logoPath.toString(), width: 80.0,height: 80.0,boxfit: BoxFit.fill),
                // index+1 > unlockValue ? Opacity(
                //     opacity: 0.6,
                //     child: Container(
                //         width: 80.0,
                //         height: 80.0,
                //         color: AppColors.black,
                //         child: Image.asset(Images.lock, scale: 1.5, color: AppColors.red900)
                //     )
                // ) : SizedBox()
             ])
          ),
          Text(subjectList[index].title.toString(), overflow: TextOverflow.ellipsis, maxLines: 2,style: TextStyle(fontSize: 10),textAlign: TextAlign.center,),
        ],
      ),
    );
  }
}
