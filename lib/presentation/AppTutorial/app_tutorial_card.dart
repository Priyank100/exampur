import 'package:exampur_mobile/Localization/language_constrants.dart';
import 'package:exampur_mobile/data/model/appp_toutorial.dart';
import 'package:exampur_mobile/shared/youtube_video.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:exampur_mobile/utils/dimensions.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AppTutorialCard extends StatefulWidget {
  final Data listData;
  final int index;
  const AppTutorialCard(this.listData, this.index) : super();

  @override
  _AppTutorialCardState createState() => _AppTutorialCardState();
}

class _AppTutorialCardState extends State<AppTutorialCard> {



  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.index % 2 == 0
          ? Theme.of(context).backgroundColor
          : AppColors.transparent,
      //margin: EdgeInsets.all(5),
      // child: Card(
      //   elevation: 2,
        child: Padding(
          padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
            child: Row(
              children: [
                Container(
                  width: Dimensions.AppTutorialImageWidth,
                  height: Dimensions.AppTutorialImageHeight,
                  // child: Image.network(API.homeBanner_URL + widget.listData.imagePath.toString(), fit: BoxFit.fill)
                  child: widget.listData.imagePath.toString().contains('http') ?
                  AppConstants.image(widget.listData.imagePath.toString(), boxfit: BoxFit.fill) :
                  AppConstants.image(AppConstants.BANNER_BASE + widget.listData.imagePath.toString(), boxfit: BoxFit.fill)
                ),
                SizedBox(width: 10),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.listData.title.toString(),overflow: TextOverflow.ellipsis, maxLines: 2,),
                      Container(
                        width: Dimensions.WatchButtonWidth,
                        child: MaterialButton(
                          color: AppColors.red,
                          child: Row(
                            children: [
                              Icon(Icons.play_arrow, color: AppColors.white,),
                              Text(getTranslated(context, StringConstant.watch)!, style: new TextStyle(fontSize: 16.0, color: AppColors.white))
                            ],
                          ),
                          onPressed: () {

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => YoutubeVideo(widget.listData.videoLink.toString(),
                                        widget.listData.title.toString())));
                          },
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
        ),
     // ),
    );
  }
}
