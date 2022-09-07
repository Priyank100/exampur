import 'package:exampur_mobile/Localization/language_constrants.dart';
import 'package:exampur_mobile/data/model/my_course_material_model.dart';
import 'package:exampur_mobile/presentation/authentication/terms_condition.dart';
import 'package:exampur_mobile/presentation/my_courses/TeacherSubjectView/material_video.dart';
import 'package:exampur_mobile/presentation/my_courses/Timeline/TimetableView.dart';
import 'package:exampur_mobile/presentation/widgets/loading_indicator.dart';
import 'package:exampur_mobile/provider/MyCourseProvider.dart';
import 'package:exampur_mobile/utils/appBar.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:exampur_mobile/utils/dimensions.dart';
import 'package:exampur_mobile/utils/images.dart';
import 'package:exampur_mobile/utils/refreshwidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'DownloadPdfView.dart';

class ChapterDetailView extends StatefulWidget {
  String subjectId;
  String courseId;
  String chaptername;

  ChapterDetailView(this.subjectId, this.courseId, this.chaptername) : super();

  @override
  State<ChapterDetailView> createState() => _ChapterDetailViewState();
}

class _ChapterDetailViewState extends State<ChapterDetailView> {
  List<MaterialData> mainList = [];
  bool isLoading = false;
  final keyRefresh = GlobalKey<RefreshIndicatorState>();
  List<GroupClass> groupingList = [];

  String noVideoLink = 'https://cdn.exampur.xyz/No+video+available+here.+This+is+a+Special+PDF.+Please+clink+on+View+PDF+to+access+the+material.mp4';


  @override
  void initState() {
    callProvider();
    super.initState();
  }

  Future<void>_refreshScreen() async{
    mainList.clear();
    groupingList.clear();
    return callProvider();
  }

