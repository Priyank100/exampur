import 'package:exampur_mobile/Localization/language_constrants.dart';
import 'package:exampur_mobile/data/model/demo_model.dart';
import 'package:exampur_mobile/presentation/widgets/custom_button_amber_color_watch.dart';
import 'package:exampur_mobile/shared/youtube_video.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:exampur_mobile/utils/dimensions.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class DemoContainer extends StatefulWidget {
  final List<Datum> demoList;
  final int index;
  const DemoContainer(this.demoList,this.index) : super();

  @override
  _DemoContainerState createState() => _DemoContainerState();
}

class _DemoContainerState extends State<DemoContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      //color: AppColors.amber,
            margin: EdgeInsets.all(5),
     child: Padding(
       padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
       child: Row(
         children: [
           Container(
               width: Dimensions.AppTutorialImageWidth,
               height: Dimensions.AppTutorialImageHeight,
               // child: Image.network(AppConstants.BANNER_BASE+widget.demoList[widget.index].bannerPath.toString(), fit: BoxFit.fill)
               child: AppConstants.image(AppConstants.BANNER_BASE+widget.demoList[widget.index].logoPath.toString(), boxfit: BoxFit.fill)
           ),
           SizedBox(width: 10),
           Flexible(
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Text(widget.demoList[widget.index].subjectId!.title.toString()+' || '+widget.demoList[widget.index].title.toString(),overflow: TextOverflow.ellipsis, maxLines: 2,),
                 SizedBox(height: 25,),
                 Row(
                   children: [
                     CustomAmberButton(onPressed: ()async {
                       await   FirebaseAnalytics.instance.logEvent(name: 'Demo_Details_Clicks_',parameters: {
                         'Course_id':widget.demoList[widget.index].id.toString().replaceAll(' ', '_'),
                         'Course_title':widget.demoList[widget.index].title.toString().replaceAll(' ', '_')
                       });

     Navigator.push(
     context,
     MaterialPageRoute(
     builder: (context) =>YoutubeVideo(widget.demoList[widget.index].targetLink.toString(),widget.demoList[widget.index].title.toString())));
     },text:getTranslated(context, StringConstant.watch)!,),


                   ],
                 ),
               ],
             ),
           )
         ],
       ),
     ),
    );
  }

}

