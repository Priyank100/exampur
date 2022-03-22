import 'package:exampur_mobile/Localization/language_constrants.dart';
import 'package:exampur_mobile/SharePref/shared_pref.dart';
import 'package:exampur_mobile/provider/MyCourseProvider.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:exampur_mobile/data/model/course_timeline_live_stream_model.dart';
import 'TimeTableVideo.dart';
import 'package:provider/provider.dart';
class AlertStream extends StatefulWidget {
  String timelineId ;
AlertStream(this.timelineId) : super();

  @override
  State<AlertStream> createState() => _AlertStreamState();
}

class _AlertStreamState extends State<AlertStream> {
  Data liveStreamData = Data();

  Future<void> callLiveStream() async {
    String token = await SharedPref.getSharedPref(SharedPrefConstants.TOKEN);
    liveStreamData = (await Provider.of<MyCourseProvider>(context, listen: false).getMyCourseTimeLineLiveStream(context, widget.timelineId, token))!;
   print('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>');
   print(liveStreamData.id.toString());
    setState(() {});
   }
@override
  void initState() {
     callLiveStream();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // print('anchal'+liveStreamData!.isDemo.toString());
    return Scaffold(
      backgroundColor: AppColors.white38,
      body: AlertDialog(
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
            CustomButton(navigateTo:MyTimeTableViedo() ,title: '480p',),
            SizedBox(height: 10,),
            CustomButton(navigateTo:MyTimeTableViedo() ,title: '360p',),
            SizedBox(height: 10,),
            CustomButton(navigateTo: MyTimeTableViedo(),title: '240p',),
            SizedBox(height: 10,),
            CustomButton(navigateTo: MyTimeTableViedo() ,title: '720p',),
            SizedBox(height: 10,),
            // CustomButton(navigateTo:MyTimeTableViedo() ,title: getTranslated(context, StringConstant.audioOnly)!,),
            // SizedBox(height: 10,),

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
      ),
    );
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