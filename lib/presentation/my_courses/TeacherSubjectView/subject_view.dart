import 'package:exampur_mobile/Localization/language_constrants.dart';
import 'package:exampur_mobile/SharePref/shared_pref.dart';
import 'package:exampur_mobile/data/model/my_course_subject_model.dart';
import 'package:exampur_mobile/presentation/my_courses/TeacherSubjectView/chapter_view.dart';
import 'package:exampur_mobile/presentation/widgets/loading_indicator.dart';
import 'package:exampur_mobile/provider/MyCourseProvider.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:exampur_mobile/utils/refreshwidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SubjectView extends StatefulWidget {
  final String courseId;

  const SubjectView(this.courseId) : super();

  @override
  _SubjectViewState createState() => _SubjectViewState();
}

class _SubjectViewState extends State<SubjectView> {
  List<SubjectData> subjectList = [];
  bool isLoading = false;
  final keyRefresh = GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    callProvider();
    super.initState();
  }

  Future<void> callProvider() async {
    isLoading = true;
    String token = await SharedPref.getSharedPref(SharedPrefConstants.TOKEN);
    subjectList = (await Provider.of<MyCourseProvider>(context, listen: false).getSubjectList(context, widget.courseId,))!;
    isLoading = false;
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
              child: Text(getTranslated(context, StringConstant.selectSubject)!,style: TextStyle(fontSize: 25)),
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
        Navigator.push(context, MaterialPageRoute(builder: (_) =>
            ChapterView(widget.courseId, subjectList[index].id.toString())
        ));
      },
      child: Column(
        children: [
          ClipOval(
            child: subjectList[index].logoPath.toString().contains('http') ?
            AppConstants.image(subjectList[index].logoPath.toString(), width: 80.0,height: 80.0,boxfit: BoxFit.fill) :
            AppConstants.image(AppConstants.BANNER_BASE + subjectList[index].logoPath.toString(), width: 80.0,height: 80.0,boxfit: BoxFit.fill),
          ),
          Text(subjectList[index].title.toString(), overflow: TextOverflow.ellipsis, maxLines: 2,style: TextStyle(fontSize: 10),textAlign: TextAlign.center,),
        ],
      ),
    );
  }
}
