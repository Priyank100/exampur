import 'package:exampur_mobile/utils/appBar.dart';
import 'package:exampur_mobile/utils/images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class One2OneVideo extends StatefulWidget {
  final String videoPath;
  final String title;
  const One2OneVideo(this.videoPath, this.title) : super();

  @override
  _One2OneVideoState createState() => _One2OneVideoState();
}

class _One2OneVideoState extends State<One2OneVideo> {
  String videoID = '';
  late YoutubePlayerController _controller;

  @override
  void initState() {
    try {
      videoID = YoutubePlayer.convertUrlToId(widget.videoPath)!;
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: MediaQuery.of(context).orientation == Orientation.landscape ? null : CustomAppBar(),
      appBar: CustomAppBar(),
      body: Container(
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
              child: Text(widget.title,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
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
              style: TextStyle(color: Colors.black, fontSize: 25),
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
                  'Buy',
                  style: TextStyle(color: Colors.white),
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
                  style: TextStyle(color: Colors.grey.shade400),
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
                      border: Border.all(color: Colors.black, width: 1)),
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
                        style: TextStyle(color: Colors.black),
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
                      style: TextStyle(color: Colors.white),
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
