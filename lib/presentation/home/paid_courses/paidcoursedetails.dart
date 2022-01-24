import 'package:exampur_mobile/Localization/language_constrants.dart';
import 'package:exampur_mobile/data/model/paid_course_model.dart';
import 'package:exampur_mobile/presentation/DeliveryDetail/delivery_detail_screen.dart';
import 'package:exampur_mobile/utils/appBar.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
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
     // resizeToAvoidBottomInset: true,
       appBar: MediaQuery.of(context).orientation == Orientation.landscape ? null : CustomAppBar(),
     // appBar: CustomAppBar(),
      body:MediaQuery.of(context).orientation == Orientation.landscape ? YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
        progressIndicatorColor: Colors.amber,
      ): Container(
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
                        color: AppColors.grey)),
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
                showModalBottomSheet(context: context, isScrollControlled: true, backgroundColor: Colors.transparent, builder: (context) =>BottomSheeet1(widget.paidcourseList));
                // _BuyCourseBottomSheet(
                //   context,
                // );
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
                      getTranslated(context, 'buy_course')!,
                  style: TextStyle(color: Colors.white, fontSize: 18),
                )),
              ),
            )
          ],
        ),
      ),
    );
  }




// @override
// void dispose() {
//   _controller.dispose();
//   SystemChrome.setPreferredOrient
//   ations([
//     DeviceOrientation.portraitUp,
//   ]);
//   super.dispose();
// }
}


class Bottomsheet2 extends StatefulWidget {
  const Bottomsheet2({Key? key}) : super(key: key);

  @override
  _Bottomsheet2State createState() => _Bottomsheet2State();
}

class _Bottomsheet2State extends State<Bottomsheet2> {

  bool isVisible = false;
//   FocusNode inputNode = FocusNode();
// // to open keyboard call this function;
//   void openKeyboard(){
//     FocusScope.of(context).requestFocus(inputNode);
//   }
  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).viewInsets.bottom;
    return SingleChildScrollView(
      reverse: true,
      child: Padding(
        padding: EdgeInsets.only(bottom: bottom),
        child: Container(
         // height: 210,
          color: Colors.white,
          padding: EdgeInsets.all(12),
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
                width: 150,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(8),
                    ),
                    border: Border.all(color: Colors.black, width: 1)),
                padding: EdgeInsets.all(8),
                child: Row(
                  children: [
                    Image.asset(
                      Images.payment,
                      height: 25,
                      width: 25,
                    ),
                    SizedBox(
                      width: 25,
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
                    isVisible = true;
                  });
                  FocusScope.of(context).requestFocus(new FocusNode());
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
                // maintainSize: true,
                // maintainAnimation: true,
                // maintainState: true,
                child:  Row(crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Expanded(
                        flex:3,
                        child: Container(
                          width: 70,
                          height: 45,
                          padding: EdgeInsets.only(left: 8,top: 4),
                          decoration: BoxDecoration(
                            color: AppColors.grey300,

                            borderRadius:  BorderRadius.all(const Radius.circular(12)),
                            //       border: Border(
                            //   left: BorderSide(10)
                            // ),
                            boxShadow: [
                              BoxShadow(color: AppColors.grey.withOpacity(0.1), spreadRadius: 1, blurRadius: 3, offset: Offset(0, 1)) // changes position of shadow
                            ],
                          ),
                          child: TextField(
                            maxLines: 1,
                           cursorColor:Colors.amber ,

                           // focusNode: inputNode,
                            autofocus:true,
                            // style: Theme.of(context).textTheme.title,
                            decoration: new InputDecoration(
hintText: 'Discount Coupon',
                                hintStyle: TextStyle(color: AppColors.grey400),
                                isDense: true,
                              fillColor: AppColors.grey.withOpacity(0.1),border: InputBorder.none
                            ),
                          ),

                        ),
                      ),
                      SizedBox(width: 20,),
                      Expanded(
                        flex:2,
                        child: Container(
                          decoration: BoxDecoration(color: Colors.amber,
                            borderRadius:  BorderRadius.all(const Radius.circular(12)),
                          ),
                          height: 45,child: Center(child: Text('Apply',style: TextStyle(color: Colors.white),)),
                        ),
                      )
                ])
              )

            ],
          ),
        ),
      ),
    );
  }
}


class BottomSheeet1 extends StatefulWidget {
  final Courses paidcourseList;
  const BottomSheeet1(this.paidcourseList);

  @override
  _BottomSheeet1State createState() => _BottomSheeet1State();
}

class _BottomSheeet1State extends State<BottomSheeet1> {
  @override
  Widget build(BuildContext context) {
    return
      SingleChildScrollView(
        child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(28),topRight: Radius.circular(28)),
            color: Colors.white   ),


//height: MediaQuery.of(context).size.height/1.88,
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
                      // child: FadeInImage(
                      //   fit: BoxFit.cover,
                      //   image: NetworkImage(
                      //    AppConstants.BANNER_BASE+   widget.paidcourseList.bannerPath.toString()
                      //   ),
                      //   placeholder: AssetImage(Images.noimage),
                      // ),
                      child: AppConstants.image(AppConstants.BANNER_BASE + widget.paidcourseList.bannerPath.toString()),

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
                          showModalBottomSheet(context: context, isScrollControlled: true, backgroundColor: Colors.transparent, builder: (context) =>Bottomsheet2());
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
                              getTranslated(context, 'skip')!,
                              style: TextStyle(color: Colors.amber,fontSize: 20),
                            ),
                          ),

                        ),
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => DeliveryDetailScreen(widget.paidcourseList)),
                          );
                        },
                        child: Container(
                          height: 50, width: 100,
                          //padding: EdgeInsets.all(6),
                          decoration: BoxDecoration(
                              color: Colors.amber,
                              borderRadius: BorderRadius.all(Radius.circular(7))),
                          child: Center(
                            child: Text(
                              getTranslated(context, 'add')!,
                              style: TextStyle(color: Colors.white),
                            ),
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
    ),
      );
  }
  }

