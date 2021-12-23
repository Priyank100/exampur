import 'dart:convert';

import 'package:exampur_mobile/Helper/api_checker.dart';
import 'package:exampur_mobile/data/model/Userinfo.dart';
import 'package:exampur_mobile/data/model/loginmodel.dart';
import 'package:exampur_mobile/data/model/response/Base/api_response.dart';
import 'package:exampur_mobile/data/model/response/Base/error_response.dart';
import 'package:exampur_mobile/data/model/response/HomeBannerModel.dart';
import 'package:exampur_mobile/data/repository/Authrepo.dart';
import 'package:exampur_mobile/data/repository/HomeBanner_repo.dart';
import 'package:exampur_mobile/utils/app_constants.dart';

import 'package:flutter/cupertino.dart';

class HomeBannerProvider extends ChangeNotifier {
  final HomeBannerRepo homeBannerRepo;

  HomeBannerProvider({required this.homeBannerRepo});

  List<HomeBannerModel> _homeBannerList = [];
 // HomeBannerModel _userInfo=UserInfo();

  List<HomeBannerModel> get homeBannerModel => _homeBannerList;
 // HomeBannerModel get homeBannerModel => _homeBannerList;

  ///homeBanner request
  Future<void> getHomeBannner(BuildContext context) async {
    ApiResponse apiResponse = await homeBannerRepo.getHomeBanner();
    if (apiResponse.response == null) {
      ApiChecker.checkApi(context, apiResponse);
    } else if (apiResponse.response!.statusCode == 200) {
      AppConstants.printLog(apiResponse.response);
      //  Map map = apiResponse.response!.data;
      // //_homeBannerList=HomeBannerModel.fromJson(jsonDecode(apiResponse.response!.data.toString()));
      // AppConstants.printLog("init address fail");
      // //AppConstants.printLog(_homeBannerList);
      //
      _homeBannerList=List<HomeBannerModel>.from(json.decode(apiResponse.response!.data).map((x) => HomeBannerModel.fromJson(x)));
      // AppConstants.printLog("Length> ${_homeBannerList.length}");
      //for(var item in _homeBannerList)



    } else {
      AppConstants.printLog("init address fail");
      ApiChecker.checkApi(context, apiResponse);
    }
    notifyListeners();
  }


}
