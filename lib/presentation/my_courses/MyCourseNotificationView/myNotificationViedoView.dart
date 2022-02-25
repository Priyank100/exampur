import 'package:exampur_mobile/Localization/language_constrants.dart';
import 'package:exampur_mobile/data/model/my_course_notification_model.dart';
import 'package:exampur_mobile/utils/appBar.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MyNotificationViedo extends StatefulWidget {
  final NotificationData notificationList;
  MyNotificationViedo(this.notificationList) : super();

  @override
  _MyNotificationViedoState createState() => _MyNotificationViedoState();
}

class _MyNotificationViedoState extends State<MyNotificationViedo> {
  String videoID = '';
  late YoutubePlayerController _controller;

  late String firstHalf;
  late String secondHalf;

  bool flag = true;



  @override
  void initState() {

    try {
      videoID = YoutubePlayer.convertUrlToId(widget.notificationList.action.toString())!;
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
      appBar: MediaQuery.of(context).orientation == Orientation.landscape ? null : CustomAppBar(),
      //appBar: CustomAppBar(),
      body: MediaQuery.of(context).orientation == Orientation.landscape ?  YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
        progressIndicatorColor: AppColors.amber,
      ) : Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: true,
              progressIndicatorColor: AppColors.amber,
            ),
            SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(widget.notificationList.title.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            ),


          ],
        ),
      ),

    );
  }




  @override
  void dispose() {
    _controller.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    super.dispose();
  }
}

