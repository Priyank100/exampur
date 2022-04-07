import 'package:exampur_mobile/Localization/language_constrants.dart';
import 'package:exampur_mobile/SharePref/shared_pref.dart';
import 'package:exampur_mobile/data/model/my_course_material_model.dart';
import 'package:exampur_mobile/presentation/my_courses/TeacherSubjectView/videomaterial.dart';
import 'package:exampur_mobile/presentation/my_courses/TimeTable/TimeTableVideo.dart';
import 'package:exampur_mobile/presentation/my_courses/TimeTable/TimetableView.dart';
import 'package:exampur_mobile/presentation/widgets/custom_button_amber_color_watch.dart';
import 'package:exampur_mobile/presentation/widgets/custom_round_button.dart';
import 'package:exampur_mobile/presentation/widgets/loading_indicator.dart';
import 'package:exampur_mobile/provider/MyCourseProvider.dart';
import 'package:exampur_mobile/shared/view_pdf.dart';
import 'package:exampur_mobile/shared/youtube_video.dart';
import 'package:exampur_mobile/utils/appBar.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:exampur_mobile/utils/dimensions.dart';
import 'package:exampur_mobile/utils/images.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'DownloadPdfView.dart';
import 'apexvideo.dart';

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
    materialList = (await Provider.of<MyCourseProvider>(context, listen: false).getMaterialList(context, widget.subjectId, widget.courseId, widget.chaptername))!;
    isLoading = false;
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body:materialList.length==0?LoadingIndicator(context): ListView.builder(itemCount: materialList.length,
    padding: EdgeInsets.all(5),
    shrinkWrap: true,
    itemBuilder: (BuildContext context,int index){
        return Container(
          margin: EdgeInsets.all(5),
          child: Padding(
            padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
            child: Row(
              children: [
                // Container(
                //     width: Dimensions.AppTutorialImageWidth,
                //     height: Dimensions.AppTutorialImageHeight,
                //     child:Image.network(AppConstants.BANNER_BASE+materialList[index].timeline!.logoPath.toString(),fit: BoxFit.fill,),
                //     ),
                 Container(
                  width: Dimensions.WatchButtonWidth,
                  height: Dimensions.AppTutorialImageHeight,
                  child:Image.asset(Images.exampur_logo,fit: BoxFit.fill,)),
                // ):  Container(
                //     width: Dimensions.WatchButtonWidth,
                //     height: Dimensions.AppTutorialImageHeight,
                //     child:Image.network(AppConstants.BANNER_BASE+materialList[index].timeline!.logoPath.toString(),fit: BoxFit.fill,),
                //     ),
                SizedBox(width: 10),

                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(materialList[index].subjectId!.title.toString(),overflow: TextOverflow.ellipsis, maxLines: 2,),
                      Text(materialList[index].title.toString(),style: TextStyle(fontSize: 12),),
                      SizedBox(height: 5,),
                      Row(
                        children: [
                      materialList[index].videoLink==''?CustomAmberButton(text:getTranslated(context, StringConstant.watch)!, onPressed: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>YoutubeVideo(materialList[index].videoLink.toString(), materialList[index].title.toString())
                            )
                        );
                       // YoutubeVideo(materialList[index].videoLink.toString(), materialList[index].title.toString())
                      }):
                      CustomAmberButton(onPressed: (){
                            AlertDialog alert = AlertDialog(
                            titlePadding: EdgeInsets.only(top: 0, ),
                            contentPadding: EdgeInsets.only(top: 0, ),
                            //insetPadding: EdgeInsets.symmetric(horizontal: 1),
                            // title: const Text('Popup example'),
                            content:
                            materialList[index].timeline!.recordingProps == null ?
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  //crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(color: AppColors.amber,height: 30,width: MediaQuery.of(context).size.width,
                                      alignment: Alignment.topRight,
                                      child: InkWell(onTap:(){

                                        Navigator.pop(context);
                                      },child:  Icon(Icons.close,color: AppColors.white,),
                                      ),
                                    ),
                                    SizedBox(height: 10,),
                                    CustomButton(navigateTo:MyApexVideoMaterial(materialList[index].timeline!.apexLink!.hlsUrl.toString(),materialList[index].title.toString()) ,title: getTranslated(context, StringConstant.Normal),),
                                    SizedBox(height: 10,),
                                    CustomButton(navigateTo: MyApexVideoMaterial(materialList[index].timeline!.apexLink!.hls240PUrl.toString(),materialList[index].title.toString()),title: '240p',),
                                    SizedBox(height: 10,),
                                    CustomButton(navigateTo:MyApexVideoMaterial(materialList[index].timeline!.apexLink!.hls360PUrl.toString(),materialList[index].title.toString()),title: '360p',),
                                    SizedBox(height: 10,),
                                    CustomButton(navigateTo:MyApexVideoMaterial(materialList[index].timeline!.apexLink!.hls480PUrl.toString(),materialList[index].title.toString() ),title: '480p',),
                                    SizedBox(height: 10,),
                                    CustomButton(navigateTo: MyApexVideoMaterial(materialList[index].timeline!.apexLink!.hls720PUrl.toString(),materialList[index].title.toString()),title: '720p',),
                                    SizedBox(height: 10,),
                                  ],
                                ) :
                            Column(

                              mainAxisSize: MainAxisSize.min,
                              //crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(color: AppColors.amber,height: 30,width: MediaQuery.of(context).size.width,
                                  alignment: Alignment.topRight,
                                  child: InkWell(onTap:(){

                                    Navigator.pop(context);
                                  },child:  Icon(Icons.close,color: AppColors.white,),
                                  ),
                                ),
                                SizedBox(height: 10,),
                                CustomButton(navigateTo:MyMaterialViedo(materialList[index].timeline!.apexLink!.hlsUrl.toString(),materialList[index].title.toString(),materialList[index].timeline!.recordingProps!.the240.toString(),materialList[index].timeline!.recordingProps!.thumbnail.toString()) ,title: getTranslated(context, StringConstant.Normal),),
                                SizedBox(height: 10,),
                                CustomButton(navigateTo: MyMaterialViedo(materialList[index].timeline!.apexLink!.hls240PUrl.toString(),materialList[index].title.toString(),materialList[index].timeline!.recordingProps!.the240.toString(),materialList[index].timeline!.recordingProps!.thumbnail.toString()),title: '240p',),
                                SizedBox(height: 10,),
                                CustomButton(navigateTo:MyMaterialViedo(materialList[index].timeline!.apexLink!.hls360PUrl.toString(),materialList[index].title.toString(),materialList[index].timeline!.recordingProps!.the360.toString() ,materialList[index].timeline!.recordingProps!.thumbnail.toString()),title: '360p',),
                                SizedBox(height: 10,),
                                CustomButton(navigateTo:MyMaterialViedo(materialList[index].timeline!.apexLink!.hls480PUrl.toString(),materialList[index].title.toString(),materialList[index].timeline!.recordingProps!.the576.toString(),materialList[index].timeline!.recordingProps!.thumbnail.toString() ),title: '480p',),
                                SizedBox(height: 10,),
                                CustomButton(navigateTo: MyMaterialViedo(materialList[index].timeline!.apexLink!.hls720PUrl.toString(),materialList[index].title.toString(),materialList[index].timeline!.recordingProps!.the240.toString(),materialList[index].timeline!.recordingProps!.thumbnail.toString()),title: '720p',),
                                SizedBox(height: 10,),

                              ],
                            ),
                          );
                          showDialog(barrierDismissible: true,
                            context: context,
                            builder: (BuildContext context) {
                              return alert;
                            },
                          );},text: getTranslated(context, StringConstant.watch)!,),

                          SizedBox(width: 5),
                          materialList[index].pdfPath==null?SizedBox():  InkWell(
                           onTap: (){
                               Navigator.push(
                                   context,
                                   MaterialPageRoute(
                                       builder: (context) => DownloadViewPdf(AppConstants.BANNER_BASE + materialList[index].pdfPath.toString(),materialList[index].title.toString(),'')
                                   )
                               );
                           },
                           child: Container(height: 30,width:MediaQuery.of(context).size.width/4.10,decoration: BoxDecoration( color: Color(0xFF060929),
      borderRadius: BorderRadius.all(Radius.circular(8))),child: Center(child: Text(getTranslated(context, StringConstant.viewPdf)!,style: TextStyle(color: Colors.white,fontSize: 11)))),
                         )
                         // materialList[index].pdfPath==null?SizedBox():
                          // CustomRoundButton(onPressed: (){
                          //   Navigator.push(
                          //       context,
                          //       MaterialPageRoute(
                          //           builder: (context) => DownloadViewPdf(AppConstants.BANNER_BASE + materialList[index].pdfPath.toString(),materialList[index].title.toString(),'')
                          //       )
                          //   );
                          // },text:getTranslated(context, StringConstant.viewPdf)! ,)

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
