import 'dart:convert';

import 'package:exampur_mobile/Helper/api_checker.dart';
import 'package:exampur_mobile/Localization/language_constrants.dart';
import 'package:exampur_mobile/data/model/Userinfo.dart';
import 'package:exampur_mobile/data/model/banner_detail_model.dart';
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

  BannerDetailModel _bannerdetailModel = BannerDetailModel();
  BannerDetailModel get bannerdetailModel => _bannerdetailModel;

  //homeBanner request
  Future<List<BannerData>?> getHomeBannner(BuildContext context) async {
    ApiResponse apiResponse = await homeBannerRepo.getHomeBanner();

    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      var statusCode = apiResponse.response!.data['statusCode'].toString();
      if (statusCode == '200') {
        _bannerModel = HomeBannerModel.fromJson(
            json.decode(apiResponse.response.toString()));
        return _bannerModel.data;
      } else {
        String error = apiResponse.response!.data['data'].toString();
        AppConstants.showBottomMessage(context, error, AppColors.black);
      }
      notifyListeners();
    } else {
      AppConstants.showBottomMessage(
          context, getTranslated(context, StringConstant.serverError)!,
          AppColors.red);
      notifyListeners();
    }

  }

  Future<Data?> getHomeBannnerCourseDetail(BuildContext context,String id) async {
    ApiResponse apiResponse = await homeBannerRepo.getHomeBannerCourselink(id);
    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      var statusCode = apiResponse.response!.data['statusCode'].toString();
      if (statusCode == '200') {
        _bannerdetailModel = BannerDetailModel.fromJson(
            json.decode(apiResponse.response.toString()));
        return _bannerdetailModel.data;
      } else {
        String error = apiResponse.response!.data['data'].toString();
        AppConstants.showBottomMessage(context, error, AppColors.black);
      }
      notifyListeners();
    } else {
      AppConstants.showBottomMessage(
          context, getTranslated(context, StringConstant.serverError)!,
          AppColors.red);
      notifyListeners();
    }
  }

  Future<Data?> getHomeBannnerBookDetail(BuildContext context,String id) async {
    ApiResponse apiResponse = await homeBannerRepo.getHomeBannerBooklink(id);

    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      var statusCode = apiResponse.response!.data['statusCode'].toString();
      if (statusCode == '200') {
        _bannerdetailModel = BannerDetailModel.fromJson(
            json.decode(apiResponse.response.toString()));
        return _bannerdetailModel.data;
      } else {
        String error = apiResponse.response!.data['data'].toString();
        AppConstants.showBottomMessage(context, error, AppColors.black);
      }
      notifyListeners();
    } else {
      AppConstants.showBottomMessage(
          context, getTranslated(context, StringConstant.serverError)!,
          AppColors.red);
      notifyListeners();
    }
  }
}
