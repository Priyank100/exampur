import 'dart:convert';

import 'package:exampur_mobile/Helper/api_checker.dart';
import 'package:exampur_mobile/data/model/one2_one_model.dart';



import 'package:exampur_mobile/data/model/response/Base/api_response.dart';

import 'package:exampur_mobile/data/repository/One2One_repo.dart';

import 'package:exampur_mobile/utils/app_constants.dart';

import 'package:flutter/cupertino.dart';

class One2OneProvider extends ChangeNotifier {
  final One2OneRepo one2oneRepo;

  One2OneProvider({required this.one2oneRepo});



  One2OneModel _one2oneModel = One2OneModel();
  One2OneModel get one2oneModel => _one2oneModel;

  Future<List<Courses>?> getOne2OneList(BuildContext context) async {
    ApiResponse apiResponse = await one2oneRepo.one2oneRepo();
    if (apiResponse.response == null) {
      ApiChecker.checkApi(context, apiResponse);
    } else if (apiResponse.response!.statusCode == 200) {
      AppConstants.printLog(apiResponse.response!.data);


      AppConstants.printLog(apiResponse.response);
      _one2oneModel =One2OneModel.fromJson(json.decode(apiResponse.response.toString()));
      return _one2oneModel.courses;



    } else {
      AppConstants.printLog("init address fail");
      ApiChecker.checkApi(context, apiResponse);
    }
    notifyListeners();
  }


}
