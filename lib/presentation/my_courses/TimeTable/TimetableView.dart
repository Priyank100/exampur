import 'package:exampur_mobile/Localization/language_constrants.dart';
import 'package:exampur_mobile/SharePref/shared_pref.dart';
import 'package:exampur_mobile/data/model/my_course_timeline_model.dart';
import 'package:exampur_mobile/provider/MyCourseProvider.dart';
import 'package:exampur_mobile/shared/youtube_video.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';


class TimeTableView extends StatefulWidget {
  final String courseId;
TimeTableView(this.courseId) ;

  @override
  _TimeTableViewState createState() => _TimeTableViewState();
}

class _TimeTableViewState extends State<TimeTableView> {

  List<TimelineData> myCourseTimeLineList = [];
  bool isLoading = false;

  @override
  void initState() {
    callProvider();
    super.initState();
  }

  Future<void> callProvider() async {
    isLoading = true;
    String token = await SharedPref.getSharedPref(SharedPrefConstants.TOKEN);
    myCourseTimeLineList = (await Provider.of<MyCourseProvider>(context, listen: false).getMyCourseTimeLineList(context, widget.courseId, token))!;
    print(myCourseTimeLineList.toString());
    isLoading = false;
    setState(() {});

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: isLoading?Center(child: CircularProgressIndicator(color: AppColors.amber,)):myCourseTimeLineList.length ==0?AppConstants.noDataFound(): ListView.builder(
        itemCount: myCourseTimeLineList.length,

        shrinkWrap: true,
        itemBuilder: (BuildContext context,int index){
          DateTime parseDate = new DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(myCourseTimeLineList[index].schedule.toString());
          var inputDate = DateTime.parse(parseDate.toString());
          var outputFormat = DateFormat('dd-MMM-yyyy hh:mm a');
          var outputDate = outputFormat.format(inputDate);
        return InkWell(
          onTap: (){
            myCourseTimeLineList[index].type.toString()=='Livesteam'?
            MaterialPageRoute(
                builder: (context) => YoutubeVideo(myCourseTimeLineList[index].targetLink.toString(),
                    myCourseTimeLineList[index].title.toString())
            )
            :
           AppConstants.showBottomMessage(context, getTranslated(context, StringConstant.noLiveStreamPresent), AppColors.grey);
          },
          child: Container(
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
                 Container(decoration: BoxDecoration(
                     border: Border.all(color: AppColors.red)
                 ),height: 25,width: 200,child: Center(child: Text('Live at '+outputDate,style: TextStyle(color: AppColors.red,fontSize: 10),)),)
               ],
             ),
           )
            ],)
          ),
        );
        })
    );
  }
}
