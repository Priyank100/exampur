import 'dart:convert';

import 'package:exampur_mobile/Helper/api_checker.dart';
import 'package:exampur_mobile/data/model/demo_model.dart';





import 'package:exampur_mobile/data/model/response/Base/api_response.dart';
import 'package:exampur_mobile/data/repository/Demorepo.dart';

import 'package:exampur_mobile/data/repository/One2One_repo.dart';

import 'package:exampur_mobile/utils/app_constants.dart';

import 'package:flutter/cupertino.dart';

class DemoProvider extends ChangeNotifier {
  final DemoRepo demoRepo;

  DemoProvider({required this.demoRepo});



  DemoModels _demoModel = DemoModels();
  DemoModels get demoModel => _demoModel;

  Future<List<Datum>?> getdemosList(BuildContext context,) async {
    ApiResponse apiResponse = await demoRepo.demoRepo();
    if (apiResponse.response == null) {
      ApiChecker.checkApi(context, apiResponse);
    } else if (apiResponse.response!.statusCode == 200) {
      AppConstants.printLog(apiResponse.response!.data);


      AppConstants.printLog(apiResponse.response);
      _demoModel =DemoModels.fromJson(json.decode(apiResponse.response.toString()));
      return _demoModel.data;



    } else {
      AppConstants.printLog("init address fail");
      ApiChecker.checkApi(context, apiResponse);
    }
    notifyListeners();
  }


}
