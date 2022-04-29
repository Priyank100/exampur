import 'dart:async';
import 'dart:convert';
import 'package:exampur_mobile/SharePref/shared_pref.dart';
import 'package:exampur_mobile/data/datasource/remote/http/services.dart';
import 'package:exampur_mobile/presentation/home/LandingChooseCategory.dart';
import 'package:exampur_mobile/presentation/home/bottom_navigation.dart';
import 'package:exampur_mobile/presentation/theme/custom_text_style.dart';
import 'package:exampur_mobile/presentation/widgets/custom_text_field.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:exampur_mobile/utils/custompassword_textfield.dart';
import 'package:exampur_mobile/utils/dimensions.dart';
import 'package:exampur_mobile/utils/images.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';

import 'landing_page.dart';

class OtpScreen extends StatefulWidget {
  final bool isReset;
  const OtpScreen(this.isReset) : super();

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _otpController = TextEditingController();
  TextEditingController _newPasswordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  bool isOtp = false;
  bool enableSkip = false;
  int skipCounter = 20;
  late Timer timer;




  @override
  void initState() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if(skipCounter > 0) {
          skipCounter--;
          enableSkip = false;
        } else {
          timer.cancel();
          enableSkip = true;
        }
      });
    });
    super.initState();
    if(widget.isReset) {
      _phoneController.text = '';
    } else {
      getSharedPrefData();
    }
  }

  Future<void> getSharedPrefData() async {
    var jsonValue =  jsonDecode(await SharedPref.getSharedPref(SharedPrefConstants.USER_DATA));
    String mobile = jsonValue[0]['data']['phone'].toString();
    _phoneController.text = mobile;
    sendOtp();
  }


  @override
  void dispose() {
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
        body:SingleChildScrollView(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Center(
                child:
                Image.asset(Images.exampur_title,
                  width: Dimensions.ICON_SIZE_BigLogo,
                ),
              ),
              SizedBox(height: 30),
              Text(widget.isReset ? 'Reset Password' : 'Verify Phone',
                  style: CustomTextStyle.headingBigBold(context)),
              SizedBox(height: 20),
              !isOtp ? phoneWidget() : otpWidget(),
              SizedBox(height: 20),
              widget.isReset ? SizedBox() : enableSkip ? InkWell(
                onTap: () {
                  AppConstants.PHONE_VERIFY = false;
                  if(AppConstants.CATEGORY_LENGTH == '0' || AppConstants.CATEGORY_LENGTH == 'null') {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder:
                            (context) =>
                            LandingChooseCategory()
                        )
                    );
                  } else {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder:
                            (context) =>
                            BottomNavigation()
                        )
                    );
                  }
                },
                child: Text('skip', style: TextStyle(color: Colors.blue)),
              ) : Text('Skip in Seconds 0:${skipCounter}s', style: TextStyle(color: Colors.blue)),
              SizedBox(height: 10),
              InkWell(
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => LandingPage()),
                          (route) => false);
                },
                child: Text('LogIn/New Register', style: TextStyle(color: Colors.blue)),
              )
            ],
          ),
        )
    );
  }

  Widget phoneWidget() {
    return Column(
      children: [
        CustomTextField(hintText: "Phone Number",
            textInputType: TextInputType.number,
            controller: _phoneController,
            maxLength: 10,
            value: (value) {}),
        SizedBox(height: 30),
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
                Theme.of(context).primaryColor),
          ),
          onPressed: ()async {
        // await    FirebaseAnalytics.instance.logEvent(name: 'OTP_REQUESTED',parameters: {
        //   'User_phoneNumber':_phoneController.text.toString()
        // });
            sendOtp();
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(
                vertical: 12.0, horizontal: 60),
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Text(
                  "Send OTP",
                  style:
                  TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget otpWidget() {
    return Column(
      children: [
        Text('Phone : ${_phoneController.text.toString()}',
            style: CustomTextStyle.subHeading(context)),
        SizedBox(height: 10),
        CustomTextField(hintText: "Enter the OTP",
            textInputType: TextInputType.number,
            autofillHints: const <String>[AutofillHints.oneTimeCode],
            controller: _otpController,
            value: (value) {}),
        SizedBox(height: 20),
        widget.isReset ? Container(
          child: Column(
            children: [
              CustomPasswordTextField(
                hintTxt: 'New Password',
                controller: _newPasswordController,
                textInputAction: TextInputAction.next,
              ),
              SizedBox(height: 20),
              CustomPasswordTextField(
                hintTxt: 'Confirm Password',
                controller: _confirmPasswordController,
                textInputAction: TextInputAction.next,
              )
            ],
          ),
        ): SizedBox(),
        SizedBox(height: 30),
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).primaryColor),
          ),
          onPressed: () {

            widget.isReset ? verifyOtpResetPassword() : verifyOtp();
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(
                vertical: 12.0, horizontal: 60),
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Text(
                  "Verify OTP",
                  style:
                  TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void sendOtp() async {
    FocusScope.of(context).unfocus();
    if(_phoneController.text.trim().toString().isEmpty) {
      showBottomMessage(context, 'Enter phone number', Colors.black);
      return;
    }
    if(_phoneController.text.trim().toString().length < 10) {
      showBottomMessage(context, 'Enter valid phone number', Colors.black);
      return;
    }
    AppConstants.showLoaderDialog(context);
    var body = {
      "otp_for": widget.isReset ? "reset_pass" : "verification",
      "phone_ext": "91",
      "phone": _phoneController.text.trim().toString()
    };

    // await Service.post(API.Send_OTP_URL, body: body).then((response) async {
    await Service.get(API.Send_OTP_URL.replaceAll('USER_MOBILE', _phoneController.text.trim().toString())).then((response) async {
      Navigator.pop(context);
      if (response == null) {
        showBottomMessage(context, 'Server Error', Colors.red);
      } else if (response.statusCode == 200) {
        AppConstants.printLog(response.body.toString());
        final body = json.decode(response.body);
        // var statusCode = body['statusCode'].toString();
        // var msg = body['data'].toString();
        var type = body['type'].toString();
        // if (statusCode == '200') {
        //   showBottomMessage(
        //       context, 'OTP send to the number', Colors.black);
        //   isOtp = true;
        //   setState(() {});
        // } else {
        //   showBottomMessage(context, msg, Colors.black);
        // }
        if (type == 'success') {
          showBottomMessage(context, 'OTP send to the number', Colors.black);
          isOtp = true;
          setState(() {});
        } else {
          showBottomMessage(context, 'Error in OTP', Colors.black);
        }
      } else if(response.statusCode == 429) {
        await Service.post(API.Send_OTP_URL_2, body: body).then((response) async {
          Navigator.pop(context);
          if (response == null) {
            showBottomMessage(context, 'Server Error', Colors.red);
          } else if (response.statusCode == 200) {
            AppConstants.printLog(response.body.toString());
            final body = json.decode(response.body);
            var statusCode = body['statusCode'].toString();
            var msg = body['data'].toString();
            if(statusCode == '200') {
              showBottomMessage(context, 'OTP send to the number', Colors.black);
              isOtp = true;
              setState(() {});
            } else {
              showBottomMessage(context, msg, Colors.black);
            }
          } else {
            showBottomMessage(context, 'Server Error', Colors.red);
          }
        });
      } else {
        showBottomMessage(context, 'Server Error', Colors.red);
      }
    });
  }

  void verifyOtpResetPassword() async {
    FocusScope.of(context).unfocus();
    if(_otpController.text.trim().toString().isEmpty) {
      showBottomMessage(context, 'Enter the OTP', Colors.black);
      return;
    }
    if(_newPasswordController.text.trim().toString().isEmpty) {
      showBottomMessage(context, 'Enter new password', Colors.black);
      return;
    }
    if(_newPasswordController.text.trim().toString().length < 8) {
      showBottomMessage(context, 'Please enter atleast 8 letter Password', Colors.black);
      return;
    }
    if(_confirmPasswordController.text.trim().toString().isEmpty) {
      showBottomMessage(context, 'Enter confirm password', Colors.black);
      return;
    }
    if(_confirmPasswordController.text.trim().toString().length < 8) {
      showBottomMessage(context, 'Please enter atleast 8 letter Password', Colors.black);
      return;
    }
    if(_newPasswordController.text.trim().toString() != _confirmPasswordController.text.trim().toString()) {
      showBottomMessage(context, 'Confirm password not matched', Colors.black);
      return;
    }
    AppConstants.showLoaderDialog(context);
    var body = {
      "phone_ext": "91",
      "phone": _phoneController.text.trim().toString(),
      "otp": _otpController.text.trim().toString(),
      "new_password": _newPasswordController.text.trim().toString(),
      "confirm_password": _confirmPasswordController.text.trim().toString()
    };
    await Service.post(API.Reset_Password_URL, body: body).then((response) async {
      Navigator.pop(context);
      if (response == null) {
        showBottomMessage(context, 'Server Error', Colors.red);
      } else if (response.statusCode == 200) {
        AppConstants.printLog(response.body.toString());
        final body = json.decode(response.body);
        var statusCode = body['statusCode'].toString();
        var msg = body['data'].toString();
        if (statusCode == '200') {
          showBottomMessage(context, msg, Colors.black);
          Navigator.pop(context);
        } else {
          showBottomMessage(context, msg, Colors.black);
        }
      } else if(response.statusCode==429) {
        await Service.post(API.Reset_Password_URL_2, body: body).then((response) async {
          Navigator.pop(context);
          if (response == null) {
            showBottomMessage(context, 'Server Error', Colors.red);
          } else if (response.statusCode == 200) {
            AppConstants.printLog(response.body.toString());
            final body = json.decode(response.body);
            var statusCode = body['statusCode'].toString();
            var msg = body['data'].toString();
            if(statusCode == '200') {
              showBottomMessage(context, msg, Colors.black);
              Navigator.pop(context);
            } else {
              showBottomMessage(context, msg, Colors.black);
            }

          } else {
            showBottomMessage(context, 'Server Error', Colors.red);
          }
        });
      } else {
        showBottomMessage(context, 'Server Error', Colors.red);
      }
    });
  }

  void verifyOtp() async {
    FocusScope.of(context).unfocus();
    if(_otpController.text.trim().toString().isEmpty) {
      showBottomMessage(context, 'Enter the OTP', Colors.black);
      return;
    }
    // await FirebaseAnalytics.instance.logEvent(name: 'OTP_SUBMIT',parameters: {
    //   'User_PhoneNumber':_phoneController.text.toString()
    // });
    AppConstants.showLoaderDialog(context);
    var body = {
      // "phone_ext": "91",
      // "phone": _phoneController.text.trim().toString(),
      "otp": _otpController.text.trim().toString(),
    };
    await Service.post(API.Verify_OTP_URL, body: body).then((response) async {
      Navigator.pop(context);
      if (response == null) {
        showBottomMessage(context, 'Server Error', Colors.red);

      } else if (response.statusCode == 200) {
        AppConstants.printLog(response.body.toString());
        final body = json.decode(response.body);
        var statusCode = body['statusCode'].toString();
        var msg = body['data'].toString();
        if (statusCode == '200') {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => LandingChooseCategory()),
                  (route) => false);
        } else {
          showBottomMessage(context, msg, Colors.black);
        }
      } else if(response.statusCode==429){
        await Service.post(API.Verify_OTP_URL_2, body: body).then((response) async {
          Navigator.pop(context);
          if (response == null) {
            showBottomMessage(context, 'Server Error', Colors.red);

          } else if (response.statusCode == 200) {
            AppConstants.printLog(response.body.toString());
            final body = json.decode(response.body);
            var statusCode = body['statusCode'].toString();
            var msg = body['data'].toString();
            if(statusCode == '200') {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => LandingChooseCategory()),
                      (route) => false);
            } else {
              showBottomMessage(context, msg, Colors.black);
            }

          } else {
            showBottomMessage(context, 'Server Error', Colors.red);
          }
        });
      } else {
        showBottomMessage(context, 'Server Error', Colors.red);
      }
    });
  }

  void showBottomMessage(context, message, bgColor) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      margin: EdgeInsets.all(20),
      behavior: SnackBarBehavior.floating,
      content: Text(message),
      backgroundColor: bgColor,
      duration: Duration(milliseconds: 700),
    ));
  }
}
