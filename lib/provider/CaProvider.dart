import 'dart:convert';

import 'package:exampur_mobile/Helper/api_checker.dart';
import 'package:exampur_mobile/data/model/ca_content_model.dart';
import 'package:exampur_mobile/data/model/response/Base/api_response.dart';
import 'package:exampur_mobile/data/model/video_ca_model.dart';
import 'package:exampur_mobile/data/repository/CaRepo.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:flutter/material.dart';

class CaProvider extends ChangeNotifier {
  final CaRepo caRepo;

  CaProvider({required this.caRepo});

  VideoCaModel _caVideoModel = VideoCaModel();
  VideoCaModel get caVideoModel => _caVideoModel;

  CaContentModel _caContentModel = CaContentModel();
  CaContentModel get caContentModel => _caContentModel;


  /*Future<List<Data>?> getCaVideoList(BuildContext context) async {
    ApiResponse apiResponse = await caRepo.caVideos();
    if (apiResponse.response == null) {
      ApiChecker.checkApi(context, apiResponse);
    } else if (apiResponse.response!.statusCode == 200) {
      _caVideoModel = VideoCaModel.fromJson(json.decode(apiResponse.response.toString()));
      return _caVideoModel.data ?? [];

    } else {
      AppConstants.printLog("init address fail");
      ApiChecker.checkApi(context, apiResponse);
    }
    notifyListeners();
  }*/


  /*Future<List<Data>?> getCaContentList(BuildContext context) async {
    ApiResponse apiResponse = await caRepo.caContents();
    if (apiResponse.response == null) {
      ApiChecker.checkApi(context, apiResponse);
    } else if (apiResponse.response!.statusCode == 200) {
      AppConstants.printLog(apiResponse.response);
      _caContentModel = CaContentModel.fromJson(json.decode(apiResponse.response.toString()));
      return _caContentModel.data ?? [];

    } else {
      AppConstants.printLog("init address fail");
      ApiChecker.checkApi(context, apiResponse);
    }
    notifyListeners();
  }*/
}