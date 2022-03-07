import 'package:cached_network_image/cached_network_image.dart';
import 'package:exampur_mobile/Localization/language_constrants.dart';
import 'package:exampur_mobile/SharePref/shared_pref.dart';
import 'package:exampur_mobile/data/model/my_course_subject_model.dart';
import 'package:exampur_mobile/presentation/my_courses/TeacherSubjectView/teachersubjectview.dart';
import 'package:exampur_mobile/provider/MyCourseProvider.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
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

  @override
  void initState() {
    callProvider();
    super.initState();
  }

  Future<void> callProvider() async {
    isLoading = true;
    String token = await SharedPref.getSharedPref(SharedPrefConstants.TOKEN);
    subjectList = (await Provider.of<MyCourseProvider>(context, listen: false).getSubjectList(context, widget.courseId, token))!;
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading ? Center(child: CircularProgressIndicator(color: AppColors.amber,)) : subjectList.length == 0 ?
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
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
              itemBuilder: (_, index) => GridItem(index),
              itemCount: subjectList.length,
            )
        ]),
      ),
    );
  }

  Widget GridItem(index) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) =>
            TeacherSubjectView(widget.courseId, subjectList[index].id.toString())
        ));
      },
      child: Column(
        children: [
          ClipOval(
            child: AppConstants.image(
              AppConstants.BANNER_BASE + subjectList[index].logoPath.toString(),
              width: 80.0,height: 80.0,boxfit: BoxFit.fill
            ),
          ),
          Text(subjectList[index].title.toString(), overflow: TextOverflow.ellipsis, maxLines: 1),
        ],
      ),
    );
  }
}
