import 'dart:convert';
import 'package:exampur_mobile/Helper/api_checker.dart';
import 'package:exampur_mobile/Localization/language_constrants.dart';
import 'package:exampur_mobile/data/model/job_alert_list_model.dart';
import 'package:exampur_mobile/data/model/job_alert_tab_model.dart';
import 'package:exampur_mobile/data/model/job_alerts_detail_model.dart';
import 'package:exampur_mobile/data/model/job_notification_course_model.dart';
import 'package:exampur_mobile/data/model/job_notification_tag_model.dart';
import 'package:exampur_mobile/data/model/response/Base/api_response.dart';
import 'package:exampur_mobile/data/repository/JobAlertsRepo.dart';
import 'package:exampur_mobile/utils/api.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:exampur_mobile/utils/error_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class JobAlertsProvider extends ChangeNotifier {
  final JobAlertsRepo jobAlertsRepo;
  JobAlertsProvider({required this.jobAlertsRepo});

  Job_alert_tab_Model _jobAlertTabModel = Job_alert_tab_Model();
  JobAlertListModel _jobAlertListModel = JobAlertListModel();
  JobAlertsDetailModel _jobAlertsDetailModel = JobAlertsDetailModel();


  Future<List<TabData>?> getJobAlertsTabList(BuildContext context) async {
    ApiResponse apiResponse = await jobAlertsRepo.jobAlertsTab();

    if (apiResponse.response == null || apiResponse.response!.statusCode != 200) {
      ApiChecker.checkApi(context, apiResponse);

    } else {
      if (apiResponse.response!.data['statusCode'].toString() == '200') {
        AppConstants.printLog(apiResponse.response);
        _jobAlertTabModel = Job_alert_tab_Model.fromJson(json.decode(apiResponse.response.toString()));
        return _jobAlertTabModel.data;

      } else {
        AppConstants.showBottomMessage(context, apiResponse.response!.data['data'].toString(), AppColors.black);
      }
    }
    notifyListeners();
  }

  Future<List<ListData>?> getJobAlertsList(BuildContext context, String alertCatId, String encodeCat, int pageNo) async {
    ApiResponse apiResponse = await jobAlertsRepo.jobAlertsList(alertCatId, encodeCat, pageNo);

    if (apiResponse.response == null || apiResponse.response!.statusCode != 200) {
      ApiChecker.checkApi(context, apiResponse);

    } else {
      if (apiResponse.response!.data['statusCode'].toString() == '200') {
        AppConstants.printLog(apiResponse.response);
        _jobAlertListModel = JobAlertListModel.fromJson(json.decode(apiResponse.response.toString()));
        return _jobAlertListModel.data;

      } else {
        AppConstants.showBottomMessage(context, apiResponse.response!.data['data'].toString(), AppColors.black);
      }
    }
    notifyListeners();
  }

  Future<DetailsData?> getJobAlertsDetails(BuildContext context, String id) async {
    ApiResponse apiResponse = await jobAlertsRepo.jobAlertsDetails(id);

    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      var statusCode = apiResponse.response!.data['statusCode'].toString();
      if (statusCode == '200') {
        _jobAlertsDetailModel = JobAlertsDetailModel.fromJson(
            json.decode(apiResponse.response.toString()));
        return _jobAlertsDetailModel.data;
      } else {
        String error = apiResponse.response!.data['data'].toString();
        AppConstants.showBottomMessage(context, error, AppColors.black);
      }
      notifyListeners();
    } else {
      AppConstants.showBottomMessage(
          context, getTranslated(context, StringConstant.serverError)!,
          AppColors.red);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => ErrorScreen()
          )
      );
      notifyListeners();
    }}

  //Job Notification
  Future<List<JobNotificationCourseModel>?> getJobNotificationCourseList(BuildContext context) async {
    ApiResponse apiResponse = await jobAlertsRepo.jobNotificationsCourseAndTag(API.jobNotificationCoursesUrl);

    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      List<JobNotificationCourseModel> myList = List<JobNotificationCourseModel>.from(apiResponse.response!.data.map((x) => JobNotificationCourseModel.fromJson(x)));
      return myList;

    } else {
      AppConstants.showBottomMessage(context, getTranslated(context, StringConstant.serverError), AppColors.red);
      AppConstants.goAndReplace(context, ErrorScreen());
    }
    notifyListeners();
  }

  Future<List<JobNotificationTagModel>?> getJobNotificationTagList(BuildContext context) async {
    ApiResponse apiResponse = await jobAlertsRepo.jobNotificationsCourseAndTag(API.jobNotificationTagUrl);

    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      List<JobNotificationTagModel> myList = List<JobNotificationTagModel>.from(apiResponse.response!.data.map((x) => JobNotificationTagModel.fromJson(x)));
      return myList;

    } else {
      AppConstants.showBottomMessage(context, getTranslated(context, StringConstant.serverError), AppColors.red);
      AppConstants.goAndReplace(context, ErrorScreen());
    }
    notifyListeners();
  }
}