import 'package:exampur_mobile/Localization/language_constrants.dart';
import 'package:exampur_mobile/SharePref/shared_pref.dart';
import 'package:exampur_mobile/data/model/my_course_timeline_model.dart';
import 'package:exampur_mobile/presentation/widgets/loading_indicator.dart';
import 'package:exampur_mobile/provider/MyCourseProvider.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'TimeTableVideo.dart';

class TimeTableView extends StatefulWidget {
  final String courseId;
TimeTableView(this.courseId) ;

  @override
  _TimeTableViewState createState() => _TimeTableViewState();
}

class _TimeTableViewState extends State<TimeTableView> {

  List<TimelineData> myCourseTimeLineList = [];
  bool isLoading = false;
  // Data? liveStreamData;
  @override
  void initState() {
    callProvider();
    super.initState();
  }

  Future<void> callProvider() async {
    isLoading = true;
    String token = await SharedPref.getSharedPref(SharedPrefConstants.TOKEN);
    myCourseTimeLineList = (await Provider.of<MyCourseProvider>(context, listen: false).getMyCourseTimeLineList(context, widget.courseId, token))!;
    isLoading = false;
    setState(() {});

  }
  // Future<void> callLiveStream() async {
  //   String token = await SharedPref.getSharedPref(SharedPrefConstants.TOKEN);
  //   liveStreamData = (await Provider.of<MyCourseProvider>(context, listen: false).getMyCourseTimeLineLiveStream(context, myCourseTimeLineList.first.id.toString(), token))!;
  //  print(liveStreamData);
  //   setState(() {});
  // }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: isLoading?Center(child: LoadingIndicator(context)):myCourseTimeLineList.length ==0?AppConstants.noDataFound(): ListView.builder(
        itemCount: myCourseTimeLineList.length,

        shrinkWrap: true,
        itemBuilder: (BuildContext context,int index){
          DateTime parseDate = new DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(myCourseTimeLineList[index].schedule.toString());
          var inputDate = DateTime.parse(parseDate.toString());
          var outputFormat = DateFormat('dd-MMM-yyyy hh:mm a');
          var outputDate = outputFormat.format(inputDate);
        return
           //  myCourseTimeLineList[index].type.toString()=='Livesteam'?
           //  MaterialPageRoute(
           //      builder: (context) => YoutubeVideo(myCourseTimeLineList[index].targetLink.toString(),
           //          myCourseTimeLineList[index].title.toString())
           //  )
           //  :
           // AppConstants.showBottomMessage(context, getTranslated(context, StringConstant.noLiveStreamPresent), AppColors.grey);
          Container(
            padding: EdgeInsets.all(8),
              color: index % 2 == 0
                  ? Theme.of(context).backgroundColor
                  : AppColors.transparent,
       child:   Row(
           mainAxisAlignment:MainAxisAlignment.start,children: [
              // Image.asset(Images.free_course,height: 120,width: 100,),
           AppConstants.image(AppConstants.BANNER_BASE + myCourseTimeLineList[index].logoPath.toString(),height: 120.0,width: 100.0,),
           SizedBox(width: 9,),
           Flexible(
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,

               children: [
               Text(myCourseTimeLineList[index].title.toString() + ' || ' + myCourseTimeLineList[index].chapterName.toString() + ' || ' + myCourseTimeLineList[index].subjectId!.title.toString(),style: TextStyle(fontSize: 15),),
                 SizedBox(height: 10,),
                 // myCourseTimeLineList[index].targetLink == null || myCourseTimeLineList[index].targetLink.toString().isEmpty ?  InkWell(
                 //   onTap: (){
                 //     //AppConstants.showBottomMessage(context, getTranslated(context, StringConstant.noLiveStreamPresent), AppColors.grey);
                 //   },
                 //   child: Container(decoration: BoxDecoration(
                 //       border: Border.all(color: AppColors.red)
                 //   ),height: 25,width: 200,child: Center(child: Text('Live at '+outputDate,style: TextStyle(color: AppColors.red,fontSize: 10),)),),
                 // ):
                 InkWell(
                   onTap: (){
                    // AppConstants.goTo(context, AlertStream(myCourseTimeLineList[index].id.toString()));
                     callLiveStream(index);
                   },
                   child: Container(decoration: BoxDecoration(
                       border: Border.all(color: AppColors.red)
                   ),height: 25,width: 200,child: Center(child: Text('Live at '+outputDate,style: TextStyle(color: AppColors.red,fontSize: 10),)),),
                 )
               ],
             ),
           )
            ],)

        );
        })
    );
  }

  Future<void> callLiveStream(index) async {
    String token = await SharedPref.getSharedPref(SharedPrefConstants.TOKEN);
    await Provider.of<MyCourseProvider>(context, listen: false).getMyCourseTimeLineLiveStream(context, myCourseTimeLineList[index].id.toString(), token).then((liveStreamData) {
      AlertDialog alert = AlertDialog(
        titlePadding: EdgeInsets.only(top: 0, ),
        contentPadding: EdgeInsets.only(top: 0, ),
        //insetPadding: EdgeInsets.symmetric(horizontal: 1),
        // title: const Text('Popup example'),
        content: Column(

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
            CustomButton(navigateTo:MyTimeTableViedo(liveStreamData!.apexLink!.hlsURL.toString(),myCourseTimeLineList[index].title.toString()) ,title: 'Normal',),
            SizedBox(height: 10,),
            CustomButton(navigateTo: MyTimeTableViedo(liveStreamData.apexLink!.hls240pURL.toString(),myCourseTimeLineList[index].title.toString()),title: '240p',),
            SizedBox(height: 10,),
            CustomButton(navigateTo:MyTimeTableViedo(liveStreamData.apexLink!.hls360pURL.toString(),myCourseTimeLineList[index].title.toString() ) ,title: '360p',),
            SizedBox(height: 10,),
            CustomButton(navigateTo:MyTimeTableViedo(liveStreamData.apexLink!.hls480pURL.toString(),myCourseTimeLineList[index].title.toString()) ,title: '480p',),
            SizedBox(height: 10,),
            CustomButton(navigateTo: MyTimeTableViedo(liveStreamData.apexLink!.hls720pURL.toString(),myCourseTimeLineList[index].title.toString()) ,title: '720p',),
            SizedBox(height: 10,),

          ],
        ),

        // actions: <Widget>[
        //   new FlatButton(
        //     onPressed: () {
        //       Navigator.of(context).pop();
        //     },
        //     textColor: Theme.of(context).primaryColor,
        //     child: const Text('Close'),
        //   ),
        // ],
      );
      showDialog(barrierDismissible: true,
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    });
  }
}

class CustomButton extends StatelessWidget {
  final String? image;
  final String? title;
  final Widget? navigateTo;
  final Color? color;

  CustomButton(
      {@required this.image,
        @required this.title,
        @required this.navigateTo,
        this.color});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width - 60;
    return InkWell(
        onTap: () {  Navigator.pop(context);
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => navigateTo!));},
        child: Container(
            width: width / 2,
            height: 40,
            // alignment: Alignment.center,
            //padding: EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8), color: AppColors.amber),
            child:

            Center(
              child: new Text(
                title!,
                style: TextStyle(color: AppColors.white),
              ),
            ))


    );
  }
}