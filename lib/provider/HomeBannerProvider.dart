import 'dart:convert';

import 'package:exampur_mobile/Helper/api_checker.dart';
import 'package:exampur_mobile/data/model/Userinfo.dart';
import 'package:exampur_mobile/data/model/loginmodel.dart';
import 'package:exampur_mobile/data/model/response/Base/api_response.dart';
import 'package:exampur_mobile/data/model/response/home_banner_model.dart';
import 'package:exampur_mobile/data/repository/Authrepo.dart';
import 'package:exampur_mobile/data/repository/HomeBanner_repo.dart';
import 'package:exampur_mobile/utils/app_constants.dart';

import 'package:flutter/cupertino.dart';

class HomeBannerProvider extends ChangeNotifier {
  final HomeBannerRepo homeBannerRepo;

  HomeBannerProvider({required this.homeBannerRepo});

  // List<HomeBannerModel> _homeBannerList = [];
  // List<HomeBannerModel> get homeBannerModel => _homeBannerList;

  HomeBannerModel _bannerModel = HomeBannerModel();
  HomeBannerModel get bannerModel => _bannerModel;

  //homeBanner request
  Future<List<BannerData>?> getHomeBannner(BuildContext context) async {
    ApiResponse apiResponse = await homeBannerRepo.getHomeBanner();
    if (apiResponse.response == null) {
      ApiChecker.checkApi(context, apiResponse);
    } else if (apiResponse.response!.statusCode == 200) {
      AppConstants.printLog(apiResponse.response);
      // _homeBannerList=List<HomeBannerModel>.from(json.decode(apiResponse.response!.data).map((x) => HomeBannerModel.fromJson(x)));
      _bannerModel = HomeBannerModel.fromJson(json.decode(apiResponse.response.toString()));
      return _bannerModel.data;

    } else {
      AppConstants.printLog("init address fail");
      ApiChecker.checkApi(context, apiResponse);
    }
    notifyListeners();
  }


}
