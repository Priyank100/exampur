import 'package:exampur_mobile/Localization/language_constrants.dart';
import 'package:exampur_mobile/SharePref/shared_pref.dart';
import 'package:exampur_mobile/data/model/my_course_timeline_model.dart';
import 'package:exampur_mobile/presentation/my_courses/Timeline/TimeTableVideo.dart';
import 'package:exampur_mobile/presentation/widgets/loading_indicator.dart';
import 'package:exampur_mobile/provider/new_my_course_provider.dart';
import 'package:exampur_mobile/utils/app_colors.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:exampur_mobile/utils/images.dart';
import 'package:exampur_mobile/utils/lang_string.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../widgets/custom_bottomsheet.dart';

class TimelineView extends StatefulWidget {
  final String courseId;
  const TimelineView(this.courseId) : super();

  @override
  State<TimelineView> createState() => _TimelineViewState();
}

class _TimelineViewState extends State<TimelineView> {
  List<TimelineData> myCourseTimeLineList = [];
  bool isLoading = false;
  String activeButton = "L";
  int unlockValue = 0;

  @override
  void initState() {
    callProvider();
    super.initState();
  }

  Future<void> callProvider() async {
    isLoading = true;
    myCourseTimeLineList = (await Provider.of<NewMyCourseProvider>(context, listen: false).getMyCourseTimeLineList(context, widget.courseId, activeButton))!;
    isLoading = false;
    // myCourseTimeLineList.add(TimelineData(
    //     id: '6379c70ce251f34430980c6a',
    //     subjectId: Subject_id(id: '628ec54549cdeff05805e211', title: 'UP GK By Amit Pandey Sir'),
    //     title: 'Part 02 :  History : 821 Nov 2022 : UP GK : By Amit Pandey Sir',
    //     description: 'Part 02 :  History : 21 Nov 2022 : UP GK : By Amit Pandey Sir',
    //     logoPath: 'tdfghjk',
    //     type: 'course_timeline/VssPzPZC-AMIT-PANDEY-SIR-2-jpg',
    //     targetLink: '',
    //     schedule: '21/11/2022, 11:00:00',
    //     isDemo: false
    // ));
    myCourseTimeLineList.length == 0 ? unlockValue = 0 : unlockValue = AppConstants.unlockItem(myCourseTimeLineList.length);
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
                          callProvider();
                        },
                        color:activeButton=='L'? AppColors.amber:AppColors.grey400,
                        child: Text(getTranslated(context, LangString.live)!,style: TextStyle(color: AppColors.white),)),

                    MaterialButton(
                        minWidth:MediaQuery.of(context).size.width/2,
                        color:activeButton=='L'? AppColors.grey400:AppColors.amber,
                        onPressed:(){
                          setState(() {
                            activeButton = "U";
                          });
                          callProvider();
                        },
                        child:  Text(getTranslated(context, LangString.upComing)!,style: TextStyle(color: AppColors.white))),
                  ],
                ),
              ),
              isLoading ? Center(child: LoadingIndicator(context)) : myCourseTimeLineList.length == 0 ?
              AppConstants.noDataFound() :
              Expanded(
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: myCourseTimeLineList.length,

                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      DateTime parseDate = new DateFormat("dd/MM/yyyy, HH:mm:ss")
                          .parse(myCourseTimeLineList[index].schedule.toString());
                      var inputDate = DateTime.parse(parseDate.toString());
                      var outputFormat = DateFormat('dd MMM yyyy hh:mm a');
                      var outputDate = outputFormat.format(inputDate);
                      return
                        InkWell(
                          onTap: () {
                            activeButton=='L' ?
                            index < unlockValue ?
                            myCourseTimeLineList[index].type.toString().toUpperCase() == 'ZOOM' ?
                            AppConstants.makeCallEmail(myCourseTimeLineList[index].targetLink.toString()) :
                            callLiveStream(index) : ModalBottomSheet.moreModalBottomSheet(context) : null;
                          },
                          child: Stack(
                            children: [
                              Container(
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
                                                  .toString(),
                                              // + ' || ' +
                                              // myCourseTimeLineList[index]
                                              //     .subjectId!
                                              //     .title
                                              //     .toString(),
                                              style: TextStyle(fontSize: 14,overflow: TextOverflow.ellipsis),
                                              maxLines: 2,
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
                              index+1 > unlockValue && activeButton=='L' ? Opacity(
                                  opacity: 0.6,
                                  child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 100.0,
                                      margin: const EdgeInsets.all(2),
                                      color: AppColors.black,
                                      child: Image.asset(Images.lock, scale: 1.5, color: AppColors.red900)
                                  )
                              ) : SizedBox()
                            ],
                          ),
                        );
                    }),
              ),
            ])
    );
  }

  Future<void> callLiveStream(index) async {
    String token = await SharedPref.getSharedPref(SharedPref.TOKEN);
    await Provider.of<NewMyCourseProvider>(context, listen: false).getMyCourseTimeLineLiveStream(context, myCourseTimeLineList[index].id.toString(), token)
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
              CustomButtonLive(
                onPressed: (){
                  AppConstants.videoQuality ='Normal';
                  AppConstants.chapterName =myCourseTimeLineList[index].chapterName.toString();
                  Navigator.pop(context);
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => MyTimeTableViedo(
                      liveStreamData.apexLink!.hlsURL.toString(),
                      myCourseTimeLineList[index].title.toString(),
                      liveStreamData.id.toString())));
                },
                title: getTranslated(context, LangString.Normal),
              ),
              SizedBox(
                height: 10,
              ),
              CustomButtonLive(
                onPressed: (){
                  AppConstants.videoQuality ='240p';
                  AppConstants.chapterName =myCourseTimeLineList[index].chapterName.toString();
                  Navigator.pop(context);
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => MyTimeTableViedo(
                      liveStreamData.apexLink!.hls240pURL.toString(),
                      myCourseTimeLineList[index].title.toString(),
                      liveStreamData.id.toString()),));
                },
                title: '240p',
              ),
              SizedBox(
                height: 10,
              ),
              CustomButtonLive(
                onPressed: (){
                  AppConstants.videoQuality ='360p';
                  AppConstants.chapterName =myCourseTimeLineList[index].chapterName.toString();
                  Navigator.pop(context);
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) =>MyTimeTableViedo(
                      liveStreamData.apexLink!.hls360pURL.toString(),
                      myCourseTimeLineList[index].title.toString(),
                      liveStreamData.id.toString()),));
                },
                title: '360p',
              ),
              SizedBox(
                height: 10,
              ),
              CustomButtonLive(
                onPressed: (){
                  AppConstants.videoQuality ='480p';
                  AppConstants.chapterName =myCourseTimeLineList[index].chapterName.toString();
                  Navigator.pop(context);
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) =>MyTimeTableViedo(
                      liveStreamData.apexLink!.hls480pURL.toString(),
                      myCourseTimeLineList[index].title.toString(),
                      liveStreamData.id.toString()),));
                },
                title: '480p',
              ),
              SizedBox(
                height: 10,
              ),
              CustomButtonLive(
                onPressed: (){
                  AppConstants.videoQuality ='720p';
                  AppConstants.chapterName =myCourseTimeLineList[index].chapterName.toString();
                  Navigator.pop(context);
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) =>MyTimeTableViedo(
                      liveStreamData.apexLink!.hls720pURL.toString(),
                      myCourseTimeLineList[index].title.toString(),
                      liveStreamData.id.toString()),));
                },
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

class CustomButtonLive extends StatelessWidget {
  final String? image;
  final String? title;
  final VoidCallback onPressed;
  final Color? color;

  CustomButtonLive(
      {@required this.image,
        @required this.title,
        required this.onPressed,
        this.color});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width - 60;
    return InkWell(
        onTap: () {
          onPressed();
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
