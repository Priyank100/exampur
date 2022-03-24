import 'dart:convert';

import 'package:chewie/chewie.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exampur_mobile/Localization/language_constrants.dart';
import 'package:exampur_mobile/SharePref/shared_pref.dart';
import 'package:exampur_mobile/data/model/my_course_timeline_model.dart';
import 'package:exampur_mobile/presentation/widgets/custom_text_field.dart';
import 'package:exampur_mobile/utils/appBar.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MyTimeTableViedo extends StatefulWidget {
String url;
String title;
String videoId;
  MyTimeTableViedo(this.url,this.title,this.videoId) : super();

  @override
  _MyTimeTableViedoState createState() => _MyTimeTableViedoState();
}

class _MyTimeTableViedoState extends State<MyTimeTableViedo> {
  String collectionName = 'live_chat';
  String userName = '';
  String userPhone = '';
 // String videoId = '';
  String videoTitle = '';
  TextEditingController _sendchat = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  Map<String, dynamic> map = Map();
  late VideoPlayerController videoPlayerController;
  late ChewieController chewieController;



  Future<bool> checkIfDocExists(String docId) async {
    try {
      // Get reference to Firestore collection
      var collectionRef = FirebaseFirestore.instance.collection(collectionName);
      var doc = await collectionRef.doc(docId).get();
      return doc.exists;
    } catch (e) {
      throw e;
    }
  }

  Future<void> addVideoTitle(String text) async {
    String time = DateFormat('hh:mm:ss a').format(DateTime.now());
    if(text.isNotEmpty) {

      bool docExists = await checkIfDocExists(widget.videoId);

      if(docExists) {
        FirebaseFirestore firestoreInstance = FirebaseFirestore.instance;
        firestoreInstance.collection(collectionName).doc(widget.videoId).update(
            {
              'chat.$userName-$userPhone-$time': text
            }).then((value) {
          _sendchat.text = '';
          setState(() {

          });
        });

      } else {
        FirebaseFirestore.instance.collection(collectionName).doc(widget.videoId).set(
            {
              'id': widget.videoId,
              'title': widget.title.toString(),
              'chat': {
                '$userName-$userPhone-$time': text
              }
            }, SetOptions(merge : false)).then((value) {
          _sendchat.text = '';
          setState(() {

          });
        });
      }
    } else {
      AppConstants.showBottomMessage(context, 'Enter message', AppColors.black);
    }
  }
  void getChat() {
    map.clear();
    try {
      FirebaseFirestore.instance
          .collection(collectionName)
          .where("id", isEqualTo: widget.videoId)
          .snapshots()
          .listen((result) {
        result.docChanges.forEach((res) {
          map.addAll(res.doc.data()!['chat']);
          AppConstants.printLog('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>');
          AppConstants.printLog(map);
          setState(() {

          });
        });
      });
    } catch(ex) {
      AppConstants.printLog(ex.toString());
    }
  }





  Future<void> getSharedPrefData() async {
    var jsonValue = jsonDecode(
        await SharedPref.getSharedPref(SharedPrefConstants.USER_DATA));
    // AppConstants.printLog('priyank>> ${jsonValue.toString()}');
    userName = jsonValue[0]['data']['first_name'].toString();
    userPhone = jsonValue[0]['data']['phone'].toString();
    setState(() {});
  }
  @override
  void initState() {
    super.initState();
    getChat();
    getSharedPrefData();
    videoPlayerController = VideoPlayerController.network(widget.url);
    chewieController = ChewieController(
      cupertinoProgressColors: ChewieProgressColors(),
      videoPlayerController: videoPlayerController,
        aspectRatio: 16/9,
      autoPlay: true,
      looping: true,
        errorBuilder: (context, errorMessage) {
          return Center(
            child: Text("Video unavanilable",style: TextStyle(color: AppColors.white),),
          );
        });

  }
  @override
  void dispose() {
    videoPlayerController.dispose();
    chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        physics:ClampingScrollPhysics(parent: NeverScrollableScrollPhysics()),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           // SizedBox(height: 8,),
            Container(
             //padding: EdgeInsets.only(top: 8),

              height: (MediaQuery.of(context).size.width)/16*9,
            //  height: MediaQuery.of(context).size.height*0.4,
              //width: MediaQuery.of(context).size.width,
              child: Chewie(
                  controller: chewieController
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child:   Text(widget.title,style: TextStyle(fontSize: 15),),
            ),
            Divider(thickness: 1,),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Text(getTranslated(context, StringConstant.LiveChat)!,style: TextStyle(fontSize: 18)),
            ),
            Divider(thickness: 1,),
            Container(
              margin: EdgeInsets.all(5),
              //height: MediaQuery.of(context).size.height*0.35,
              height: MediaQuery.of(context).size.height*0.43,
              //height: 400,
              child:
              ListView.builder(
                itemCount: map.length,
                //controller: _scrollController,
                reverse: true,
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  String key = map.keys.elementAt(map.length-1-index);
                  var parts = key.split('-');
                  var name = parts[0].trim();
                  var times =parts[2].trim();

                  var sec = times.split(':');
                  var second1 = sec[0].trim();
                  var second2 = sec[2].trim();
                  return new Column(
                    children: <Widget>[
                      Container(
                        //height: 40,
                          child:Padding(
                            padding: const EdgeInsets.only(left: 12,top: 5,right: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    new Text(name,style: TextStyle(fontSize: 12,color: AppColors.green),),
                                    new Text(second1+':'+second2,style: TextStyle(color: AppColors.grey,fontSize: 12),),

                                  ],
                                ),
                                Text("${map[key]}",style: TextStyle(fontSize: 14))
                              ],),
                          )
                      ),

                      new Divider(
                        height: 2.0,
                      ),
                    ],
                  );
                },
              ),
            )

          ],
        ),
      ),
        bottomNavigationBar: Container(
          padding: MediaQuery.of(context).viewInsets,
          color: AppColors.transparent,
          child:  Row(
            children: [
              Expanded(child: CustomTextField(

                  hintText: getTranslated(context, StringConstant.TypeYourDoubtHere)!,
                  controller: _sendchat,
                  value: (value) {}),
              ),

              InkWell(
                onTap: () {
                  FocusScope.of(context).unfocus();

                  //_animateToIndex(height) => _scrollController.animateTo(height, duration: Duration(seconds: 2), curve: Curves.fastOutSlowIn);
                  addVideoTitle(_sendchat.text.toString());
                },
                child: Container(
                  // padding: EdgeInsets.all(8),
                    margin: EdgeInsets.all(8),
                    height: 45,
                    width: 90,
                    decoration: BoxDecoration(color: AppColors.amber,borderRadius:  BorderRadius.all(const Radius.circular(8)),),

                    child: Center(child: Text(getTranslated(context, StringConstant.Send)!,style: TextStyle(color: AppColors.white),))
                ),
              )

            ],
          ),)
    );
  }
}

