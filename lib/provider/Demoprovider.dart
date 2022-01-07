import 'dart:convert';

import 'package:exampur_mobile/Helper/api_checker.dart';
import 'package:exampur_mobile/data/model/one2_one_model.dart';



import 'package:exampur_mobile/data/model/response/Base/api_response.dart';
import 'package:exampur_mobile/data/repository/Demorepo.dart';

import 'package:exampur_mobile/data/repository/One2One_repo.dart';

import 'package:exampur_mobile/utils/app_constants.dart';

import 'package:flutter/cupertino.dart';

class DemoProvider extends ChangeNotifier {
  final DemoRepo demoRepo;

  DemoProvider({required this.demoRepo});



  One2OneModel _one2oneModel = One2OneModel();
  One2OneModel get one2oneModel => _one2oneModel;

  Future<List<Courses>?> getOne2OneList(BuildContext context) async {
    ApiResponse apiResponse = await demoRepo.demoRepo();
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
