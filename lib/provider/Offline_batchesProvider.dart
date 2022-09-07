import 'dart:convert';
import 'package:exampur_mobile/Helper/api_checker.dart';
import 'package:exampur_mobile/data/model/offlice_batch_center_model.dart';
import 'package:exampur_mobile/data/model/offline_batch_center_courses_model.dart';
import 'package:exampur_mobile/data/model/offlinebatches_courses_video.dart';
import 'package:exampur_mobile/data/model/response/Base/api_response.dart';
import 'package:exampur_mobile/data/repository/OfflineBatches_repo.dart';
import 'package:exampur_mobile/utils/app_constants.dart';

import 'package:flutter/cupertino.dart';

class OfflinebatchesProvider extends ChangeNotifier {
  final OfflineBatchesRepo offlinebatchesRepo;
  OfflinebatchesProvider({required this.offlinebatchesRepo});

  OffliceBatchCenterModel _offlineBatchesCenterModel = OffliceBatchCenterModel();
  OffliceBatchCenterModel get offlineBatchesCenterModel => _offlineBatchesCenterModel;

  OfflineBatchCenterCoursesModel _offlineBatchesCenterCoursesModel = OfflineBatchCenterCoursesModel();
  OfflineBatchCenterCoursesModel get offlineBatchesCenterCoursesModel => _offlineBatchesCenterCoursesModel;

  OfflinebatchesCoursesVideo _offlinebatchesCoursesVideo = OfflinebatchesCoursesVideo();
  OfflinebatchesCoursesVideo get offlinebatchesCoursesVideo => _offlinebatchesCoursesVideo;

  Future<List<CenterListModel>?> getOfflineBatchCenterList(BuildContext context, int pageNo) async {
    ApiResponse apiResponse = await offlinebatchesRepo.offlineBatchCenterRepo(pageNo);
    if (apiResponse.response == null) {
      ApiChecker.checkApi(context, apiResponse);
    } else if (apiResponse.response!.statusCode == 200) {
      AppConstants.printLog(apiResponse.response);
      _offlineBatchesCenterModel =OffliceBatchCenterModel.fromJson(json.decode(apiResponse.response.toString()));
      return _offlineBatchesCenterModel.data;

    } else {
      AppConstants.printLog("init address fail");
      ApiChecker.checkApi(context, apiResponse);
    }
    notifyListeners();
  }

  Future<OfflineBatchCenterCoursesModel?> getOfflineBatchCenterCoursesData(BuildContext context, String id, int pageNo) async {
    ApiResponse apiResponse = await offlinebatchesRepo.offlineBatchCenterCoursesRepo(id, pageNo);
    if (apiResponse.response == null) {
      ApiChecker.checkApi(context, apiResponse);
    } else if (apiResponse.response!.statusCode == 200) {
      AppConstants.printLog(apiResponse.response);
      _offlineBatchesCenterCoursesModel =OfflineBatchCenterCoursesModel.fromJson(json.decode(apiResponse.response.toString()));
      return _offlineBatchesCenterCoursesModel;

    } else {
      AppConstants.printLog("init address fail");
      ApiChecker.checkApi(context, apiResponse);
    }
    notifyListeners();
  }


  Future<OfflinebatchesCoursesVideo?> getOfflineBatchCenterCoursesVideoData(BuildContext context, String id) async {
    ApiResponse apiResponse = await offlinebatchesRepo.offlineBatchCenterCoursesVideoRepo(id);
    if (apiResponse.response == null) {
      ApiChecker.checkApi(context, apiResponse);
    } else if (apiResponse.response!.statusCode == 200) {
      AppConstants.printLog(apiResponse.response);
      _offlinebatchesCoursesVideo =OfflinebatchesCoursesVideo.fromJson(json.decode(apiResponse.response.toString()));
      AppConstants.printLog('Ancha'+ _offlinebatchesCoursesVideo.data!.amount.toString());
      return _offlinebatchesCoursesVideo;

    } else {
      AppConstants.printLog("init address fail");
      ApiChecker.checkApi(context, apiResponse);
    }
    notifyListeners();
  }

}
