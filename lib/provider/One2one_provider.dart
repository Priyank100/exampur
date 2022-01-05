import 'dart:convert';

import 'package:exampur_mobile/Helper/api_checker.dart';
import 'package:exampur_mobile/data/model/CoursesModel.dart';
import 'package:exampur_mobile/data/model/One2onemodel.dart';
import 'package:exampur_mobile/data/model/Userinfo.dart';
import 'package:exampur_mobile/data/model/loginmodel.dart';
import 'package:exampur_mobile/data/model/response/Base/api_response.dart';
import 'package:exampur_mobile/data/model/response/Base/error_response.dart';
import 'package:exampur_mobile/data/model/response/HomeBannerModel.dart';
import 'package:exampur_mobile/data/repository/Authrepo.dart';
import 'package:exampur_mobile/data/repository/Books_EBooks_repo.dart';
import 'package:exampur_mobile/data/repository/HomeBanner_repo.dart';
import 'package:exampur_mobile/data/repository/One2One_repo.dart';
import 'package:exampur_mobile/data/repository/courserepo.dart';
import 'package:exampur_mobile/utils/app_constants.dart';

import 'package:flutter/cupertino.dart';

class One2OneProvider extends ChangeNotifier {
  final One2OneRepo one2oneRepo;

  One2OneProvider({required this.one2oneRepo});

  // List<CoursesModel> _coursesList = [];
  // List<CoursesModel> get coursesModel => _coursesList;

  One2OneModel _one2oneModel = One2OneModel();
  One2OneModel get one2oneModel => _one2oneModel;

  Future<void> getOne2OneList(BuildContext context) async {
    ApiResponse apiResponse = await one2oneRepo.one2oneRepo();
    if (apiResponse.response == null) {
      ApiChecker.checkApi(context, apiResponse);
    } else if (apiResponse.response!.statusCode == 200) {
      AppConstants.printLog(apiResponse.response!.data);
      //  Map map = apiResponse.response!.data;
      // //_homeBannerList=HomeBannerModel.fromJson(jsonDecode(apiResponse.response!.data.toString()));
      // AppConstants.printLog("init address fail");
      // //AppConstants.printLog(_homeBannerList);
      //
       //_one2oneModel=List<One2OneModel>.from(json.decode(apiResponse.response!.data).map((x) => One2OneModel.fromJson(x)));
      _one2oneModel = One2OneModel.fromJson(json.decode(apiResponse.response!.data));
      // AppConstants.printLog("Length> ${_homeBannerList.length}");
      //for(var item in _homeBannerList)



    } else {
      AppConstants.printLog("init address fail");
      ApiChecker.checkApi(context, apiResponse);
    }
    notifyListeners();
  }


}
