import 'dart:convert';

import 'package:exampur_mobile/Helper/api_checker.dart';
import 'package:exampur_mobile/data/model/appp_toutorial.dart';
import 'package:exampur_mobile/data/model/demo_models.dart';




import 'package:exampur_mobile/data/model/response/Base/api_response.dart';
import 'package:exampur_mobile/data/repository/App_Toutorial.dart';
import 'package:exampur_mobile/data/repository/Demorepo.dart';

import 'package:exampur_mobile/data/repository/One2One_repo.dart';

import 'package:exampur_mobile/utils/app_constants.dart';

import 'package:flutter/cupertino.dart';

class AppTutorialProvider extends ChangeNotifier {
  final AppTutorialRepo appTutorialRepo;

  AppTutorialProvider({required this.appTutorialRepo});



  ApppToutorial _apppToutorialModel = ApppToutorial();
  ApppToutorial get apppToutorialModel => _apppToutorialModel;

  Future<List<Data>?> getapptutorialList(BuildContext context) async {
    ApiResponse apiResponse = await appTutorialRepo.apptutorialRepo();
    if (apiResponse.response == null) {
      ApiChecker.checkApi(context, apiResponse);
    } else if (apiResponse.response!.statusCode == 200) {
      AppConstants.printLog(apiResponse.response!.data);


      AppConstants.printLog(apiResponse.response);
      _apppToutorialModel =ApppToutorial.fromJson(json.decode(apiResponse.response.toString()));
      return _apppToutorialModel.data;



    } else {
      AppConstants.printLog("init address fail");
      ApiChecker.checkApi(context, apiResponse);
    }
    notifyListeners();
  }


}
