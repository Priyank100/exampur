import 'dart:async';
import 'package:exampur_mobile/Localization/language_constrants.dart';
import 'package:exampur_mobile/utils/lang_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../data/datasource/remote/http/services.dart';
import '../../utils/analytics_constants.dart';
import '../../utils/api.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_constants.dart';

class RateTeacheFullrBottom{
  static void rateTeacherFullBottomSheet(context,double val) {
    final ScrollController _controller = ScrollController();
    TextEditingController messageController = TextEditingController();
    IconData? _selectedIcon;
    List<String> slectedList = [];
    String selectedText = '';
    // List <TextDataModel> LowratingData = [
    //   TextDataModel('Wrong Concept taught',false),
    //   TextDataModel('Smart board notes was not clear',false),
    //   TextDataModel('Less Energy',false),
    //   TextDataModel('Steps missed in explanation',false),
    //   TextDataModel('Teacher is trying to prove the wrong ans',false),
    //   TextDataModel('Others',false),
    // ];
    // List <TextDataModel> highRatingData = [
    //   TextDataModel('Rich Content',false),
    //   TextDataModel('Fantastic Explanation',false),
    //   TextDataModel('High Energetic',false),
    //   TextDataModel('Neat Smart board work',false),
    //   TextDataModel('Others',false),
    // ];
    List <TextDataModel> LowratingDataHi = [
      TextDataModel('Teacher ने Subject अच्छे से नहीं समझाया',false),
      TextDataModel('Teacher सिलेबस के हिसाब से नहीं पढ़ा रहे',false),
      TextDataModel('Teacher में Energy कम था और Boring लेक्चर था',false),
      TextDataModel('Teacher गलत कॉन्सेप्ट पढ़ा कर रहे थे',false),
      TextDataModel('Teacher Step मिस कर रहे थे, Flow समझ में नहीं आ रहा था',false),
    ];
    List <TextDataModel> highratingDataHi = [
      TextDataModel('Teacher बहुत अच्छे से समझाए',false),
      TextDataModel('काफी Detail में Concept पढ़ाए',false),
      TextDataModel('Teacher काफी Active the और Class बहुत Interesting थी',false),
      TextDataModel('Syllabus पूरा कवर कर दिए',false),
      TextDataModel('Doubts सारा Solve हो गया, अब Questions भी बन रहा',false),
    ];
    showModalBottomSheet(
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
        topRight: Radius.circular(20.0),
    topLeft: Radius.circular(20.0),
    ),
    ),

