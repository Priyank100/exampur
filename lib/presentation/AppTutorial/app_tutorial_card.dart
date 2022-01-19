import 'package:exampur_mobile/Localization/language_constrants.dart';
import 'package:exampur_mobile/data/model/app_tutorial_model.dart';
import 'package:exampur_mobile/data/model/appp_toutorial.dart';
import 'package:exampur_mobile/presentation/AppTutorial/app_tutorial_video.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:exampur_mobile/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AppTutorialCard extends StatefulWidget {
  final List<Data> apptutorialList;
  final int index;
  const AppTutorialCard(this.apptutorialList, this.index) : super();

  @override
  _AppTutorialCardState createState() => _AppTutorialCardState();
}

class _AppTutorialCardState extends State<AppTutorialCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.index % 2 == 0
          ? Theme.of(context).backgroundColor
          : Colors.transparent,
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
                  child: Image.network(API.homeBanner_URL+widget.apptutorialList[widget.index].imagePath.toString(), fit: BoxFit.fill)
                ),
                SizedBox(width: 10),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.apptutorialList[widget.index].title.toString(),overflow: TextOverflow.ellipsis, maxLines: 2,),
                      Container(
                        width: Dimensions.WatchButtonWidth,
                        child: MaterialButton(
                          color: Colors.red,
                          child: Row(
                            children: [
                              Icon(Icons.play_arrow, color: Colors.white,),
                              Text(getTranslated(context, 'watch')!, style: new TextStyle(fontSize: 16.0, color: Colors.white))
                            ],
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AppTutorialVideo(widget.apptutorialList[widget.index].videoLink.toString(),
                                        widget.apptutorialList[widget.index].title.toString())));
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
