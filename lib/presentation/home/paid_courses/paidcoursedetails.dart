import 'package:exampur_mobile/data/model/paid_course_model.dart';
import 'package:exampur_mobile/utils/appBar.dart';
import 'package:exampur_mobile/utils/images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class PaidCourseDetails extends StatefulWidget {
  final Courses paidcourseList;

  const PaidCourseDetails(this.paidcourseList) : super();

  @override
  _PaidCourseDetailsState createState() => _PaidCourseDetailsState();
}

class _PaidCourseDetailsState extends State<PaidCourseDetails> {
  String videoID = '';
  late YoutubePlayerController _controller;

  @override
  void initState() {
    try {
      videoID = YoutubePlayer.convertUrlToId(
          widget.paidcourseList.videoPath.toString())!;
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: true,
              progressIndicatorColor: Colors.amber,
            ),
            //SizedBox(height: 20),
            Flexible(
                child: Padding(
              padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: Text(widget.paidcourseList.title.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            )),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
                child: Text(widget.paidcourseList.description.toString(),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                        color: Colors.grey)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5, left: 20, right: 20),
              child: Row(
                children: [
                  Text(
                    '\u{20B9}',
                    style: TextStyle(color: Colors.black, fontSize: 25),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    widget.paidcourseList.amount.toString(),
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                _BuyCourseBottomSheet(
                  context,
                );
              },
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                height: 50,
                margin: EdgeInsets.all(28),
                child: Center(
                    child: Text(
                  'Buy Course',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                )),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _BuyCourseBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        elevation: 0,
        //barrierColor: Colors.black.withAlpha(1),
        backgroundColor: Colors.transparent,
        builder: (BuildContext bc) {

          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(28),topRight: Radius.circular(28)),
                color: Colors.white   ),



           // padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
            Container(
              height: 20,
            width: double.infinity,
            decoration: BoxDecoration(

            borderRadius: BorderRadius.only(topLeft: Radius.circular(28),topRight: Radius.circular(28)),
          color: Colors.amber   ),),
                Padding(
                  padding: const EdgeInsets.all(19.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.paidcourseList.title.toString(),
                        style: TextStyle(fontSize: 20),
                      ),
SizedBox(height: 10,),

                ClipRRect(
                      borderRadius: BorderRadius.all( Radius.circular(10),
                        // bottomRight: Radius.circular(20),
                        // bottomLeft: Radius.circular(20),
                      ),
                      child: Container(
                        //padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            )),
                        width: double.infinity,
                        height: 200,
                        child: FadeInImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                             widget.paidcourseList.bannerPath.toString()
                          ),
                          placeholder: AssetImage(Images.noimage),


                        ),

                      ),
                    ),
                      SizedBox(height: 10,),
                  Text(
                    widget.paidcourseList.title.toString(),maxLines: 2,
                    style: TextStyle(fontSize: 20),
                  ),

                      Row(
                        children: [
                          Text(
                            '\u{20B9}',
                            style: TextStyle(color: Colors.black, fontSize: 25),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                           widget.paidcourseList.amount.toString(),
                            style: TextStyle(color: Colors.black, fontSize: 18),
                          ),
                        ],
                      ),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: (){
                          showModalBottomSheet(context: context, isScrollControlled: true, backgroundColor: Colors.transparent, builder: (context) =>Bottomsheet());
                          // _SkipBottomSheet(
                          //   context,
                          // );
                        },
                        child: Container(
                          height: 50,
                          width: 100,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(8),
                              ),
                              border: Border.all(color: Colors.amber, width: 2)),
                          padding: EdgeInsets.all(8),
                          child:
                              Center(
                                child: Text(
                                  'Skip',
                                  style: TextStyle(color: Colors.amber,fontSize: 20),
                                ),
                              ),

                        ),
                      ),
                      Container(
                        height: 50, width: 100,
                        //padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.all(Radius.circular(7))),
                        child: Center(
                          child: Text(
                            'Add',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      )
                    ],
                  ),

                   ],
                  ),
                ),
              ],
            ),
          );
        });}
    void _SkipBottomSheet(context) {
      showModalBottomSheet(
          context: context,
          builder: (BuildContext bc) {
            bool visibilityObs = false;
            void _changed(bool visibility, String field) {
              setState(() {
                if (field == "obs"){
                  visibilityObs = visibility;
                }

              });
            }
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
                  InkWell(
                    onTap: (){
                      visibilityObs ? null : _changed(true, "obs");
                    },
                    child: Container(height: 40,width: 120,
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
                    ),
                  ),
                  visibilityObs ? new Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      new Expanded(
                        flex: 11,
                        child: new TextField(
                          maxLines: 1,
                          // style: Theme.of(context).textTheme.title,
                          decoration: new InputDecoration(
                              labelText: "Observation",
                              isDense: true
                          ),
                        ),
                      ),
                      new Expanded(
                        flex: 1,
                        child: new IconButton(
                          color: Colors.grey[400],
                          icon: const Icon(Icons.cancel, size: 22.0,),
                          onPressed: () {
                            _changed(false, "obs");
                          },
                        ),
                      ),
                    ],
                  ) : new Container(),
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
class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => new HomePageState();
}