  Future<void> callProvider() async {
    isLoading = true;
    mainList = (await Provider.of<MyCourseProvider>(context, listen: false).getMaterialList(context, widget.subjectId, widget.courseId, widget.chaptername))!;
    grouping();
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
          : mainList.length == 0 ? AppConstants.noDataFound()
          : unitGrouping()
    // ListView.builder(
    //           itemCount: materialList.length,
    //           padding: EdgeInsets.all(5),
    //           shrinkWrap: true,
    //           itemBuilder: (BuildContext context, int index) {
    //             return Container(
    //               margin: EdgeInsets.all(5),
    //               child: Padding(
    //                 padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
    //                 child: Row(
    //                   children: [
    //                     chapterImage(index),
    //                     SizedBox(width: 10),
    //                     chapterData(index)
    //                   ],
    //                 ),
    //               ),
    //             );
    //           }),
      ));
  }

  Widget unitGrouping(){
    return ListView.builder(
      padding: EdgeInsets.all(10),
      itemCount: groupingList.length,
        itemBuilder: (context, i) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              InkWell(
               onTap: (){
                 setState(() {
                   if(groupingList[i].unitTitle == 'Others'){
                     groupingList[i].showVideo == true;
                   }else{
                  groupingList[i].showVideo = !groupingList[i].showVideo;}
                 });
               },
               child: Container(
                 padding: EdgeInsets.all(13),
                  margin: EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    border:groupingList[i].unitTitle!='Others'? Border.all(width: 0):null,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                  child:Column(
                    children: [
                      groupingList[i].unitTitle!='Others'?  Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(groupingList[i].unitTitle, style: TextStyle(fontSize: 18)),
                          Icon(Icons.arrow_drop_down_sharp)
                        ],
                      ):SizedBox(),

                      ListView.builder(
                          itemCount: groupingList[i].list.length,
                          padding: EdgeInsets.all(5),
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            return groupingList[i].showVideo ?Container(
                              margin: EdgeInsets.all(5),
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                                child: Row(
                                  children: [
                                    chapterImage(groupingList[i].list, index),
                                    SizedBox(width: 10),
                                    chapterData(groupingList[i].list, index)
                                  ],
                                ),
                              ),
                            ):SizedBox();
                          })
                    ],
                  )

                ),
             ),

           //   groupingList[i].unitTitle!='Others'?Text(groupingList[i].unitTitle, style: TextStyle(fontSize: 18)):SizedBox(),


             // groupingList[i].unitTitle!='Others'?Divider():SizedBox()
            ],
          ),
        );
        }
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
                showPdfDialog(docPath, materialList[index].title.toString());
              // String pdfPath = AppConstants.BANNER_BASE +  materialList[index].docpath.toString();
              //   Navigator.push(context, MaterialPageRoute(builder: (context) => DownloadViewPdf('', pdfPath)));

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

  Widget WatchVideoButton(List<MaterialData> materialList, index) {
    return InkWell(
      onTap: () {
        // print(materialList[index].title);
        materialList[index].timeline == null || materialList[index].timeline!.apexLink == null ?
              Navigator.push(context, MaterialPageRoute(builder: (context) =>
                  MyMaterialVideo(materialList[index].videoLink.toString(), materialList[index].title.toString(), '',materialList[index].id.toString()))
              ) :
              showVideoQualityDialog(materialList, index);

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

  Widget PdfButton(List<MaterialData> materialList, index) {
    return materialList[index].pdfPath == null || materialList[index].pdfPath!.isEmpty
        ? SizedBox()
        : InkWell(
      onTap: () {
        String pdfPath = '';
        materialList[index].pdfPath.toString().contains('http') ?
        pdfPath = materialList[index].pdfPath.toString() :
        pdfPath = AppConstants.BANNER_BASE + materialList[index].pdfPath.toString();
        showPdfDialog(pdfPath, materialList[index].title.toString());
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
            navigateTo: MyMaterialVideo(materialList[index].timeline!.apexLink!.hlsUrl.toString(), materialList[index].title.toString(),'',materialList[index].id.toString()),
            title: getTranslated(context, StringConstant.Normal)!
        ),
        SizedBox(height: 10),
        materialList[index].timeline!.apexLink!.hls240PUrl == null ? SizedBox() :   CustomButton(
          navigateTo: MyMaterialVideo(materialList[index].timeline!.apexLink!.hls240PUrl.toString(), materialList[index].title.toString(), '',materialList[index].id.toString()),
          title: '240p',
        ),
        SizedBox(height: 10),
        materialList[index].timeline!.apexLink!.hls360PUrl == null ? SizedBox() :     CustomButton(
          navigateTo: MyMaterialVideo(materialList[index].timeline!.apexLink!.hls360PUrl.toString(), materialList[index].title.toString(), '',materialList[index].id.toString()),
          title: '360p',
        ),
        SizedBox(height: 10),
        materialList[index].timeline!.apexLink!.hls480PUrl == null ? SizedBox() :  CustomButton(
          navigateTo: MyMaterialVideo(materialList[index].timeline!.apexLink!.hls480PUrl.toString(), materialList[index].title.toString(), '',materialList[index].id.toString()),
          title: '480p',
        ),
        SizedBox(height: 10),
        materialList[index].timeline!.apexLink!.hls720PUrl == null ? SizedBox() :  CustomButton(
          navigateTo: MyMaterialVideo(materialList[index].timeline!.apexLink!.hls720PUrl.toString(), materialList[index].title.toString(), '',materialList[index].id.toString()),
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
            navigateTo: MyMaterialVideo(materialList[index].timeline!.apexLink!.hlsUrl.toString(), materialList[index].title.toString(), materialList[index].timeline!.recordingProps!.the240.toString(),materialList[index].id.toString()),
            title: getTranslated(context, StringConstant.Normal)
        ),
        SizedBox(height: 10),
        materialList[index].timeline!.apexLink!.hls240PUrl == null ? SizedBox() :  CustomButton(
          navigateTo: MyMaterialVideo(materialList[index].timeline!.apexLink!.hls240PUrl.toString(), materialList[index].title.toString(), materialList[index].timeline!.recordingProps!.the240.toString(),materialList[index].id.toString()),
          title: '240p',
        ),
        SizedBox(
          height: 10,
        ),
        materialList[index].timeline!.apexLink!.hls360PUrl == null ? SizedBox() :   CustomButton(
          navigateTo: MyMaterialVideo(materialList[index].timeline!.apexLink!.hls360PUrl.toString(), materialList[index].title.toString(), materialList[index].timeline!.recordingProps!.the360.toString(),materialList[index].id.toString()),
          title: '360p',
        ),
        SizedBox(height: 10),
        materialList[index].timeline!.apexLink!.hls480PUrl == null ? SizedBox() :      CustomButton(
          navigateTo: MyMaterialVideo(materialList[index].timeline!.apexLink!.hls480PUrl.toString(), materialList[index].title.toString(), materialList[index].timeline!.recordingProps!.the576.toString(),materialList[index].id.toString()),
          title: '480p',
        ),
        SizedBox(
          height: 10,
        ),
        materialList[index].timeline!.apexLink!.hls720PUrl == null ? SizedBox() :      CustomButton(
          navigateTo: MyMaterialVideo(materialList[index].timeline!.apexLink!.hls720PUrl.toString(), materialList[index].title.toString(), materialList[index].timeline!.recordingProps!.the576.toString(),materialList[index].id.toString()),
          title: '720p',
        ),
        SizedBox(height: 10),
      ],
    );
  }

  void grouping() {
    var groupedLists = {};
    mainList.forEach((data) {
        if (groupedLists['${data.unit}'] == null) {
          groupedLists['${data.unit}'] = <MaterialData>[];
        }
        (groupedLists['${data.unit}'] as List<MaterialData>).add(data);
    });
    for(int i=0; i<groupedLists.length; i++) {
      String key = groupedLists.keys.elementAt(i);
      var value = groupedLists.values.elementAt(i);
      if(key == 'Others'){
        groupingList.add(GroupClass(key, value,true));
      }
     else{
      groupingList.add(GroupClass(key, value,false));
    }
  }
  }

  void showPdfDialog(pdfPath, title) {
    AlertDialog alert = AlertDialog(
      content: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          alignment: WrapAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(getTranslated(context, StringConstant.pleaseChoosetoOpenpdf)!),
                SizedBox(height: 10),
                Container(
                  width: MediaQuery.of(context).size.width/2,
                  child: MaterialButton(
                    onPressed: (){
                      Navigator.pop(context);
                      Navigator.push(context, MaterialPageRoute(builder: (context) => DownloadViewPdf(title, pdfPath)));
                    },
                    color: AppColors.amber,
                    child: Text(getTranslated(context, StringConstant.pdfViewer)!, style: TextStyle(color: AppColors.white)),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width/2,
                  child: MaterialButton(
                    onPressed: () async {
                      Navigator.pop(context);
                      AppConstants.makeCallEmail(pdfPath);
                    },
                    color: AppColors.green,
                    child: Text(getTranslated(context, StringConstant.browser)!, style: TextStyle(color: AppColors.white)),
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
}

class GroupClass {
  String unitTitle;
  List<MaterialData> list;
  bool showVideo ;
  GroupClass(this.unitTitle, this.list,this.showVideo);

}
