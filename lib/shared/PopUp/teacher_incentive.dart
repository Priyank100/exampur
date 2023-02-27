import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../../SharePref/shared_pref.dart';
import '../../data/datasource/remote/http/services.dart';
import '../../presentation/home/paid_courses/paid_courses.dart';
import '../../utils/analytics_constants.dart';
import '../../utils/api.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_constants.dart';
import '../../utils/images.dart';
import 'WelcomPopUp.dart';

class TeacherIncentivePopup {
  CarouselController _carouselController = CarouselController();
  TextEditingController textController = TextEditingController();
  bool loading = false;

  teacherIncentiveAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return AlertDialog(
              contentPadding: EdgeInsets.zero,
              scrollable: true,
              backgroundColor: Color(0xFFF97A7B),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15.0))),
              content: Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                padding: EdgeInsets.all(10),
                height: MediaQuery.of(context).size.height/1.5,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: InkWell(
                          onTap: (){
                            var map = {
                              'Page_Name':'Teacher_Incentive_Popup',
                              'Mobile_Number':AppConstants.userMobile,
                              'Language':AppConstants.langCode,
                              'User_ID':AppConstants.userMobile
                            };
                            AnalyticsConstants.trackEventMoEngage(AnalyticsConstants.Teacher_code_cross, map);
                            Navigator.pop(context);
                          },
                          child: Icon(Icons.close, color: AppColors.white)
                      ),
                    ),
                    SizedBox(height: 30),
                    Container(
                      height: (MediaQuery.of(context).size.height/1.5) - 75,
                      child: CarouselSlider(
                        carouselController: _carouselController,
                        options: CarouselOptions(
                          scrollPhysics: NeverScrollableScrollPhysics(),
                          disableCenter: true,
                          viewportFraction: 1,
                          enlargeCenterPage: true,
                          enableInfiniteScroll: false,
                          onPageChanged: (index, reason) {
                            // setState(() {});
                          },
                        ),
                        items: [
                          firstLayer(context, setState),
                          secondLayer(context, setState)
                        ],
                      ),
                    ),
                  ],
                ),
              )
          );
        },
      ),
    );
  }

  Widget firstLayer(context, setState) {
    return Column(
      children: [
        Text('Welcome to exampur family', textAlign: TextAlign.center, style: TextStyle(color: Colors.white)),
        SizedBox(height: 40),
        RichText(
            textAlign: TextAlign.center,
            text: const TextSpan(
              style: TextStyle(fontSize: 14),
              children: <TextSpan>[
                TextSpan(text: 'You will get ', style: TextStyle(color: Colors.white)),
                TextSpan(text: 'additional discount coupon ', style: TextStyle(color: Colors.yellow, fontWeight: FontWeight.bold)),
                TextSpan(text: "if you have a teacher's referral code", style: TextStyle(color: Colors.white)),
              ],
            )
        ),
        SizedBox(height: 50),
        Text('Please enter and submit referral code', textAlign: TextAlign.center, style: TextStyle(color: Colors.white)),
        SizedBox(height: 20),
        TextField(
          maxLines: 1,
          controller: textController,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.black, fontSize: 20),
          textCapitalization: TextCapitalization.characters,
          onChanged: (value) {
            textController.value =
                TextEditingValue(
                    text: value.toUpperCase(),
                    selection: textController.selection);
          },
          decoration: const InputDecoration(
            isDense: true,
            filled: true,
            fillColor: Colors.white,
            contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 10),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 1),
                borderRadius: BorderRadius.all(Radius.circular(10))
            ),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 1),
                borderRadius: BorderRadius.all(Radius.circular(10))
            ),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 1),
                borderRadius: BorderRadius.all(Radius.circular(10))
            ),
          ),
        ),
        SizedBox(height: 20),
        loading ? CircularProgressIndicator() :
        LinearButton(
            titleText: 'Submit',
            onpressed: (){
              submitReferralCode(context, textController.text.trim().toUpperCase(), setState);
            }),
        SizedBox(height: 20),
      ],
    );
  }

  Widget secondLayer(context, setState) {
    return Column(
      children: [
        Text('Thank You for updating referral code', textAlign: TextAlign.center, style: TextStyle(color: Colors.white)),
        SizedBox(height: 20),
        Image.asset(Images.Done, height: 150),
        SizedBox(height: 20),
        Text('Thank You for updating referral code', textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 12)),
        SizedBox(height: 10),
        Text('Your Coupon Code is', textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 12)),
        Text(textController.text, textAlign: TextAlign.center, style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold)),
        // SizedBox(height: 10),
        // Text('Valid for 48 hours', textAlign: TextAlign.center, style: TextStyle(color: Colors.yellow, fontSize: 14)),
        SizedBox(height: 20),
        LinearButton(titleText: 'Purchase Now',onpressed: (){purchaseNow(context);}),
        SizedBox(height: 20),
      ],
    );
  }

  Future<void> submitReferralCode(context, code, setState) async {
    FocusScope.of(context).unfocus();
    if(code.toString().isEmpty) {
      textController.text = '';
      AppConstants.showAlertDialog(context, 'Please enter referral code');
      return;
    }
    setState((){loading = true;});

    var body = {
      'couponCode': code.toString()
    };

    await Service.post(API.teacherIncentiveReferralCode_URL, body: body).then((response) async {
      loading = false;
      if(response.statusCode == 200) {
        var object = jsonDecode(response.body);
        if(object['statusCode'].toString() == '200') {
          var map = {
            'Page_Name':'Teacher_Incentive_Popup',
            'Mobile_Number':AppConstants.userMobile,
            'Language':AppConstants.langCode,
            'User_ID':AppConstants.userMobile
          };
          AnalyticsConstants.trackEventMoEngage(AnalyticsConstants.Teacher_code_submit, map);

          await SharedPref.clearSharedPref(SharedPref.TEACHER_INCENTIVE_DATETIME);
          _carouselController.animateToPage(1, duration: Duration(milliseconds: 300), curve: Curves.linear);

        } else {
          AppConstants.showAlertDialog(context, object['data'].toString());
        }
      } else {
        AppConstants.showAlertDialog(context, 'Something went wrong');
      }
      setState((){});
    });
  }

  void purchaseNow(context) {
    Navigator.pop(context);
    Navigator.of(context, rootNavigator: true).push(
        MaterialPageRoute(builder: (_) => PaidCourses(1)));
  }
}