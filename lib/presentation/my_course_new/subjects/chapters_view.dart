import 'package:exampur_mobile/Localization/language_constrants.dart';
import 'package:exampur_mobile/presentation/my_course_new/subjects/topics_view.dart';
import 'package:exampur_mobile/presentation/theme/custom_text_style.dart';
import 'package:exampur_mobile/presentation/widgets/custom_bottomsheet.dart';
import 'package:exampur_mobile/presentation/widgets/loading_indicator.dart';
import 'package:exampur_mobile/provider/new_my_course_provider.dart';
import 'package:exampur_mobile/utils/appBar.dart';
import 'package:exampur_mobile/utils/app_colors.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:exampur_mobile/utils/images.dart';
import 'package:exampur_mobile/utils/lang_string.dart';
import 'package:exampur_mobile/utils/refreshwidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/analytics_constants.dart';
import '../../../utils/delivery_detail_screen_param.dart';

class ChaptersView extends StatefulWidget {
  final String courseId;
  final String subjectId;
  const ChaptersView(this.courseId, this.subjectId) : super();

  @override
  State<ChaptersView> createState() => _ChaptersViewState();
}

class _ChaptersViewState extends State<ChaptersView> {
  List<String> chapterList = [];
  bool isLoading = false;
  final keyRefresh = GlobalKey<RefreshIndicatorState>();
  int unlockValue = 0;

  @override
  void initState() {
    callProvider();
    super.initState();
  }

  Future<void> callProvider() async {
    isLoading = true;
    chapterList = (await Provider.of<NewMyCourseProvider>(context, listen: false).getChapterList(context, widget.subjectId, widget.courseId))!;
    isLoading = false;
    chapterList.length == 0 ? unlockValue = 0 : unlockValue = AppConstants.unlockItem(chapterList.length);
    setState(() {});
  }
  Future<void>_refreshScreen() async{
    chapterList.clear();
    return callProvider();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: isLoading ? Center(child: LoadingIndicator(context)) : chapterList.length == 0 ?
      AppConstants.noDataFound() :
      RefreshWidget(
        keyRefresh: keyRefresh,
        onRefresh:_refreshScreen,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(getTranslated(context, LangString.selectChapter)!, style: TextStyle(fontSize: 25)),
                ),
                ListView.builder(itemCount: chapterList.length,
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (BuildContext context,int index){
                      return listItem(index);
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget listItem(index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          boxShadow: const [
            BoxShadow(
              color: AppColors.grey,
              offset:  Offset(
                0.0,
                0.0,
              ),
              blurRadius: 0.95,
              spreadRadius: 0.0,
            ),
          ],
          color: Theme.of(context).backgroundColor,
        ),
        child: Stack(
          children: [
            listTileChapter(index),
            index+1 > unlockValue ? InkWell(
              onTap: () {
                var analytics = {
                  'Page_Name': 'My_Courses_Chapter',
                  'Course_Category': AppConstants.paidTabName,
                  'Course_Name': SamplingBottomSheetParam.getDeliveryDetailParam['title'].toString(),
                  'Mobile_Number': AppConstants.userMobile,
                  'Language': AppConstants.langCode,
                  'User_ID': AppConstants.userMobile,
                  'Course_Type':'Demo',
                  'Locked':'True',
                  'Subject_Name':AppConstants.subjectName,
                };
                AnalyticsConstants.trackEventMoEngage(AnalyticsConstants.Click_Chapter, analytics);
               ModalBottomSheet.moreModalBottomSheet(context,'Chapter_View',);
              },
              child: Opacity(
                  opacity: 0.6,
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 75,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.black,
                            offset:  Offset(
                              0.0,
                              0.0,
                            ),
                            blurRadius: 0.95,
                            spreadRadius: 0.0,
                          ),
                        ],
                        color: AppColors.black,
                      ),
                      child: Image.asset(Images.lock, scale: 1.5, color: AppColors.red900)
                  )
              ),
            ) : SizedBox()
          ],
        )
      ),
    );
  }

  Widget listTileChapter(index) {
    return ListTile(
        contentPadding: EdgeInsets.all(8),
        onTap: (){
          var analytics = {
            'Page_Name': 'My_Courses_Chapter',
            'Course_Category': AppConstants.paidTabName,
            'Course_Name': SamplingBottomSheetParam.getDeliveryDetailParam['title'].toString(),
            'Mobile_Number': AppConstants.userMobile,
            'Language': AppConstants.langCode,
            'User_ID': AppConstants.userMobile,
            'Course_Type':'Demo',
            'Locked':'False',
            'Subject_Name':AppConstants.subjectName,
          };
          AnalyticsConstants.trackEventMoEngage(AnalyticsConstants.Click_Chapter, analytics);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        TopicsView(widget.subjectId, widget.courseId, chapterList[index].toString())
                )
            );
        },
        leading: Image.asset(Images.exampur_logo,height: 40,width: 60,),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(chapterList[index].toString(),style:CustomTextStyle.drawerText(context),),
          ],
        ),
        trailing: Icon(Icons.arrow_forward_ios_sharp,size: 18,color: AppColors.black,)
    );
  }
}
