import 'dart:convert';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:exampur_mobile/data/datasource/remote/http/services.dart';
import 'package:exampur_mobile/provider/new_my_course_provider.dart';
import 'package:exampur_mobile/utils/api.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import '../../../Localization/language_constrants.dart';
import '../../../SharePref/shared_pref.dart';
import '../../../data/model/my_course_subject_model.dart';
import '../../../utils/analytics_constants.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/lang_string.dart';
import '../../widgets/loading_indicator.dart';

class NewFeedbackView extends StatefulWidget {
  final String courseId;
  final String courseName;
  const NewFeedbackView(this.courseId, this.courseName) : super();

  @override
  State<NewFeedbackView> createState() => _NewFeedbackViewState();
}

class _NewFeedbackViewState extends State<NewFeedbackView> {
  String? userName;
  String? userEmail;
  String? userMobile;
  String? deviceModel;
  String? deviceMake;
  String? deviceOS;
  String? versionName;
  String? versionCode;

  List<SubjectData> subjectList = [];
  bool isLoading = false;
  TextEditingController msgController = TextEditingController();
  var selectedSubject;

  @override
  void initState() {
    var map = {
      'Page_Name':'My_Courses_Feedback',
      'Mobile_Number':AppConstants.userMobile,
      'Language':AppConstants.langCode,
      'User_ID':AppConstants.userMobile,
      'Course_Name':AppConstants.courseName,
      'Course_Type':AppConstants.mycourseType == 0 ? 'Paid_Course' : 'Free_Course'
    };
    AnalyticsConstants.trackEventMoEngage(AnalyticsConstants.Click_Feedback,map);
    getUserData();
    getDeviceData();
    getAppVersionData();
    callProvider();
    super.initState();
  }

  Future<void> getUserData() async {
    var jsonValue = jsonDecode(await SharedPref.getSharedPref(SharedPref.USER_DATA));
    userName = jsonValue[0]['data']['first_name'].toString();
    userMobile = jsonValue[0]['data']['phone'].toString();
    userEmail = jsonValue[0]['data']['email_id'].toString();
    setState(() {});
  }

  Future<void> getDeviceData() async {
    if(Platform.isAndroid){
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      deviceModel = androidInfo.model.toString();
      deviceMake = androidInfo.brand.toString();
      deviceOS = androidInfo.version.release.toString();
      setState(() {});
    }
  }

  Future<void> getAppVersionData() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    versionName = packageInfo.version;
    versionCode = packageInfo.buildNumber;
    setState(() {});
  }

  Future<void> callProvider() async {
    isLoading = true;
    subjectList = (await Provider.of<NewMyCourseProvider>(context, listen: false).getSubjectList(context, widget.courseId))!;
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading ? Center(child: LoadingIndicator(context)) :
      SingleChildScrollView(
        child: Column(
          children: [
            subjectDropDown(),
            messageBox(),
            submitButton()
          ],
        )
      ),
    );
  }

  Widget subjectDropDown() {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.only(left: 10),
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        color: AppColors.grey300,
        borderRadius:  BorderRadius.all(const Radius.circular(8)),
        boxShadow: [
          BoxShadow(color: AppColors.grey.withOpacity(0.1), spreadRadius: 1, blurRadius: 3, offset: Offset(0, 1))
        ],
      ),
      child: DropdownButton<SubjectData>(
        underline: SizedBox(),
        hint: Text("Select Subject", style: TextStyle(color: AppColors.black)),
        isExpanded: true,
        value:selectedSubject,
        items: subjectList.map((SubjectData value) {
          return DropdownMenuItem<SubjectData>(
            value: value,
            child: Text(value.title.toString()),
          );
        }).toList(),
        onChanged: (SubjectData? selected) {
          setState(() {
            selectedSubject = selected!;
          });
        },
      ),
    );
  }

  Widget messageBox() {
    return Container(
      margin: EdgeInsets.all(10),
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.grey300,
        borderRadius:  BorderRadius.all(const Radius.circular(12)),
        boxShadow: [
          BoxShadow(color: AppColors.grey.withOpacity(0.1), spreadRadius: 1, blurRadius: 3, offset: Offset(0, 1)) // changes position of shadow
        ],
      ),
      child:
      TextField(
        cursorColor: AppColors.amber,
        controller: msgController,
        maxLines: 8,
        decoration: InputDecoration(
            hintText: 'Write your feedback...',
            contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
            isDense: true,
            hintStyle: TextStyle(color: AppColors.grey600),
            fillColor: AppColors.grey.withOpacity(0.1),
            errorStyle: TextStyle(height: 1.5),
            border: InputBorder.none
        ),
      ),
    );
  }

  Widget submitButton() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: InkWell(
          onTap: () {
            checkValidation();
          },
          child: Container(
              height: 50,
              color: AppColors.dark,
              child: Center(
                  child: Text('Submit',
                      style: TextStyle(color: Colors.white,fontSize: 20))
              )
          )
      ),
    );
  }

  void checkValidation() {
    FocusScope.of(context).unfocus();
    if(selectedSubject == null) {
      AppConstants.showBottomMessage(context, 'Select subject', AppColors.black);
    } else if(msgController.text.trim().isEmpty) {
      AppConstants.showBottomMessage(context, 'Enter your message', AppColors.black);
    } else {
      submitForm();
    }
  }

  Future<void> submitForm() async {
    AppConstants.showLoaderDialog(context);
    var body = {
      "user": {
        "name": userName,
        "email": userEmail,
        "mobile": userMobile
      },
      "device": {
        "model": deviceModel,
        "make": deviceMake,
        "os": deviceOS
      },
      "app": {
        "version_name": versionName,
        "version_code": versionCode
      },
      "type": "feedback",
      "course": {
        "name": widget.courseName,
        "id": widget.courseId
      },
      "subject": {
        "name": selectedSubject.title.toString(),
        "id": selectedSubject.id.toString()
      },
      "issue_type": "course-content",
      "page": "My Course",
      "category": "COURSE-FEEDBACK",
      "message": msgController.text.trim()
    };
    Map<String, String> header = {
      "x-auth-token": AppConstants.serviceLogToken,
      "Content-Type": "application/json",
      "app-version":AppConstants.versionCode
    };
    await Service.post(API.serviceLogUrl, body: body, myHeader: header).then((response) {
      Navigator.pop(context);
      if(response == null) {
        AppConstants.showBottomMessage(context, getTranslated(context, LangString.serverError)!, AppColors.red);
      } else {
        if(response.statusCode == 200) {
          AppConstants.showBottomMessage(context, jsonDecode(response.body)['message'], AppColors.black);
          selectedSubject = null;
          msgController.text = '';
          setState(() {});
        } else {
          AppConstants.showBottomMessage(context, 'Something went wrong', AppColors.red);
        }
      }
    });
  }
}
