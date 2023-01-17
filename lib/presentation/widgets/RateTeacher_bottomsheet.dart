import 'dart:async';

import 'package:exampur_mobile/Localization/language_constrants.dart';
import 'package:exampur_mobile/utils/lang_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../data/datasource/remote/http/services.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_constants.dart';

class RateTeacheFullrBottom{
  static void rateTeacherFullBottomSheet(context,double val) {
    final ScrollController _controller = ScrollController();
    IconData? _selectedIcon;
    List<String> slectedList = [];
    String selectedText = '';
    List <TextDataModel> LowratingData = [
      TextDataModel('Wrong Concept taught',false),
      TextDataModel('Smart board notes was not clear',false),
      TextDataModel('Less Energy',false),
      TextDataModel('Steps missed in explanation',false),
      TextDataModel('Teacher is trying to prove the wrong ans',false),
      TextDataModel('Others',false),
    ];
    List <TextDataModel> highRatingData = [
      TextDataModel('Rich Content',false),
      TextDataModel('Fantastic Explanation',false),
      TextDataModel('High Energetic',false),
      TextDataModel('Neat Smart board work',false),
      TextDataModel('Others',false),
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
                return  val <= 3 ?
                  Container(
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
                          ignoreGestures: true,
                          onRatingUpdate: (rating) {},
                        ),
                        SizedBox(height: 10,),
                        Text(getTranslated(context, LangString.poor)!,style: TextStyle(color: Colors.red,fontSize: 20),),
                        Container(
                          height: MediaQuery.of(context).size.height/1.3,
                          color: Colors.grey.shade100,
                          margin: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(height: 10,),
                              Text(getTranslated(context, LangString.WhatWentBad)!,style: TextStyle(fontSize: 20),),
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
                                                LowratingData[index].isTrue = !LowratingData[index].isTrue;
                                                if(LowratingData[index].isTrue) {
                                                  slectedList.add(LowratingData[index].title);
                                                  // final String result = slectedList.join(', ');
                                                  // print(result);
                                                } else {
                                                  slectedList.remove(LowratingData[index].title);
                                                }
                                              });
                                            },
                                            child: Container(
                                              margin: EdgeInsets.all(8),
                                              padding:EdgeInsets.all(8) ,
                                              decoration: BoxDecoration(
                                                  color:  LowratingData[index].isTrue == true ? Colors.amber :Colors.white,
                                                  borderRadius: BorderRadius.circular(10)
                                              ),
                                              alignment: Alignment.center,
                                              child: Text(LowratingData[index].title, textAlign: TextAlign.center,style: TextStyle(color: LowratingData[index].isTrue == true ? Colors.white:null),),
                                            ),
                                          );
                                        },
                                        childCount: LowratingData.length,
                                      ),

                                    ) ,
                                    // other sliver widgets
                                  ],
                                ),
                              ),
                              SizedBox(height: 10,),
                              Container(
                                height: 150,
                                margin: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all()
                                ),
                                child: TextField(
                                  maxLines: 8,
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
                                onTap: (){
                                  print(slectedList);
                                },
                                child: Container(
                                  height: 50,
                                  margin: EdgeInsets.all(20),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Color(0xff3207f0)
                                  ),
                                  child: Text(getTranslated(context, LangString.Continue)!,style: TextStyle(color: Colors.white,fontSize: 20),),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )
                    :Container(
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
                          ignoreGestures: true,
                          onRatingUpdate: (rating) {},
                        ),
                        SizedBox(height: 10,),
                        Text(getTranslated(context, LangString.excellent)!,style: TextStyle(color: Colors.green,fontSize: 20),),
                        Container(
                          height: MediaQuery.of(context).size.height/1.3,
                          color: Colors.grey.shade100,
                          margin: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(height: 10,),
                              Text(getTranslated(context, LangString.WhatWentGood)!,style: TextStyle(fontSize: 20),),
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
                                                highRatingData[index].isTrue = !highRatingData[index].isTrue;
                                                if(highRatingData[index].isTrue) {
                                                  slectedList.add(highRatingData[index].title);
                                                  // final String result = slectedList.join(', ');
                                                  // print(result);
                                                } else {
                                                  slectedList.remove(highRatingData[index].title);
                                                }
                                              });
                                            },
                                            child: Container(
                                              margin: EdgeInsets.all(8),
                                              padding:EdgeInsets.all(8) ,
                                              decoration: BoxDecoration(
                                                  color:  highRatingData[index].isTrue == true ? Colors.amber :Colors.white,
                                                  borderRadius: BorderRadius.circular(10)
                                              ),
                                              alignment: Alignment.center,
                                              child: Text(highRatingData[index].title, textAlign: TextAlign.center,style: TextStyle(color: highRatingData[index].isTrue == true ? Colors.white:null),),
                                            ),
                                          );
                                        },
                                        childCount: highRatingData.length,
                                      ),

                                    ) ,
                                    // other sliver widgets
                                  ],
                                ),
                              ),
                              SizedBox(height: 10,),
                              Container(
                                height: 150,
                                margin: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all()
                                ),
                                child: TextField(
                                  maxLines: 8,
                                  onTap: (){
                                    Timer(Duration(milliseconds: 200),(){
                                      _controller.jumpTo(_controller.position.maxScrollExtent);
                                    });
                                    setState(() {});
                                  },
                                  decoration: InputDecoration(
                                    hintText:'Enter your feedback here..',
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
                                onTap: (){
                                  print(slectedList);
                                },
                                child: Container(
                                  height: 50,
                                  margin: EdgeInsets.all(20),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Color(0xff3207f0)
                                  ),
                                  child: Text('Continue',style: TextStyle(color: Colors.white,fontSize: 20),),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }
          );
    });
  void submitRating() async{
    var body = {};
    Map<String, String> header = {
      "x-auth-token": AppConstants.serviceLogToken,
      "Content-Type": "application/json",
      "app-version":AppConstants.versionCode
    };
    await Service.post('', body: body, myHeader: header).then((response) {
      Navigator.pop(context);
      // setState(() {
      //   submittedLoader = false;
      // });
      if (response == null) {
        AppConstants.showBottomMessage(context, getTranslated(context, LangString.serverError)!, AppColors.red);
      } else {
        if(response.statusCode == 200) {
          AppConstants.showToast(getTranslated(context, LangString.ratingFeedback)!);
          Navigator.pop(context);
        } else {
          AppConstants.showBottomMessage(context, 'Something went wrong', AppColors.red);
        }
      }
    });
  }
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