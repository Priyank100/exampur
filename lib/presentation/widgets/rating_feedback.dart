import 'dart:convert';
import 'package:exampur_mobile/Localization/language_constrants.dart';
import 'package:exampur_mobile/data/datasource/remote/http/services.dart';
import 'package:exampur_mobile/data/model/helpandfeedback.dart';
import 'package:exampur_mobile/data/model/issulistname.dart';
import 'package:exampur_mobile/presentation/AppTutorial/app_tutorial.dart';
import 'package:exampur_mobile/presentation/widgets/custom_text_button.dart';
import 'package:exampur_mobile/utils/api.dart';
import 'package:exampur_mobile/utils/appBar.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RatingFeedback extends StatefulWidget {
  final String? userName;
  final String? userMobile;
  final String? userEmail;
  final String deviceModel;
  final String deviceMake;
  final String deviceOS;
  final String versionName;
  final String versionCode;
  const RatingFeedback(
      this.userName, this.userMobile, this.userEmail,
      this.deviceModel, this.deviceMake, this.deviceOS,
      this.versionName, this.versionCode) : super();

  @override
  RatingFeedbackState createState() => RatingFeedbackState();
}

class RatingFeedbackState extends State<RatingFeedback> {
  TextEditingController _descriptionController = TextEditingController();
  bool submittedLoader = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Form(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 20.0, top: 20.0),
                child: Text(
                  getTranslated(context, StringConstant.feedBack)!,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30.0,
                  ),
                ),
              ),

              Container(
                margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 15.0),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.grey300,
                  borderRadius:  BorderRadius.all(const Radius.circular(12)),
                  boxShadow: [
                    BoxShadow(color: AppColors.grey.withOpacity(0.1), spreadRadius: 1, blurRadius: 3, offset: Offset(0, 1)) // changes position of shadow
                  ],
                ),
                child: TextField(
                  cursorColor: AppColors.amber,
                  controller: _descriptionController,
                  maxLines: 10,
                  decoration: InputDecoration(
                      hintText: getTranslated(context, StringConstant.writeAboutTheProblem)!,
                      contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
                      isDense: true,
                      hintStyle: TextStyle(
                        color: AppColors.grey600,
                      ),
                      fillColor: AppColors.grey.withOpacity(0.1),
                      errorStyle: TextStyle(height: 1.5),
                      border: InputBorder.none),
                ),
              ),

              SizedBox(height: 30),

              submittedLoader ? SizedBox() : Container(
                    margin: EdgeInsets.only(left: 20, right: 20),
                    child: InkWell(
                      onTap: () {
                        String _message = _descriptionController.text.trim();
                        FocusScope.of(context).unfocus();
                        checkValidation(_message);
                      },
                      child: Container(
                          height: 50,
                          color: AppColors.dark,
                          child: Center(child: Text(getTranslated(context, StringConstant.submit)!, style: TextStyle(color: Colors.white,fontSize: 20)))
                      ),
                    ),
                  )
            ],
          ),
        ),
      ),
    );
  }

  void checkValidation(_message) {
    if (_message.isEmpty) {
      AppConstants.showBottomMessage(context, 'write about your problem', AppColors.black);
    } else {
      setState(() {
        submittedLoader = true;
      });
      submitFeedback(_message);
    }
  }

  Future<void> submitFeedback(String message) async {
    AppConstants.showLoaderDialog(context);
    var body = {
      "user":{
        "name":widget.userName,
        "email":widget.userEmail,
        "mobile":widget.userMobile
      },
      "device":{
        "model":widget.deviceModel,
        "make":widget.deviceMake,
        "os":widget.deviceOS
      },
      "app":{
        "version_name":widget.versionName,
        "version_code":widget.versionCode
      },
      "type":"feedback",
      "message":message
    };
    Map<String, String> header = {
      "x-auth-token": AppConstants.serviceLogToken,
      "Content-Type": "application/json"
    };
    await Service.post(API.serviceLogUrl, body: body, myHeader: header).then((response) {
      Navigator.pop(context);
      setState(() {
        submittedLoader = false;
      });
      if (response == null) {
        AppConstants.showBottomMessage(context, getTranslated(context, StringConstant.serverError)!, AppColors.red);
      } else {
        if(response.statusCode == 200) {
          AppConstants.showToast(getTranslated(context, StringConstant.ratingFeedback)!);
          Navigator.pop(context);
        } else {
          AppConstants.showBottomMessage(context, 'Something went wrong', AppColors.red);
        }
      }
    });
  }
}