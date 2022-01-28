import 'dart:convert';
import 'package:exampur_mobile/Helper/api_checker.dart';
import 'package:exampur_mobile/data/model/job_alert_post_api.dart';
import 'package:exampur_mobile/data/model/job_alert_tab__model.dart';


import 'package:exampur_mobile/data/model/response/Base/api_response.dart';
import 'package:exampur_mobile/data/model/response/Base/error_response.dart';
import 'package:exampur_mobile/data/repository/jobAlerts.dart';

import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:flutter/cupertino.dart';

class JobAlertsProvider extends ChangeNotifier {
  final JobAlertsRepo jobAlertsRepo;
  JobAlertsProvider({required this.jobAlertsRepo});

  Job_alert_tab_Model _jobalerttabModel = Job_alert_tab_Model();
  Job_alert_tab_Model get paidcoursetabModel => _jobalerttabModel;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<List<Data>?> getjobalertsTabList(BuildContext context) async {
    ApiResponse apiResponse = await jobAlertsRepo.job_alerts_Tab();
    if (apiResponse.response == null) {
      ApiChecker.checkApi(context, apiResponse);
    } else if (apiResponse.response!.statusCode == 200) {
      AppConstants.printLog(apiResponse.response);
      _jobalerttabModel = Job_alert_tab_Model.fromJson(json.decode(apiResponse.response.toString()));
      return _jobalerttabModel.data;

    } else {
      AppConstants.printLog("init address fail");
      ApiChecker.checkApi(context, apiResponse);
    }
    notifyListeners();
  }
  // Future jobalert(JobAlertPostApi jobAlertPostApi) async {
  //   _isLoading = true;
  //   notifyListeners();
  //   ApiResponse apiResponse = await jobAlertsRepo.jobalertpost(jobAlertPostApi);
  //   _isLoading = false;
  //   if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
  //     AppConstants.printLog(apiResponse.response);
  //
  //     notifyListeners();
  //   } else {
  //     String errorMessage;
  //     if (apiResponse.error is String) {
  //       print(apiResponse.error.toString());
  //       errorMessage = apiResponse.error.toString();
  //     } else {
  //       ErrorResponse errorResponse = apiResponse.error;
  //       print(errorResponse.errors![0].message);
  //       errorMessage = errorResponse.errors![0].message!;
  //     }
  //
  //     notifyListeners();
  //   }
  // }

}