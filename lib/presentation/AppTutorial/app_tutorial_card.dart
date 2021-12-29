import 'package:exampur_mobile/data/model/app_tutorial_model.dart';
import 'package:exampur_mobile/presentation/AppTutorial/app_tutorial_video.dart';
import 'package:exampur_mobile/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AppTutorialCard extends StatefulWidget {
  final List<AppTutorialModel> list;
  final int index;
  const AppTutorialCard(this.list, this.index) : super();

  @override
  _AppTutorialCardState createState() => _AppTutorialCardState();
}

class _AppTutorialCardState extends State<AppTutorialCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      child: Card(
        elevation: 2,
        child: Padding(
          padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
            child: Row(
              children: [
                Container(
                  width: Dimensions.AppTutorialImageWidth,
                  height: Dimensions.AppTutorialImageHeight,
                  child: Image.asset(widget.list[widget.index].imagePath.toString(), fit: BoxFit.fill)
                ),
                SizedBox(width: 10),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.list[widget.index].title.toString(),overflow: TextOverflow.ellipsis, maxLines: 2,),
                      Container(
                        width: Dimensions.WatchButtonWidth,
                        child: MaterialButton(
                          color: Colors.red,
                          child: Row(
                            children: [
                              Icon(Icons.play_arrow, color: Colors.white,),
                              Text(' Watch', style: new TextStyle(fontSize: 16.0, color: Colors.white))
                            ],
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AppTutorialVideo(widget.list[widget.index].videoPath.toString(),
                                        widget.list[widget.index].title.toString())));
                          },
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
        ),
      ),
    );
  }
}
