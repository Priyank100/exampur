
import 'package:exampur_mobile/data/model/one2_one_models.dart';
import 'package:exampur_mobile/utils/appBar.dart';
import 'package:exampur_mobile/utils/images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class One2OneVideo extends StatefulWidget {
  final Courses one2oneList;

  const One2OneVideo(this.one2oneList) : super();

  @override
  _One2OneVideoState createState() => _One2OneVideoState();
}

class _One2OneVideoState extends State<One2OneVideo> {
  String videoID = '';
  late YoutubePlayerController _controller;

  late String firstHalf;
  late String secondHalf;

  bool flag = true;



  @override
  void initState() {
    if ( widget.one2oneList.description!.length > 150) {
      firstHalf = widget.one2oneList.description! .substring(0, 150);
      secondHalf = widget.one2oneList.description! .substring(150,  widget.one2oneList.description! .length);
    } else {
      firstHalf =  widget.one2oneList.description! ;
      secondHalf = "";
    }
    try {
      videoID = YoutubePlayer.convertUrlToId(widget.one2oneList.videoPath.toString())!;
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
       appBar: MediaQuery.of(context).orientation == Orientation.landscape ? null : CustomAppBar(),
      //appBar: CustomAppBar(),
      body: MediaQuery.of(context).orientation == Orientation.landscape ?  YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
        progressIndicatorColor: Colors.amber,
      ) : Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: true,
              progressIndicatorColor: Colors.amber,
               ),
            SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(widget.one2oneList.title.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          ),

            Container(
              padding: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              child: secondHalf.isEmpty
                  ? new Text(firstHalf, style: new TextStyle(color: Colors.grey,fontSize: 12),)
                  : new Column(
                children: <Widget>[
                  new Text(flag ? (firstHalf + "...") : (firstHalf + secondHalf), style: new TextStyle(color: Colors.grey.shade600,fontSize: 13),),
                  new InkWell(
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        new Text(
                          flag ? "show more" : "show less",
                          style: new TextStyle(color: Colors.blue.shade300,fontSize: 12),
                        ),
                      ],
                    ),
                    onTap: () {
                      setState(() {
                        flag = !flag;
                      });
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar:MediaQuery.of(context).orientation == Orientation.landscape ?  null: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '\u{20B9}  ${widget.one2oneList.amount}',
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
@override
void dispose() {
  _controller.dispose();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  super.dispose();
}
}
