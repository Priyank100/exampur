import 'dart:convert';

import 'package:exampur_mobile/SharePref/shared_pref.dart';
import 'package:exampur_mobile/data/datasource/remote/http/services.dart';
import 'package:exampur_mobile/presentation/home/LandingChooseCategory.dart';
import 'package:exampur_mobile/presentation/theme/custom_text_style.dart';
import 'package:exampur_mobile/presentation/widgets/custom_text_field.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:exampur_mobile/utils/custompassword_textfield.dart';
import 'package:exampur_mobile/utils/dimensions.dart';
import 'package:exampur_mobile/utils/images.dart';
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
              SizedBox(height: 30),
              !isOtp ? phoneWidget() : otpWidget(),
              SizedBox(height: 30),
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
          onPressed: () {
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
        CustomTextField(hintText: "Enter the OTP",
            textInputType: TextInputType.number,
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
            backgroundColor: MaterialStateProperty.all<Color>(
                Theme.of(context).primaryColor),
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
      AppConstants.showBottomMessage(context, 'Enter phone number', Colors.black);
      return;
    }
    if(_phoneController.text.trim().toString().length < 10) {
      AppConstants.showBottomMessage(context, 'Enter valid phone number', Colors.black);
      return;
    }
    AppConstants.showLoaderDialog(context);
    var body = {
      "otp_for": "reset_pass",
      "phone_ext": "91",
      "phone": _phoneController.text.trim().toString()
    };
    await Service.post(API.Send_OTP_URL, body: body).then((response) async {
      Navigator.pop(context);
      if (response == null) {
        AppConstants.showBottomMessage(context, 'Server Error', Colors.red);
      } else if (response.statusCode == 200) {
        AppConstants.printLog(response.body.toString());
        final body = json.decode(response.body);
        var statusCode = body['statusCode'].toString();
        var msg = body['data'].toString();
        if(statusCode == '200') {
          AppConstants.showBottomMessage(context, 'OTP send to the number', Colors.black);
          isOtp = true;
          setState(() {});
        } else {
          AppConstants.showBottomMessage(context, msg, Colors.black);
        }

      } else {
        AppConstants.showBottomMessage(context, 'Server Error', Colors.red);
      }
    });
  }

  void verifyOtpResetPassword() async {
    FocusScope.of(context).unfocus();
    if(_otpController.text.trim().toString().isEmpty) {
      AppConstants.showBottomMessage(context, 'Enter the OTP', Colors.black);
      return;
    }
    if(_newPasswordController.text.trim().toString().isEmpty) {
      AppConstants.showBottomMessage(context, 'Enter new password', Colors.black);
      return;
    }
    if(_newPasswordController.text.trim().toString().length < 8) {
      AppConstants.showBottomMessage(context, 'Please enter atleast 8 letter Password', Colors.black);
      return;
    }
    if(_confirmPasswordController.text.trim().toString().isEmpty) {
      AppConstants.showBottomMessage(context, 'Enter confirm password', Colors.black);
      return;
    }
    if(_confirmPasswordController.text.trim().toString().length < 8) {
      AppConstants.showBottomMessage(context, 'Please enter atleast 8 letter Password', Colors.black);
      return;
    }
    if(_newPasswordController.text.trim().toString() != _confirmPasswordController.text.trim().toString()) {
      AppConstants.showBottomMessage(context, 'Confirm password not matched', Colors.black);
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
        AppConstants.showBottomMessage(context, 'Server Error', Colors.red);
      } else if (response.statusCode == 200) {
        AppConstants.printLog(response.body.toString());
        final body = json.decode(response.body);
        var statusCode = body['statusCode'].toString();
        var msg = body['data'].toString();
        if(statusCode == '200') {
          AppConstants.showBottomMessage(context, msg, Colors.black);
          Navigator.pop(context);
        } else {
          AppConstants.showBottomMessage(context, msg, Colors.black);
        }

      } else {
        AppConstants.showBottomMessage(context, 'Server Error', Colors.red);
      }
    });
  }

  void verifyOtp() async {
    FocusScope.of(context).unfocus();
    if(_otpController.text.trim().toString().isEmpty) {
      AppConstants.showBottomMessage(context, 'Enter the OTP', Colors.black);
      return;
    }
    AppConstants.showLoaderDialog(context);
    var body = {
      "phone_ext": "91",
      "phone": _phoneController.text.trim().toString(),
      "otp": _otpController.text.trim().toString(),
    };
    await Service.post(API.Verify_OTP_URL, body: body).then((response) async {
      Navigator.pop(context);
      if (response == null) {
        AppConstants.showBottomMessage(context, 'Server Error', Colors.red);

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
          AppConstants.showBottomMessage(context, msg, Colors.black);
        }

      } else {
        AppConstants.showBottomMessage(context, 'Server Error', Colors.red);
      }
    });
  }
}