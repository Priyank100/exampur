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

  TimeTableView(this.courseId);

  @override
  _TimeTableViewState createState() => _TimeTableViewState();
}

class _TimeTableViewState extends State<TimeTableView> {
  // List<TimelineData> allDataList = [];
  List<TimelineData> myCourseTimeLineList = [];
  bool isLoading = false;
  String activeButton = "L";

  @override
  void initState() {
    callProvider();
    super.initState();
  }

  Future<void> callProvider() async {
    isLoading = true;
    myCourseTimeLineList = (await Provider.of<MyCourseProvider>(context, listen: false).getMyCourseTimeLineList(context, widget.courseId, activeButton))!;
    // filterList(allDataList, activeButton);
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:Column(
          children: [
            Container(
              height: 50,
              width: MediaQuery.of(context).size.width,
              child:  Row(
                children: [
                  MaterialButton(
                      minWidth:MediaQuery.of(context).size.width/2,
                  onPressed:(){
                    setState(() {
                      activeButton = "L";
                    });
                    // filterList(allDataList, activeButton);
                    callProvider();
                  },
                  color:activeButton=='L'? AppColors.amber:AppColors.grey400,
                  child: Text('Live',style: TextStyle(color: AppColors.white),)),

              MaterialButton(
                  minWidth:MediaQuery.of(context).size.width/2,
                  color:activeButton=='L'? AppColors.grey400:AppColors.amber,
                  onPressed:(){
                    setState(() {
                      activeButton = "U";
                    });
                    // filterList(allDataList, activeButton);
                    callProvider();
                  },
                  child:  Text('Upcoming',style: TextStyle(color: AppColors.white))),
            ],
          ),
        ),
            isLoading ? Center(child: LoadingIndicator(context)) : myCourseTimeLineList.length == 0 ?
            AppConstants.noDataFound() :
            Expanded(
              child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                //  physics:BouncingScrollPhysics(),
                                  itemCount: myCourseTimeLineList.length,

                                  shrinkWrap: true,
                                  itemBuilder: (BuildContext context, int index) {
                                  //10/05/2022, 04:00:00
                                    DateTime parseDate = new DateFormat("dd/MM/yyyy, HH:mm:ss")
                                        .parse(myCourseTimeLineList[index].schedule.toString());
                                    var inputDate = DateTime.parse(parseDate.toString());
                                    var outputFormat = DateFormat('dd MMM yyyy hh:mm a');
                                    var outputDate = outputFormat.format(inputDate);
                                    return
                                        InkWell(
                                          onTap: () {
                                            activeButton=='L' ? callLiveStream(index) : null;
                                            },
                                          child: Container(
                                          padding: EdgeInsets.all(8),
                                          color: index % 2 == 0
                                              ? Theme.of(context).backgroundColor
                                              : AppColors.transparent,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              // Image.asset(Images.free_course,height: 120,width: 100,),
                                              myCourseTimeLineList[index]
                                                      .logoPath
                                                      .toString()
                                                      .contains('http')
                                                  ? AppConstants.image(
                                                      myCourseTimeLineList[index]
                                                          .logoPath
                                                          .toString(),
                                                      height: 80.0,
                                                      width: 100.0)
                                                  : AppConstants.image(
                                                      AppConstants.BANNER_BASE +
                                                          myCourseTimeLineList[index]
                                                              .logoPath
                                                              .toString(),
                                                      height: 80.0,
                                                      width: 100.0,
                                                    ),
                                              SizedBox(
                                                width: 9,
                                              ),
                                              Flexible(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      myCourseTimeLineList[index]
                                                              .title
                                                              .toString() +
                                                          ' || ' +
                                                          myCourseTimeLineList[index]
                                                              .subjectId!
                                                              .title
                                                              .toString(),
                                                      style: TextStyle(fontSize: 15),
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Container(
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                              color: AppColors.red)),
                                                      height: 25,
                                                      width: 200,
                                                      child: Center(
                                                          child: Text(
                                                              activeButton=='L' ? 'Watch Now' :
                                                              'Live at ' + outputDate,
                                                              style: TextStyle(color: AppColors.red, fontSize: 10)
                                                          )
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          )),
                                    );
                                  }),
            ),
          ])
    );
  }

  Future<void> callLiveStream(index) async {
    String token = await SharedPref.getSharedPref(SharedPrefConstants.TOKEN);
    await Provider.of<MyCourseProvider>(context, listen: false)
        .getMyCourseTimeLineLiveStream(
            context, myCourseTimeLineList[index].id.toString(), token)
        .then((liveStreamData) {
          if(liveStreamData!.apexLink == null) {
            AppConstants.showAlertDialog(context, 'No video link is available !');
            return;
          } else {
            AlertDialog alert = AlertDialog(
              titlePadding: EdgeInsets.only(
                top: 0,
              ),
              contentPadding: EdgeInsets.only(
                top: 0,
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    color: AppColors.amber,
                    height: 30,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
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
                  SizedBox(
                    height: 10,
                  ),
                  CustomButton(
                    navigateTo: MyTimeTableViedo(
                        liveStreamData.apexLink!.hlsURL.toString(),
                        myCourseTimeLineList[index].title.toString(),
                        liveStreamData.id.toString()),
                    title: getTranslated(context, StringConstant.Normal),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomButton(
                    navigateTo: MyTimeTableViedo(
                        liveStreamData.apexLink!.hls240pURL.toString(),
                        myCourseTimeLineList[index].title.toString(),
                        liveStreamData.id.toString()),
                    title: '240p',
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomButton(
                    navigateTo: MyTimeTableViedo(
                        liveStreamData.apexLink!.hls360pURL.toString(),
                        myCourseTimeLineList[index].title.toString(),
                        liveStreamData.id.toString()),
                    title: '360p',
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomButton(
                    navigateTo: MyTimeTableViedo(
                        liveStreamData.apexLink!.hls480pURL.toString(),
                        myCourseTimeLineList[index].title.toString(),
                        liveStreamData.id.toString()),
                    title: '480p',
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomButton(
                    navigateTo: MyTimeTableViedo(
                        liveStreamData.apexLink!.hls720pURL.toString(),
                        myCourseTimeLineList[index].title.toString(),
                        liveStreamData.id.toString()),
                    title: '720p',
                  ),
                  SizedBox(
                    height: 10,
                  ),
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
            showDialog(
              barrierDismissible: true,
              context: context,
              builder: (BuildContext context) {
                return alert;
              },
            );
          }
    });
  }

  /*void filterList(List<TimelineData> list, String activeBtn) {
    myCourseTimeLineList.clear();
    DateFormat outputFormat = DateFormat('dd-MM-yyyy HH:mm:ss');
    String now = outputFormat.format(DateTime.now());
    DateTime todayDate = outputFormat.parse(now);

    for(int i=0; i<list.length; i++) {
      DateTime parseDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(list[i].schedule.toString());
      DateTime inputDate = DateTime.parse(parseDate.toString());
      String outputDate = outputFormat.format(inputDate);
      DateTime scheduleDate = outputFormat.parse(outputDate);
      int diff = scheduleDate.difference(todayDate).inSeconds;
      // print(diff);

      if(activeButton == "L" && diff <= 0) {
        myCourseTimeLineList.add(list[i]);
      }
      if(activeButton == "U" && diff > 0) {
        myCourseTimeLineList.add(list[i]);
      }
    }
  }*/
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
        onTap: () {
          Navigator.pop(context);
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => navigateTo!));
        },
        child: Container(
            width: width / 2,
            height: 40,
            // alignment: Alignment.center,
            //padding: EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8), color: AppColors.amber),
            child: Center(
              child: new Text(
                title!,
                style: TextStyle(color: AppColors.white),
              ),
            )));
  }


}
