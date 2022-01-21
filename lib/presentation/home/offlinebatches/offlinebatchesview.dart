import 'package:exampur_mobile/Localization/language_constrants.dart';
import 'package:exampur_mobile/data/model/offlinebatches_courses_video.dart';
import 'package:exampur_mobile/provider/Offline_batchesProvider.dart';
import 'package:exampur_mobile/utils/appBar.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:exampur_mobile/utils/images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:provider/provider.dart';

class OfflineBatchesVideo extends StatefulWidget {
  final String id;
  const OfflineBatchesVideo(this.id) : super();

  @override
  _OfflineBatchesVideoState createState() => _OfflineBatchesVideoState();
}

class _OfflineBatchesVideoState extends State<OfflineBatchesVideo> {
  String videoID = '';
  late YoutubePlayerController _controller;
  OfflinebatchesCoursesVideo centerCoursesModel = OfflinebatchesCoursesVideo();

  @override
  void initState() {
    callProvider();
  }

  void callProvider() async {
    AppConstants.printLog('Anchal>'+widget.id);
    centerCoursesModel =
    (await Provider.of<OfflinebatchesProvider>(context, listen: false).getOfflineBatchCenterCoursesVideoData(context, widget.id))!;
    AppConstants.printLog('Anchal>'+ centerCoursesModel.data!.amount.toString());

    try {
      videoID = YoutubePlayer.convertUrlToId(centerCoursesModel.data!.videoPath.toString())!;
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
      print(exception);
      videoID = '';
    } catch (error) {
      print(error);
      videoID = '';
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: MediaQuery.of(context).orientation == Orientation.landscape ? null : CustomAppBar(),
      appBar: CustomAppBar(),
      body: videoID.isEmpty ? Center(child: CircularProgressIndicator()) :
      Container(
        child: Column(
          children: [
            YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: true,
              progressIndicatorColor: Colors.amber,
            ),
            SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(centerCoursesModel.data!.title.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(centerCoursesModel.data!.description.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.normal, fontSize: 12)),
            )
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '\u{20B9}  ${-1}',
              style: TextStyle(color: AppColors.black, fontSize: 25),
            ),
            InkWell(
              onTap: () {
                _settingModalBottomSheet(context);
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                height: 50,
                width: 120,
                child: Center(
                    child: Text(
                      getTranslated(context, 'buy')!,
                      style: TextStyle(color: AppColors.white),
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _settingModalBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            height: 180,
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'pay via:',
                  style: TextStyle(color: AppColors.grey400),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 50,
                  width: 160,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                      border: Border.all(color: AppColors.black, width: 1)),
                  padding: EdgeInsets.all(8),
                  child: Row(
                    children: [
                      Image.asset(
                        Images.paidcourse,
                        height: 15,
                        width: 15,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        'Pay Online',
                        style: TextStyle(color: AppColors.black),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10,),
                Container(height: 40,width: 120,
                  //padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.all(Radius.circular(7))),
                  child: Center(
                    child: Text(
                      'Apply coupon',
                      style: TextStyle(color: AppColors.white),
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }
// @override
// void dispose() {
//   _controller.dispose();
//   SystemChrome.setPreferredOrientations([
//     DeviceOrientation.portraitUp,
//   ]);
//   super.dispose();
// }
}
