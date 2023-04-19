import 'package:exampur_mobile/presentation/home/paid_courses/paid_courses.dart';
import 'package:exampur_mobile/utils/appBar.dart';
import 'package:flutter/material.dart';

import '../../../Localization/language_constrants.dart';
import '../../../data/model/my_course_material_model.dart';
import '../../../provider/MyCourseProvider.dart';
import 'package:provider/provider.dart';

import '../../../utils/analytics_constants.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/dimensions.dart';
import '../../../utils/images.dart';
import '../../../utils/lang_string.dart';
import '../../my_course_new/timeline/timeline_view.dart';
import '../../my_courses/TeacherSubjectView/DownloadPdfView.dart';
import '../../my_courses/TeacherSubjectView/material_video.dart';

class FreeCourseDetail extends StatefulWidget {
  final String id;
  final String token;
  final String tabId;

  const FreeCourseDetail(this.id, this.token,this.tabId, {Key? key}) : super(key: key);

  @override
  State<FreeCourseDetail> createState() => _FreeCourseDetailState();
}

class _FreeCourseDetailState extends State<FreeCourseDetail> {
  List<MaterialData> mainList = [];
  String noVideoLink = 'https://cdn.exampur.xyz/No+video+available+here.+This+is+a+Special+PDF.+Please+clink+on+View+PDF+to+access+the+material.mp4';
  bool isLoading = false;
  String contentCourseId = '';
  bool isTimlineRequired = false;
  String subjectId ='';
  String subjectName ='';

  Future<void> callProvider() async {
      isLoading = true;
    await Provider.of<MyCourseProvider>(context, listen: false).getSubjectList(
      context, widget.id,).then((subjectList) async {
           subjectId =subjectList![0].id.toString();
           subjectName = subjectList![0].title.toString();
      await Provider.of<MyCourseProvider>(context, listen: false).getChapterList(
          context, subjectList![0].id.toString(), widget.id).then((chapterList) async {
            mainList =
              (await Provider.of<MyCourseProvider>(context, listen: false)
                  .getMaterialList(context, subjectList[0].id.toString(), widget.id,
                  chapterList![0].toString()
              ))!;
            isLoading = false;
            setState(() {});
          }
      );
      }
      );
    //   isLoading = false;

  }

