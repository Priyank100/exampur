import 'dart:convert';

import 'package:exampur_mobile/Helper/api_checker.dart';
import 'package:exampur_mobile/Localization/language_constrants.dart';
import 'package:exampur_mobile/data/model/demo_model.dart';





import 'package:exampur_mobile/data/model/response/Base/api_response.dart';
import 'package:exampur_mobile/data/repository/Demorepo.dart';

import 'package:exampur_mobile/data/repository/One2One_repo.dart';

import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:exampur_mobile/utils/error_screen.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DemoProvider extends ChangeNotifier {
  final DemoRepo demoRepo;

  DemoProvider({required this.demoRepo});



  DemoModels _demoModel = DemoModels();
  DemoModels get demoModel => _demoModel;

  Future<List<Datum>?> getdemosList(BuildContext context,) async {
    ApiResponse apiResponse = await demoRepo.demoRepo();
    // if (apiResponse.response == null) {
    //   ApiChecker.checkApi(context, apiResponse);
    // } else if (apiResponse.response!.statusCode == 200) {
    //   AppConstants.printLog(apiResponse.response!.data);
    //
    //
    //   AppConstants.printLog(apiResponse.response);
    //   _demoModel =DemoModels.fromJson(json.decode(apiResponse.response.toString()));
    //   return _demoModel.data;
    //
    //
    //
    // } else {
    //   AppConstants.printLog("init address fail");
    //   ApiChecker.checkApi(context, apiResponse);
    // }
    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      var statusCode = apiResponse.response!.data['statusCode'].toString();
      if (statusCode == '200') {
        _demoModel = DemoModels.fromJson(
            json.decode(apiResponse.response.toString()));
        return _demoModel.data;
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
    }
  }
}
