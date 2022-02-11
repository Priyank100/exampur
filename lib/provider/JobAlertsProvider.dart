import 'dart:convert';
import 'package:exampur_mobile/Helper/api_checker.dart';
import 'package:exampur_mobile/data/model/job_alert_list_model.dart';
import 'package:exampur_mobile/data/model/job_alert_tab_model.dart';
import 'package:exampur_mobile/data/model/job_alerts_detail_model.dart';
import 'package:exampur_mobile/data/model/response/Base/api_response.dart';
import 'package:exampur_mobile/data/repository/JobAlertsRepo.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:flutter/cupertino.dart';

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

    if (apiResponse.response == null) {
      ApiChecker.checkApi(context, apiResponse);
    } else if (apiResponse.response!.statusCode == 200) {
      AppConstants.printLog(apiResponse.response);
      _jobAlertsDetailModel = JobAlertsDetailModel.fromJson(json.decode(apiResponse.response.toString()));
      return _jobAlertsDetailModel.data;

    } else {
      AppConstants.printLog("init address fail");
      ApiChecker.checkApi(context, apiResponse);
    }
    notifyListeners();
  }
}