  void getContentLogCourseId(){
    AppConstants.contentLogList.forEach((data) {
      if (widget.id == data) {
        contentCourseId = data;
        isTimlineRequired = true;
        // print('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>.');
        //   print(contentCourseId);
      }
    });

  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    callProvider();
    getContentLogCourseId();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body:isLoading ?Center(child: CircularProgressIndicator(color: Colors.amber,),) :ListView.builder(
        itemCount: mainList.length,
          itemBuilder: (context, i){
        return Container(
          margin: EdgeInsets.all(5),
          padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
          child: Row(
            children: [
              chapterImage(mainList, i),
              SizedBox(width: 10),
              chapterData(mainList, i)
            ],
          ),
        );

      }),
      bottomNavigationBar: InkWell(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(
                builder: (context) =>
                    PaidCourses(1, categoryId:widget.tabId )
            ));
          },
          child:
          Container(
            width: MediaQuery.of(context).size.width,
            height: 50,
            padding: EdgeInsets.all(15),
            margin: EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.all(Radius.circular(50))
            ),
            alignment: Alignment.center,
            child: Text('Explore Live Courses',style: TextStyle(color: Colors.white),),
          )),
    );
  }
  Widget chapterImage(List<MaterialData> materialList, index) {
    return Container(
      width: Dimensions.WatchButtonWidth,
      height: Dimensions.AppTutorialImageHeight,
      child: materialList[index].videoLink == null || materialList[index].videoLink.toString().isEmpty ?
      materialList[index].timeline == null || materialList[index].timeline!.apexLink == null ?

      Image.asset(Images.pdfIcon):

      AppConstants.image(
          materialList[index].timeline != null &&
              materialList[index].timeline!.logoPath != null &&
              materialList[index].timeline!.logoPath.toString().isNotEmpty ?

          materialList[index].timeline!.logoPath.toString().contains('http') ?
          materialList[index].timeline!.logoPath.toString() : AppConstants.BANNER_BASE + materialList[index].timeline!.logoPath.toString()

              : 'error', boxfit: BoxFit.fill) : AppConstants.image(
          materialList[index].timeline != null &&
              materialList[index].timeline!.logoPath != null &&
              materialList[index].timeline!.logoPath.toString().isNotEmpty ?

          materialList[index].timeline!.logoPath.toString().contains('http') ?
          materialList[index].timeline!.logoPath.toString() : AppConstants.BANNER_BASE + materialList[index].timeline!.logoPath.toString()

              : 'error', boxfit: BoxFit.fill)
      ,
    );
  }

  Widget chapterData(List<MaterialData> materialList, index) {
    return Flexible(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(materialList[index].title.toString().replaceAll('--', ''), style: TextStyle(fontSize: 12)),
          // Text(materialList[index].subjectId!.title.toString(),overflow: TextOverflow.ellipsis, maxLines: 2,),
          SizedBox(height: 5),

          Row(
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              materialList[index].videoLink == null || materialList[index].videoLink.toString().isEmpty || materialList[index].videoLink == noVideoLink ?
              materialList[index].timeline == null || materialList[index].timeline!.apexLink == null ?
              SizedBox() : WatchVideoButton(materialList, index) : WatchVideoButton(materialList, index),

              SizedBox(width: 5),
              materialList[index].pdfPath == null || materialList[index].pdfPath.toString().isEmpty ?
              SizedBox() : PdfButton(materialList, index),
              SizedBox(width: 5),
              materialList[index].docpath == null || materialList[index].docpath.toString().isEmpty ?
              SizedBox() :   InkWell(onTap: () {
                String docPath = '';
                materialList[index].docpath.toString().contains('http') ?
                docPath = materialList[index].docpath.toString() :
                docPath = AppConstants.BANNER_BASE + materialList[index].docpath.toString();
                showPdfDialog(docPath, materialList[index].title.toString(),materialList[index].id.toString());
                // String pdfPath = AppConstants.BANNER_BASE +  materialList[index].docpath.toString();
                //   Navigator.push(context, MaterialPageRoute(builder: (context) => DownloadViewPdf('', pdfPath)));

              },
                child: Container(height: 30,width: MediaQuery.of(context).size.width / 6,decoration: BoxDecoration( color: AppColors.dark,
                    borderRadius: BorderRadius.all(Radius.circular(8))),child: Center(child: Text(getTranslated(context, LangString.pdf)!,style: TextStyle(color: Colors.white,fontSize: 11)))),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget WatchVideoButton(List<MaterialData> materialList, index) {
    return InkWell(
      onTap: () {
        var map = {
          'Page_Name':'My_Courses_Recorded',
          'Mobile_Number':AppConstants.userMobile,
          'Language':AppConstants.langCode,
          'User_ID':AppConstants.userMobile,
          'Course_Name':AppConstants.courseName,
          'Faculty_Name':AppConstants.subjectName,
          'Subject_Name':AppConstants.subjectName,
          // 'Chapter_Name':widget.chaptername,
          'Topic_Name':materialList[index].title.toString(),
          'Course_Type':AppConstants.mycourseType == 0 ? 'Paid_Course' : 'Free_Course'
        };
        AnalyticsConstants.trackEventMoEngage(AnalyticsConstants.Click_Watch_Now,map);
       // AppConstants.chapterName =widget.chaptername;
        AppConstants.subjectId = subjectId;
        AppConstants.subjectName = subjectName;
        AppConstants.timlineId = materialList[index].timeline == null ? '' : materialList[index].timeline!.id == null ? '' : materialList[index].timeline!.id.toString() ;
        AppConstants.timlineName = materialList[index].timeline == null ? '' : materialList[index].timeline!.title == null ? '' : materialList[index].timeline!.title.toString() ;
       materialList[index].timeline == null || materialList[index].timeline!.apexLink == null ?
        Navigator.push(context, MaterialPageRoute(builder: (context) =>
            MyMaterialVideo(materialList[index].videoLink.toString(), materialList[index].title.toString(), '',materialList[index].id.toString(),isTimlineRequired,videoQuallity: 'normal',tabId: widget.tabId,))
        ) :
       showVideoQualityDialog(materialList, index);

      },
      child: Container(
          height: 30,
          width: MediaQuery.of(context).size.width / 6,
          decoration: BoxDecoration(color: AppColors.amber, borderRadius: BorderRadius.all(Radius.circular(8))),
          child: Center(
              child: Text(
                  getTranslated(context, LangString.watch)!,
                  style: TextStyle(color: Colors.white, fontSize: 11)
              )
          )
      ),
    );
  }

  Widget PdfButton(List<MaterialData> materialList, index) {
    return materialList[index].pdfPath == null || materialList[index].pdfPath!.isEmpty
        ? SizedBox()
        : InkWell(
      onTap: () {
        String pdfPath = '';
        materialList[index].pdfPath.toString().contains('http') ?
        pdfPath = materialList[index].pdfPath.toString() :
        pdfPath = AppConstants.BANNER_BASE + materialList[index].pdfPath.toString();
        showPdfDialog(pdfPath, materialList[index].title.toString(),materialList[index].id.toString());
      },
      child: Container(
          height: 30,
          width: MediaQuery.of(context).size.width / 6,
          decoration: BoxDecoration(color: Color(0xFF060929), borderRadius: BorderRadius.all(Radius.circular(8))),
          child: Center(
              child: Text(
                  getTranslated(context, LangString.pdf)!,
                  style: TextStyle(color: Colors.white, fontSize: 11)
              )
          )
      ),
    );
  }

  void showPdfDialog(pdfPath, title,timlineId) {
    AlertDialog alert = AlertDialog(
      content: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          alignment: WrapAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(getTranslated(context, LangString.pleaseChoosetoOpenpdf)!),
                SizedBox(height: 10),
                Container(
                  width: MediaQuery.of(context).size.width/2,
                  child: MaterialButton(
                    onPressed: (){
                      var map = {
                        'Page_Name':'My_Courses_Recorded',
                        'Mobile_Number':AppConstants.userMobile,
                        'Language':AppConstants.langCode,
                        'User_ID':AppConstants.userMobile,
                        'Course_Name':AppConstants.courseName,
                        'Faculty_Name':AppConstants.subjectName,
                        'Subject_Name':AppConstants.subjectName,
                       // 'Chapter_Name':widget.chaptername,
                        'Topic_Name':title.toString(),
                        'Course_Type':AppConstants.mycourseType == 0 ? 'Paid_Course' : 'Free_Course'
                      };
                      AnalyticsConstants.trackEventMoEngage(AnalyticsConstants.Click_PDF_Viewer,map);
                      // print('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>');
                      AppConstants.timlineId = timlineId.toString();
                      AppConstants.timlineName = title.toString();
                      AppConstants.printLog('>>>>>>>>>>>>>>>>>>>>>');
                    //  isTimlineRequired == true ? pdfClickLog( timlineId.toString(),title):null;
                      Navigator.pop(context);
                     Navigator.push(context, MaterialPageRoute(builder: (context) => DownloadViewPdf(title, pdfPath,isTimlineRequired:isTimlineRequired)));
                    },
                    color: AppColors.amber,
                    child: Text(getTranslated(context, LangString.pdfViewer)!, style: TextStyle(color: AppColors.white)),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width/2,
                  child: MaterialButton(
                    onPressed: () async {
                      var map = {
                        'Page_Name':'My_Courses_Recorded',
                        'Mobile_Number':AppConstants.userMobile,
                        'Language':AppConstants.langCode,
                        'User_ID':AppConstants.userMobile,
                        'Course_Name':AppConstants.courseName,
                        'Faculty_Name':AppConstants.subjectName,
                        'Subject_Name':AppConstants.subjectName,
                        //'Chapter_Name':widget.chaptername,
                        'Topic_Name':title.toString(),
                        'Course_Type':AppConstants.mycourseType == 0 ? 'Paid_Course' : 'Free_Course'
                      };
                      AnalyticsConstants.trackEventMoEngage(AnalyticsConstants.Click_PDF_Browser,map);
                      Navigator.pop(context);
                      AppConstants.makeCallEmail(pdfPath);
                    },
                    color: AppColors.green,
                    child: Text(getTranslated(context, LangString.browser)!, style: TextStyle(color: AppColors.white)),
                  ),
                ),
              ],
            )
          ]),
    );
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
  void showVideoQualityDialog(List<MaterialData> materialList, index) {
    AlertDialog alert = AlertDialog(
      titlePadding: EdgeInsets.only(top: 0),
      contentPadding: EdgeInsets.only(top: 0),
      content: materialList[index].timeline!.recordingProps == null ?
      QualityListWithoutProps(materialList, index) :
      QualityListWithProps(materialList, index),
    );
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
  Widget QualityListWithoutProps(List<MaterialData> materialList, index) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          color: AppColors.amber,
          height: 30,
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.topRight,
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.close, color: AppColors.white),
          ),
        ),
        SizedBox(height: 10),
        materialList[index].timeline!.apexLink!.hlsUrl == null ? SizedBox() :     CustomButton(
            navigateTo: MyMaterialVideo(materialList[index].timeline!.apexLink!.hlsUrl.toString(), materialList[index].title.toString(),'',materialList[index].id.toString(),isTimlineRequired,videoQuallity: 'normal',tabId: widget.tabId,),
            title: getTranslated(context, LangString.Normal)!
        ),
        SizedBox(height: 10),
        materialList[index].timeline!.apexLink!.hls240PUrl == null ? SizedBox() :   CustomButton(
          navigateTo: MyMaterialVideo(materialList[index].timeline!.apexLink!.hls240PUrl.toString(), materialList[index].title.toString(), '',materialList[index].id.toString(),isTimlineRequired,videoQuallity: '240p',tabId: widget.tabId,),
          title: '240p',
        ),
        SizedBox(height: 10),
        materialList[index].timeline!.apexLink!.hls360PUrl == null ? SizedBox() :     CustomButton(
          navigateTo: MyMaterialVideo(materialList[index].timeline!.apexLink!.hls360PUrl.toString(), materialList[index].title.toString(), '',materialList[index].id.toString(),isTimlineRequired,videoQuallity: '360p',tabId: widget.tabId,),
          title: '360p',
        ),
        SizedBox(height: 10),
        materialList[index].timeline!.apexLink!.hls480PUrl == null ? SizedBox() :  CustomButton(
          navigateTo: MyMaterialVideo(materialList[index].timeline!.apexLink!.hls480PUrl.toString(), materialList[index].title.toString(), '',materialList[index].id.toString(),isTimlineRequired,videoQuallity: '480p',tabId: widget.tabId,),
          title: '480p',
        ),
        SizedBox(height: 10),
        materialList[index].timeline!.apexLink!.hls720PUrl == null ? SizedBox() :  CustomButton(
          navigateTo: MyMaterialVideo(materialList[index].timeline!.apexLink!.hls720PUrl.toString(), materialList[index].title.toString(), '',materialList[index].id.toString(),isTimlineRequired,videoQuallity: '720p',tabId: widget.tabId,),
          title: '720p',
        ),
        SizedBox(height: 10),
      ],
    );
  }
  Widget QualityListWithProps(List<MaterialData> materialList, index) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      //crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(color: AppColors.amber,
          height: 30,
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.topRight,
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.close,
              color: AppColors.white,
            ),
          ),
        ),
        SizedBox(height: 10),
        materialList[index].timeline!.apexLink!.hlsUrl == null ? SizedBox() :      CustomButton(
            navigateTo: MyMaterialVideo(materialList[index].timeline!.apexLink!.hlsUrl.toString(), materialList[index].title.toString(), materialList[index].timeline!.recordingProps!.the240.toString(),materialList[index].id.toString(),isTimlineRequired, videoQuallity: 'normal',tabId: widget.tabId,),
            title: getTranslated(context, LangString.Normal)
        ),
        SizedBox(height: 10),
        materialList[index].timeline!.apexLink!.hls240PUrl == null ? SizedBox() :  CustomButton(
          navigateTo: MyMaterialVideo(materialList[index].timeline!.apexLink!.hls240PUrl.toString(), materialList[index].title.toString(), materialList[index].timeline!.recordingProps!.the240.toString(),materialList[index].id.toString(),isTimlineRequired, videoQuallity: '240p',tabId: widget.tabId,),
          title: '240p',
        ),
        SizedBox(
          height: 10,
        ),
        materialList[index].timeline!.apexLink!.hls360PUrl == null ? SizedBox() :   CustomButton(
          navigateTo: MyMaterialVideo(materialList[index].timeline!.apexLink!.hls360PUrl.toString(), materialList[index].title.toString(), materialList[index].timeline!.recordingProps!.the360.toString(),materialList[index].id.toString(),isTimlineRequired,videoQuallity: '360p',tabId: widget.tabId),
          title: '360p',
        ),
        SizedBox(height: 10),
        materialList[index].timeline!.apexLink!.hls480PUrl == null ? SizedBox() :      CustomButton(
          navigateTo: MyMaterialVideo(materialList[index].timeline!.apexLink!.hls480PUrl.toString(), materialList[index].title.toString(), materialList[index].timeline!.recordingProps!.the576.toString(),materialList[index].id.toString(),isTimlineRequired,videoQuallity: '480p',tabId: widget.tabId),
          title: '480p',
        ),
        SizedBox(
          height: 10,
        ),
        materialList[index].timeline!.apexLink!.hls720PUrl == null ? SizedBox() :      CustomButton(
          navigateTo: MyMaterialVideo(materialList[index].timeline!.apexLink!.hls720PUrl.toString(), materialList[index].title.toString(), materialList[index].timeline!.recordingProps!.the576.toString(),materialList[index].id.toString(),isTimlineRequired,videoQuallity:'720p',tabId: widget.tabId),
          title: '720p',
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
