import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../../Localization/language_constrants.dart';
import '../../data/datasource/remote/http/services.dart';
import '../../utils/api.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_constants.dart';
import '../../utils/images.dart';
import '../../utils/lang_string.dart';
import 'WelcomPopUp.dart';

class TeacherIncentivePopup{
  CarouselController _carouselController = CarouselController();
  TextEditingController textController = TextEditingController();
  bool loading = false;

  teacherIncentiveAlert(BuildContext context) {
    int _current = 0;
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
                            setState(() {
                              _current = index;
                            });
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
          style: const TextStyle(color: Colors.black),
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
            contentPadding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10),
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
        Text('TEACHER55', textAlign: TextAlign.center, style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold)),
        SizedBox(height: 10),
        Text('Valid for 48 hours', textAlign: TextAlign.center, style: TextStyle(color: Colors.yellow, fontSize: 14)),
        SizedBox(height: 20),
        LinearButton(titleText: 'Purchase Now',onpressed: (){}),
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
        "version_name": AppConstants.versionName,
        "version_code": AppConstants.versionCode
      },
      "type": "teacher incentive",
      "message": code
    };
    // Map<String, String> header = {
    //   "x-auth-token": AppConstants.serviceLogToken,
    //   "Content-Type": "application/json",
    //   "app-version":AppConstants.versionCode
    // };
    // print(body);
    Future.delayed(Duration(seconds: 2), (){
      loading = false;
      _carouselController.animateToPage(1, duration: Duration(milliseconds: 300), curve: Curves.linear);
      setState((){});
    });
    // await Service.post(API.serviceLogUrl, body: body, myHeader: header).then((response) async {
    //   loading = false;
    //   if (response == null) {
    //     AppConstants.showBottomMessage(context,
    //         getTranslated(context,
    //             LangString.serverError)!,
    //         AppColors.red);
    //   } else {
    //     if (response.statusCode == 200) {
    //       _carouselController.animateToPage(1, duration: Duration(milliseconds: 300), curve: Curves.linear);
    //     } else {
    //       AppConstants.showBottomMessage(
    //           context, 'Something went wrong',
    //           AppColors.red);
    //     }
    //   }
    //   setState((){});
    // });
  }
}