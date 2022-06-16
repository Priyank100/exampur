import 'package:exampur_mobile/Localization/language_constrants.dart';
import 'package:exampur_mobile/SharePref/shared_pref.dart';
import 'package:exampur_mobile/data/model/my_course_material_model.dart';
import 'package:exampur_mobile/presentation/authentication/terms_condition.dart';
import 'package:exampur_mobile/presentation/my_courses/TeacherSubjectView/material_video.dart';
import 'package:exampur_mobile/presentation/my_courses/Timeline/TimetableView.dart';
import 'package:exampur_mobile/presentation/widgets/custom_button_amber_color_watch.dart';
import 'package:exampur_mobile/presentation/widgets/custom_round_button.dart';
import 'package:exampur_mobile/presentation/widgets/loading_indicator.dart';
import 'package:exampur_mobile/provider/MyCourseProvider.dart';
import 'package:exampur_mobile/shared/view_pdf.dart';
import 'package:exampur_mobile/shared/youtube_video.dart';
import 'package:exampur_mobile/utils/api.dart';
import 'package:exampur_mobile/utils/appBar.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:exampur_mobile/utils/dimensions.dart';
import 'package:exampur_mobile/utils/images.dart';
import 'package:exampur_mobile/utils/refreshwidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'DownloadPdfView.dart';
import 'apexvideo.dart';

class ChapterDetailView extends StatefulWidget {
  String subjectId;
  String courseId;
  String chaptername;

  ChapterDetailView(this.subjectId, this.courseId, this.chaptername) : super();

  @override
  State<ChapterDetailView> createState() => _ChapterDetailViewState();
}

class _ChapterDetailViewState extends State<ChapterDetailView> {
  List<MaterialData> materialList = [];
  bool isLoading = false;
  final keyRefresh = GlobalKey<RefreshIndicatorState>();
  @override
  void initState() {
    callProvider();
    super.initState();
  }

  Future<void>_refreshScreen() async{
    materialList.clear();
    return callProvider();
  }