    context: context,
    builder: (BuildContext bc) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Container(
                    padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                  height: MediaQuery.of(context).size.height/1.06,
                  child: SingleChildScrollView(
                    controller: _controller,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: InkWell(
                            onTap: (){
                              Navigator.pop(context);
                            },
                            child: Align(
                              alignment: Alignment.topRight,
                              child:Icon(Icons.clear),),
                          ),
                        ),
                        Text(getTranslated(context, LangString.howWasTheLeacture)!, style: TextStyle(fontSize: 20),),
                        SizedBox(height: 15,),
                        Text(getTranslated(context, LangString.yourRatingHelpUsImprove)!, style: TextStyle(fontSize: 15,color: Colors.grey),),
                        SizedBox(height: 10,),
                        RatingBar.builder(
                          initialRating: val,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: false,
                          itemCount: 5,
                          itemSize: 40,
                          itemPadding: const EdgeInsets.symmetric(horizontal: 8),
                          itemBuilder: (context, _) => Icon(
                            _selectedIcon ?? Icons.star,
                            color: Colors.amber,
                          ),
                         // ignoreGestures: true,
                          onRatingUpdate: (rating) {
                            setState((){
                              val = rating;
                              slectedList.clear();
                              // for(var i=0; i< LowratingData.length;i++){
                              //   LowratingData[i].isTrue = false;
                              // }
                              for(var i=0; i< LowratingDataHi.length;i++){
                                LowratingDataHi[i].isTrue = false;
                              }
                              // for(var i=0; i< highRatingData.length;i++){
                              //   highRatingData[i].isTrue = false;
                              // }
                              for(var i=0; i< highratingDataHi.length;i++){
                                highratingDataHi[i].isTrue = false;
                              }
                              var map = {
                                'Page_Name':'Recorded_Video',
                                'Mobile_Number':AppConstants.userMobile,
                                'Language':AppConstants.langCode,
                                'User_ID':AppConstants.userMobile,
                                "topic":AppConstants.timlineName,
                                "class type":AppConstants.teacherRatingType == 0 ? "live":"recorded",
                                "rating count":rating.toString()
                              };
                              AnalyticsConstants.trackEventMoEngage(AnalyticsConstants.Click_rating_count, map);
                            });

                          },
                        ),
                        SizedBox(height: 10,),
                        Text( val <= 3 ?getTranslated(context, LangString.poor)!:getTranslated(context, LangString.excellent)!,style: TextStyle(color: Colors.red,fontSize: 20),),
                        Container(
                          height: MediaQuery.of(context).size.height/1.3,
                          color: Colors.grey.shade100,
                          margin: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(height: 10,),
                              Text(val <= 3 ?getTranslated(context, LangString.WhatWentBad)!:getTranslated(context, LangString.WhatWentGood)!,style: TextStyle(fontSize: 20),),
                              SizedBox(height: 10,),
                              Container(
                                height: 300,
                                child: CustomScrollView(
                                  physics: NeverScrollableScrollPhysics(),
                                  slivers: [
                                    SliverGrid(
                                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        mainAxisSpacing: 10,
                                        crossAxisSpacing: 10,
                                        childAspectRatio: 2.0,
                                      ),
                                      delegate: SliverChildBuilderDelegate(
                                            (context, index) {
                                          return InkWell(
                                            onTap: (){
                                              setState(() {
                                                // if(val <= 3){
                                                //   LowratingData[index].isTrue = !LowratingData[index].isTrue;
                                                //   if(LowratingData[index].isTrue) {
                                                //    slectedList.add(AppConstants.langCode == 'hi'?LowratingDataHi[index].title :LowratingData[index].title);
                                                //     // final String result = slectedList.join(', ');
                                                //     // print(result);
                                                //   } else {
                                                //     slectedList.remove(AppConstants.langCode == 'hi'?LowratingDataHi[index].title :LowratingData[index].title);
                                                //   }
                                                // }else{
                                                //   highRatingData[index].isTrue = !highRatingData[index].isTrue;
                                                //   if(highRatingData[index].isTrue) {
                                                //     slectedList.add(AppConstants.langCode == 'hi'?highratingDataHi[index].title:highRatingData[index].title);
                                                //     // final String result = slectedList.join(', ');
                                                //     // print(result);
                                                //   } else {
                                                //     slectedList.remove(AppConstants.langCode == 'hi'?highratingDataHi[index].title:highRatingData[index].title);
                                                //   }
                                                // }
                                                if(val <= 3){
                                                  LowratingDataHi[index].isTrue = !LowratingDataHi[index].isTrue;
                                                  if(LowratingDataHi[index].isTrue) {
                                                    slectedList.add(LowratingDataHi[index].title);
                                                  }else{
                                                    slectedList.remove(LowratingDataHi[index].title);
                                                  }
                                                }else{
                                                  highratingDataHi[index].isTrue = !highratingDataHi[index].isTrue;
                                                     if(highratingDataHi[index].isTrue) {
                                                       slectedList.add(highratingDataHi[index].title);
                                                     }else{
                                                       slectedList.remove(highratingDataHi[index].title);
                                                     }
                                                }

                                              });
                                            },
                                            child: Container(
                                              margin: EdgeInsets.all(5),
                                              padding:EdgeInsets.all(8) ,
                                              decoration: BoxDecoration(
                                                 // color: val <= 3 ? LowratingData[index].isTrue ? Colors.amber :Colors.white :highRatingData[index].isTrue ? Colors.amber :Colors.white,
                                                  color: val <= 3 ? LowratingDataHi[index].isTrue ? Colors.amber :Colors.white :highratingDataHi[index].isTrue ? Colors.amber :Colors.white,
                                                  borderRadius: BorderRadius.circular(10)
                                              ),
                                              alignment: Alignment.center,
                                              child: Text(val <= 3 ? LowratingDataHi[index].title:highratingDataHi[index].title, textAlign: TextAlign.center,style: TextStyle(color:val<= 3? LowratingDataHi[index].isTrue  == true ? Colors.white:null:highratingDataHi[index].isTrue  == true ? Colors.white:null),),
                                            ),
                                          );
                                        },
                                        childCount: val <= 3 ?LowratingDataHi.length:highratingDataHi.length,
                                      ),

                                    ) ,
                                    // other sliver widgets
                                  ],
                                ),
                              ),
                              SizedBox(height: 10,),
                              Container(
                                height: 100,
                                margin: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all()
                                ),
                                child: TextField(
                                  maxLines: 8,
                                  controller: messageController,
                                  onTap: (){
                                    Timer(Duration(milliseconds: 200),(){
                                      _controller.jumpTo(_controller.position.maxScrollExtent);
                                    });
                                    setState(() {});
                                  },
                                  decoration: InputDecoration(
                                    hintText:getTranslated(context, LangString.Enter_Your_Feedback_Here),
                                    hintStyle: TextStyle(
                                      color: AppColors.grey300,
                                    ),
                                    contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
                                    isDense: true,
                                    counterText: '',
                                    errorStyle: TextStyle(height: 1.5),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),


                              InkWell(
                                onTap: () async {
                                //  Focus.of(context).unfocus();
                                  var map = {
                                    'Page_Name':'Recorded_Video',
                                    'Mobile_Number':AppConstants.userMobile,
                                    'Language':AppConstants.langCode,
                                    'User_ID':AppConstants.userMobile,
                                    "topic":AppConstants.timlineName,
                                    "class type":AppConstants.teacherRatingType == 0 ? "live":"recorded",
                                    "rating count":val.toString()
                                  };
                                  AnalyticsConstants.trackEventMoEngage(AnalyticsConstants.Submit_feedback, map);
                                  // AppConstants.showLoaderDialog(context);
                                  if(slectedList.isEmpty) {
                                    // print('anchal');
                                    AppConstants.showAlertDialog(
                                        context, 'Please select the reason',
                                    );

                                  } else {
                                    var body = {
                                      "user": {
                                        "name": AppConstants.userName,
                                        "email": AppConstants.Email,
                                        "mobile": AppConstants.userMobile
                                      },
                                      "device": {
                                        "model": AppConstants.deviceModel,
                                        "make": AppConstants.deviceMake,
                                        "os": AppConstants.deviceOS
                                      },
                                      "app": {
                                        "version_name": AppConstants
                                            .versionName,
                                        "version_code": AppConstants.versionCode
                                      },
                                      "type": "feedback",
                                      "category": "faculty-feedback",
                                      "course": {
                                        "name": AppConstants.myCourseName,
                                        "id": AppConstants.myCourseId
                                      },
                                      "subject": {
                                        "subject_id": AppConstants.subjectId,
                                        "subject_name": AppConstants.subjectName
                                      },
                                      "content": {
                                        "timeline_name": AppConstants
                                            .timlineName,
                                        "timeline_id": AppConstants.timlineId
                                      },
                                      "rating": val.toString(),
                                      "user_selection": slectedList,
                                      "message": messageController.text.trim()
                                    };
                                    Map<String, String> header = {
                                      "x-auth-token": AppConstants
                                          .serviceLogToken,
                                      "Content-Type": "application/json",
                                      "app-version": AppConstants.versionCode
                                    };
                                    await Service.post(
                                        API.serviceLogUrl, body: body,
                                        myHeader: header).then((response) {
                                      // print(response);
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                      if (response == null) {
                                        AppConstants.showBottomMessage(context,
                                            getTranslated(context,
                                                LangString.serverError)!,
                                            AppColors.red);
                                      } else {
                                        if (response.statusCode == 200) {
                                          AppConstants.showToast(getTranslated(
                                              context,
                                              LangString.ratingTeacher)!);
                                          Navigator.pop(context);
                                        } else {
                                          AppConstants.showBottomMessage(
                                              context, 'Something went wrong',
                                              AppColors.red);
                                        }
                                      }
                                    });
                                  }
                                },
                                child: Container(
                                  height: 50,
                                  margin: EdgeInsets.all(20),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Color(0xff3207f0)
                                  ),
                                  child: Text('Submit',style: TextStyle(color: Colors.white,fontSize: 20),),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }
          );

    }

    );

  }
  static  Widget textData(String title){
    return Container(
      width: 150,
      height: 70,
      margin: EdgeInsets.all(8),
      padding:EdgeInsets.all(8) ,
      decoration: BoxDecoration(
          color: Colors.white,
        borderRadius: BorderRadius.circular(10)
      ),
      alignment: Alignment.center,
      child: Text(title, textAlign: TextAlign.center,),
    );
  }
}

class TextDataModel{
  String title;
  bool isTrue;
  TextDataModel(this.title,this.isTrue);
}