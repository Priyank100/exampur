import 'package:exampur_mobile/Localization/language_constrants.dart';
import 'package:exampur_mobile/data/model/demo_models.dart';
import 'package:exampur_mobile/utils/appBar.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class DemoViedoView extends StatefulWidget {
  final Datum demoList;

  const DemoViedoView(this.demoList) : super();

  @override
  _DemoViedoViewState createState() => _DemoViedoViewState();
}

class _DemoViedoViewState extends State<DemoViedoView> {
  String videoID = '';
  late YoutubePlayerController _controller;

  @override
  void initState() {
    try {
      videoID =
          YoutubePlayer.convertUrlToId(widget.demoList.targetLink.toString())!;
      _controller = YoutubePlayerController(
        initialVideoId: videoID,
        flags: YoutubePlayerFlags(
          hideControls: false,
          controlsVisibleAtStart: true,
          autoPlay: true,
          mute: false,
        ),
      );
    } on Exception catch (exception) {
      AppConstants.printLog(exception.toString());
      videoID = '';
    } catch (error) {
      AppConstants.printLog(error.toString());
      videoID = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MediaQuery.of(context).orientation == Orientation.landscape
          ? null
          : CustomAppBar(),
      // appBar: CustomAppBar(),
      body: MediaQuery.of(context).orientation == Orientation.landscape
          ? YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
        progressIndicatorColor: Colors.amber,
      )
          : Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: true,
              progressIndicatorColor: Colors.amber,
            ),
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Text(widget.demoList.title.toString(),
                  textAlign: TextAlign.center,
                  softWrap: true,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            ),
            SizedBox(
              height: 30,
            ),
            Center(
                child: InkWell(
                    onTap: () {

                    },
                    child: Container(
                      height: 50,
                      width: 350,
                        decoration: BoxDecoration( color: Colors.amber,
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          )),

                      child: Center(
                          child: Text(
                        getTranslated(context, StringConstant.downloadVideo)!,
                        softWrap: true,
                        style: TextStyle(color: Colors.white,fontSize: 16),
                      )),
                    ))),
          ],
        ),
      ),
    );
  }
}