  Future<void> callProvider() async {
    isLoading = true;
    materialList = (await Provider.of<MyCourseProvider>(context, listen: false)
        .getMaterialList(
            context, widget.subjectId, widget.courseId, widget.chaptername))!;
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body:RefreshWidget(
      keyRefresh: keyRefresh,
      onRefresh:_refreshScreen,
    child: isLoading ? LoadingIndicator(context)
          : materialList.length == 0 ? AppConstants.noDataFound()
          : ListView.builder(
              itemCount: materialList.length,
              padding: EdgeInsets.all(5),
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  margin: EdgeInsets.all(5),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                    child: Row(
                      children: [
                        chapterImage(index),
                        SizedBox(width: 10),
                        chapterData(index)
                      ],
                    ),
                  ),
                );
              }),
      ));
  }

  Widget chapterImage(index) {
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

  Widget chapterData(index) {
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
              materialList[index].videoLink == null || materialList[index].videoLink.toString().isEmpty ?
                  materialList[index].timeline == null || materialList[index].timeline!.apexLink == null ?
              SizedBox() : VideoDownloadButton(index) : VideoDownloadButton(index),
              SizedBox(width: 5),
              materialList[index].pdfPath == null || materialList[index].pdfPath.toString().isEmpty ?
              SizedBox() : PdfButton(index),
              SizedBox(width: 5),
              materialList[index].docpath == null || materialList[index].docpath.toString().isEmpty ?
              SizedBox() :   InkWell(onTap: () {
              String pdfPath = AppConstants.BANNER_BASE +  materialList[index].docpath.toString();
                Navigator.push(context, MaterialPageRoute(builder: (context) => DownloadViewPdf('', pdfPath)));

              },
                child: Container(height: 30,width: MediaQuery.of(context).size.width / 6,decoration: BoxDecoration( color: AppColors.dark,
                    borderRadius: BorderRadius.all(Radius.circular(8))),child: Center(child: Text(getTranslated(context, StringConstant.pdf)!,style: TextStyle(color: Colors.white,fontSize: 11)))),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget VideoDownloadButton(index) {
 return   InkWell(
      onTap: () {
        materialList[index].timeline == null || materialList[index].timeline!.apexLink == null ?
              Navigator.push(context, MaterialPageRoute(builder: (context) =>
                  MyMaterialVideo(materialList[index].videoLink.toString(), materialList[index].title.toString(), ''))
              ) :
              showVideoQualityDialog(index);

      },
      child: Container(
          height: 30,
          width: MediaQuery.of(context).size.width / 6,
          decoration: BoxDecoration(color: AppColors.amber, borderRadius: BorderRadius.all(Radius.circular(8))),
          child: Center(
              child: Text(
                  getTranslated(context, StringConstant.watch)!,
                  style: TextStyle(color: Colors.white, fontSize: 11)
              )
          )
      ),
    );
    // return CustomAmberButton(
    //     text: getTranslated(context, StringConstant.watch)!,
    //     onPressed: () {
    //       materialList[index].timeline == null || materialList[index].timeline!.apexLink == null ?
    //       Navigator.push(context, MaterialPageRoute(builder: (context) =>
    //           MyMaterialVideo(materialList[index].videoLink.toString(), materialList[index].title.toString(), ''))
    //       ) :
    //       showVideoQualityDialog(index);
    //     });
  }

  Widget PdfButton(index) {
    return materialList[index].pdfPath == null || materialList[index].pdfPath!.isEmpty
        ? SizedBox()
        : InkWell(
      onTap: () {
        String pdfPath = '';
        materialList[index].pdfPath.toString().contains('http') ?
        pdfPath = materialList[index].pdfPath.toString() :
        pdfPath = AppConstants.BANNER_BASE + materialList[index].pdfPath.toString();

        String pdfTitle = materialList[index].title.toString();

        Navigator.push(context, MaterialPageRoute(builder: (context) => DownloadViewPdf(pdfTitle, pdfPath)));
      },
      child: Container(
          height: 30,
          width: MediaQuery.of(context).size.width / 6,
          decoration: BoxDecoration(color: Color(0xFF060929), borderRadius: BorderRadius.all(Radius.circular(8))),
          child: Center(
              child: Text(
                  getTranslated(context, StringConstant.pdf)!,
                  style: TextStyle(color: Colors.white, fontSize: 11)
              )
          )
      ),
    );
  }

  void showVideoQualityDialog(index) {
    AlertDialog alert = AlertDialog(
      titlePadding: EdgeInsets.only(top: 0),
      contentPadding: EdgeInsets.only(top: 0),
      content: materialList[index].timeline!.recordingProps == null ?
      QualityListWithoutProps(index) :
      QualityListWithProps(index),
    );
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Widget QualityListWithoutProps(index) {
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
            navigateTo: MyMaterialVideo(materialList[index].timeline!.apexLink!.hlsUrl.toString(), materialList[index].title.toString(),''),
            title: getTranslated(context, StringConstant.Normal)!
        ),
        SizedBox(height: 10),
        materialList[index].timeline!.apexLink!.hls240PUrl == null ? SizedBox() :   CustomButton(
          navigateTo: MyMaterialVideo(materialList[index].timeline!.apexLink!.hls240PUrl.toString(), materialList[index].title.toString(), ''),
          title: '240p',
        ),
        SizedBox(height: 10),
        materialList[index].timeline!.apexLink!.hls360PUrl == null ? SizedBox() :     CustomButton(
          navigateTo: MyMaterialVideo(materialList[index].timeline!.apexLink!.hls360PUrl.toString(), materialList[index].title.toString(), ''),
          title: '360p',
        ),
        SizedBox(height: 10),
        materialList[index].timeline!.apexLink!.hls480PUrl == null ? SizedBox() :  CustomButton(
          navigateTo: MyMaterialVideo(materialList[index].timeline!.apexLink!.hls480PUrl.toString(), materialList[index].title.toString(), ''),
          title: '480p',
        ),
        SizedBox(height: 10),
        materialList[index].timeline!.apexLink!.hls720PUrl == null ? SizedBox() :  CustomButton(
          navigateTo: MyMaterialVideo(materialList[index].timeline!.apexLink!.hls720PUrl.toString(), materialList[index].title.toString(), ''),
          title: '720p',
        ),
        SizedBox(height: 10),
      ],
    );
  }

  Widget QualityListWithProps(index) {
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
            navigateTo: MyMaterialVideo(materialList[index].timeline!.apexLink!.hlsUrl.toString(), materialList[index].title.toString(), materialList[index].timeline!.recordingProps!.the240.toString()),
            title: getTranslated(context, StringConstant.Normal)
        ),
        SizedBox(height: 10),
        materialList[index].timeline!.apexLink!.hls240PUrl == null ? SizedBox() :  CustomButton(
          navigateTo: MyMaterialVideo(materialList[index].timeline!.apexLink!.hls240PUrl.toString(), materialList[index].title.toString(), materialList[index].timeline!.recordingProps!.the240.toString()),
          title: '240p',
        ),
        SizedBox(
          height: 10,
        ),
        materialList[index].timeline!.apexLink!.hls360PUrl == null ? SizedBox() :   CustomButton(
          navigateTo: MyMaterialVideo(materialList[index].timeline!.apexLink!.hls360PUrl.toString(), materialList[index].title.toString(), materialList[index].timeline!.recordingProps!.the360.toString()),
          title: '360p',
        ),
        SizedBox(height: 10),
        materialList[index].timeline!.apexLink!.hls480PUrl == null ? SizedBox() :      CustomButton(
          navigateTo: MyMaterialVideo(materialList[index].timeline!.apexLink!.hls480PUrl.toString(), materialList[index].title.toString(), materialList[index].timeline!.recordingProps!.the576.toString()),
          title: '480p',
        ),
        SizedBox(
          height: 10,
        ),
        materialList[index].timeline!.apexLink!.hls720PUrl == null ? SizedBox() :      CustomButton(
          navigateTo: MyMaterialVideo(materialList[index].timeline!.apexLink!.hls720PUrl.toString(), materialList[index].title.toString(), materialList[index].timeline!.recordingProps!.the576.toString()),
          title: '720p',
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
