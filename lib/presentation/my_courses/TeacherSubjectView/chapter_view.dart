import 'package:exampur_mobile/Localization/language_constrants.dart';
import 'package:exampur_mobile/SharePref/shared_pref.dart';
import 'package:exampur_mobile/data/model/teacher_chapter_model.dart';
import 'package:exampur_mobile/presentation/my_courses/TeacherSubjectView/chapter_detail_view.dart';
import 'package:exampur_mobile/presentation/theme/custom_text_style.dart';
import 'package:exampur_mobile/presentation/widgets/loading_indicator.dart';
import 'package:exampur_mobile/provider/MyCourseProvider.dart';
import 'package:exampur_mobile/utils/appBar.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:exampur_mobile/utils/app_colors.dart';
import 'package:exampur_mobile/utils/images.dart';
import 'package:exampur_mobile/utils/lang_string.dart';
import 'package:exampur_mobile/utils/refreshwidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChapterView extends StatefulWidget {
  final String courseId;
  final String subjectId;
  const ChapterView(this.courseId, this.subjectId) : super();

  @override
  _ChapterViewState createState() => _ChapterViewState();
}

class _ChapterViewState extends State<ChapterView> {
  List<String> chapterList = [];
  bool isLoading = false;
  final keyRefresh = GlobalKey<RefreshIndicatorState>();
  @override
  void initState() {
    callProvider();
    super.initState();
  }

  Future<void> callProvider() async {
    isLoading = true;
    chapterList = (await Provider.of<MyCourseProvider>(context, listen: false).getChapterList(context, widget.subjectId, widget.courseId))!;
    isLoading = false;
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
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            boxShadow:const [
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
                          child:ListTile(
                              contentPadding: EdgeInsets.all(8),
                              onTap: (){
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>ChapterDetailView(widget.subjectId,widget.courseId,chapterList[index].toString())));
                              },
                              leading: Image.asset(Images.exampur_logo,height: 40,width: 60,),
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(chapterList[index].toString(),style:CustomTextStyle.drawerText(context),),
                                  ],
                              ),
                              trailing: Icon(Icons.arrow_forward_ios_sharp,size: 18,color: AppColors.black,)
                          ),
                        ),
                      );
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
