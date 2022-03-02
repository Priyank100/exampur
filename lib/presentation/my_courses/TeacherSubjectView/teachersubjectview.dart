import 'package:exampur_mobile/Localization/language_constrants.dart';
import 'package:exampur_mobile/SharePref/shared_pref.dart';
import 'package:exampur_mobile/data/model/my_course_material_model.dart';
import 'package:exampur_mobile/presentation/my_courses/TeacherSubjectView/selectchapterview.dart';
import 'package:exampur_mobile/presentation/theme/custom_text_style.dart';
import 'package:exampur_mobile/provider/MyCourseProvider.dart';
import 'package:exampur_mobile/utils/appBar.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:exampur_mobile/utils/images.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TeacherSubjectView extends StatefulWidget {
  final String courseId;
  final String subjectId;
  const TeacherSubjectView(this.courseId, this.subjectId) : super();

  @override
  _TeacherSubjectViewState createState() => _TeacherSubjectViewState();
}

class _TeacherSubjectViewState extends State<TeacherSubjectView> {
  List<MaterialData> materialList = [];
  bool isLoading = false;

  @override
  void initState() {
    callProvider();
    super.initState();
  }

  Future<void> callProvider() async {
    isLoading = true;
    String token = await SharedPref.getSharedPref(SharedPrefConstants.TOKEN);
    materialList = (await Provider.of<MyCourseProvider>(context, listen: false).getMaterialList(context, widget.subjectId, widget.courseId, token))!;
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: isLoading ? Center(child: CircularProgressIndicator()) : materialList.length == 0 ?
      AppConstants.noDataFound() :
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(getTranslated(context, StringConstant.selectChapter)!, style: TextStyle(fontSize: 25)),
            ),
            ListView.builder(itemCount: materialList.length,
                shrinkWrap: true,
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
                                    builder: (context) =>SelectChapterView(materialList[index])));
                          },
                          leading: Image.asset(Images.exampur_logo,height: 40,width: 60,),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(materialList[index].title.toString(),style:CustomTextStyle.drawerText(context),),
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
    );
  }
}