class HomePageState extends State<HomePage> {
  bool visibilityTag = false;
  bool visibilityObs = false;

  void _changed(bool visibility, String field) {
    setState(() {
      if (field == "tag"){
        visibilityTag = visibility;
      }
      if (field == "obs"){
        visibilityObs = visibility;
      }
    });
  }

  @override
  Widget build(BuildContext context){
    return new Scaffold(
        appBar: new AppBar(backgroundColor: new Color(0xFF26C6DA)),
        body: new ListView(
        children: <Widget>[
    //     new Container(
    //     margin: new EdgeInsets.all(20.0),
    // child: new FlutterLogo(size: 100.0, colors: Colors.blue),
    // ),
    new Container(
    margin: new EdgeInsets.only(left: 16.0, right: 16.0),
    child: new Column(
    children: <Widget>[
    visibilityObs ? new Row(
    crossAxisAlignment: CrossAxisAlignment.end,
    children: <Widget>[
    new Expanded(
    flex: 11,
    child: new TextField(
    maxLines: 1,
   // style: Theme.of(context).textTheme.title,
    decoration: new InputDecoration(
    labelText: "Observation",
    isDense: true
    ),
    ),
    ),
    new Expanded(
    flex: 1,
    child: new IconButton(
    color: Colors.grey[400],
    icon: const Icon(Icons.cancel, size: 22.0,),
    onPressed: () {
    _changed(false, "obs");
    },
    ),
    ),
    ],
    ) : new Container(),

    visibilityTag ? new Row(
    crossAxisAlignment: CrossAxisAlignment.end,
    children: <Widget>[
    new Expanded(
    flex: 11,
    child: new TextField(
    maxLines: 1,
    //style: Theme.of(context).textTheme.title,
    decoration: new InputDecoration(
    labelText: "Tags",
    isDense: true
    ),
    ),
    ),
    new Expanded(
    flex: 1,
    child: new IconButton(
    color: Colors.grey[400],
    icon: const Icon(Icons.cancel, size: 22.0,),
    onPressed: () {
    _changed(false, "tag");
    },
    ),
    ),
    ],
    ) : new Container(),
    ],
    )
    ),
    new Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
    new InkWell(
    onTap: () {
    visibilityObs ? null : _changed(true, "obs");
    },
    child: new Container(
    margin: new EdgeInsets.only(top: 16.0),
    child: new Column(
    children: <Widget>[
    new Icon(Icons.comment, color: visibilityObs ? Colors.grey[400] : Colors.grey[600]),
    new Container(
    margin: const EdgeInsets.only(top: 8.0),
    child: new Text(
    "Observation",
    style: new TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.w400,
    color: visibilityObs ? Colors.grey[400] : Colors.grey[600],
    ),
    ),
    ),
    ],
    ),
    )
    ),
    new SizedBox(width: 24.0),
    new InkWell(
    onTap: () {
    visibilityTag ? null : _changed(true, "tag");
    },
    child: new Container(
    margin: new EdgeInsets.only(top: 16.0),
    child: new Column(
    children: <Widget>[
    new Icon(Icons.local_offer, color: visibilityTag ? Colors.grey[400] : Colors.grey[600]),
    new Container(
    margin: const EdgeInsets.only(top: 8.0),
    child: new Text(
    "Tags",
    style: new TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.w400,
    color: visibilityTag ? Colors.grey[400] : Colors.grey[600],
    ),
    ),
    ),
    ],
    ),
    )
    ),
    ],
    )
        ],
        )
    );
  }
}


class Bottomsheet extends StatefulWidget {
  const Bottomsheet({Key? key}) : super(key: key);

  @override
  _BottomsheetState createState() => _BottomsheetState();
}

class _BottomsheetState extends State<Bottomsheet> {

  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 210,
      color: Colors.white,
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
            width: 300,
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
          InkWell(
            onTap: (){
              setState(() {
                isVisible = !isVisible;
              });
             // visibilityObs ? null : _changed(true, "obs");
            },
            child: Container(height: 40,width: 120,
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
            ),
          ),
          SizedBox(height: 10,),
          Visibility(
            visible: isVisible,
            maintainSize: true,
            maintainAnimation: true,
            maintainState: true,
            child: Row(crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Expanded(
                    flex:4,
                    child: Container(
                      width: 100,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],

                        borderRadius:  BorderRadius.all(const Radius.circular(12)),
                        //       border: Border(
                        //   left: BorderSide(10)
                        // ),
                        boxShadow: [
                          BoxShadow(color: Colors.grey.withOpacity(0.1), spreadRadius: 1, blurRadius: 3, offset: Offset(0, 1)) // changes position of shadow
                        ],
                      ),
                      child: TextField(
                        maxLines: 1,
                        // style: Theme.of(context).textTheme.title,
                        decoration: new InputDecoration(

                            isDense: true,
                          fillColor: Colors.grey.withOpacity(0.1),border: InputBorder.none
                        ),
                      ),

                    ),
                  ),
                  SizedBox(width: 20,),
                  Expanded(
                    flex:1,
                    child: Container(
                      height: 30,color: Colors.amber,child: Center(child: Text('Apply',style: TextStyle(color: Colors.white),)),
                    ),
                  )
            ])
          ),

        ],
      ),
    );
  }
}
