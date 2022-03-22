import 'package:exampur_mobile/Localization/language_constrants.dart';
import 'package:exampur_mobile/SharePref/shared_pref.dart';
import 'package:exampur_mobile/data/model/my_course_material_model.dart';
import 'package:exampur_mobile/provider/MyCourseProvider.dart';
import 'package:exampur_mobile/shared/view_pdf.dart';
import 'package:exampur_mobile/shared/youtube_video.dart';
import 'package:exampur_mobile/utils/appBar.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:exampur_mobile/utils/dimensions.dart';
import 'package:exampur_mobile/utils/images.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectChapterView extends StatefulWidget {
  String subjectId;
  String courseId;
  String chaptername;
   SelectChapterView(this.subjectId,this.courseId,this.chaptername) : super();

  @override
  State<SelectChapterView> createState() => _SelectChapterViewState();
}

class _SelectChapterViewState extends State<SelectChapterView> {
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
    materialList = (await Provider.of<MyCourseProvider>(context, listen: false).getMaterialList(context, widget.subjectId, widget.courseId, widget.chaptername, token))!;
    isLoading = false;
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: ListView.builder(itemCount: materialList.length,
    padding: EdgeInsets.all(5),
    shrinkWrap: true,
    itemBuilder: (BuildContext context,int index){
        return Container(
          margin: EdgeInsets.all(5),
          child: Padding(
            padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
            child: Row(
              children: [
                Container(
                    width: Dimensions.AppTutorialImageWidth,
                    height: Dimensions.AppTutorialImageHeight,
                    child: Image.asset(Images.studymaterial,fit: BoxFit.fill,),
                    ),
                SizedBox(width: 10),

                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(materialList[index].subjectId!.title.toString(),overflow: TextOverflow.ellipsis, maxLines: 2,),
                      SizedBox(height: 25,),
                      Row(
                        children: [
                          materialList[index].timeline!.apexLink!.hlsURL == null ||  materialList[index].timeline!.apexLink!.hlsURL.toString().isEmpty ?SizedBox():    InkWell(
                            onTap: (){
                              Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => YoutubeVideo( materialList[index].timeline!.apexLink!.hlsURL.toString(),
                                                    materialList[index].timeline!.apexLink!.hlsURL.toString())
                                            )
                                        );
                            },
                            child: Container(
                              width: Dimensions.AppTutorialImageHeight,
                                height: 25,
                                decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8),),color:AppColors.dark),
                             child:   Center(child: Text(getTranslated(context, StringConstant.watch)!, style: new TextStyle(fontSize: 10.0, color: AppColors.white)))
                            ),
                          ),
                          SizedBox(width: 5),
             materialList[index].pdfPath == null || materialList[index].pdfPath.toString().isEmpty ?  SizedBox() :   InkWell(
                onTap: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ViewPdf(AppConstants.BANNER_BASE + materialList[index].pdfPath.toString(),'')
                      )
                  );
                },
                child: Container(
                              height: 25,
                  width: Dimensions.AppTutorialImageHeight,
                              decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8),),color:Color(0xFF1c1d3b)),
                              child:  Center(child: Text(getTranslated(context, StringConstant.viewPdf)!, style: new TextStyle(fontSize: 10.0, color: AppColors.white))),


                            ),
              ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
