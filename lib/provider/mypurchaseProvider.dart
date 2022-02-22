import 'dart:convert';
import 'package:exampur_mobile/Helper/api_checker.dart';
import 'package:exampur_mobile/data/model/job_alert_list_model.dart';
import 'package:exampur_mobile/data/model/job_alert_tab_model.dart';
import 'package:exampur_mobile/data/model/job_alerts_detail_model.dart';
import 'package:exampur_mobile/data/model/response/Base/api_response.dart';
import 'package:exampur_mobile/data/repository/JobAlertsRepo.dart';
import 'package:exampur_mobile/data/repository/MyPurchaseRepo.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:flutter/cupertino.dart';

class MyPurchaseProvider extends ChangeNotifier {
  final MyPurchaseRepo myPurchaseRepo;
  MyPurchaseProvider({required this.myPurchaseRepo});

  JobAlertsDetailModel _jobAlertsDetailModel = JobAlertsDetailModel();

  Future<DetailsData?> getmyPurchase(BuildContext context, String id) async {
    ApiResponse apiResponse = await myPurchaseRepo.mypurchase();

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