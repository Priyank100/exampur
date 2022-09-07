import 'dart:convert';
import 'package:exampur_mobile/Localization/language_constrants.dart';
import 'package:exampur_mobile/data/model/Free_video_content_model.dart';
import 'package:exampur_mobile/data/model/free_video_list_model.dart';
import 'package:exampur_mobile/data/model/free_video_model.dart';
import 'package:exampur_mobile/data/model/response/Base/api_response.dart';
import 'package:exampur_mobile/data/repository/FreeVideosRepo.dart';
import 'package:exampur_mobile/utils/api.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:exampur_mobile/utils/app_colors.dart';
import 'package:exampur_mobile/utils/error_screen.dart';
import 'package:flutter/material.dart';
import 'package:exampur_mobile/utils/lang_string.dart';

class FreeVideoProvider extends ChangeNotifier {
  final FreeVideosRepo freeVideosRepo;

  FreeVideoProvider({required this.freeVideosRepo});

  FreeVideoModel _freeVideoModel = FreeVideoModel();
  FreeVideoModel get freeVideoModel => _freeVideoModel;

  FreeVideoListModel _freeVideoListModel = FreeVideoListModel();
  FreeVideoListModel get freeVideoListModel => _freeVideoListModel;

  FreeVideoContentModel _freeVideoContentListModel = FreeVideoContentModel();
  FreeVideoContentModel get freeVideoContentListModel => _freeVideoContentListModel;

  Future<List<FreeVideoModel>?> getfreeVideo(BuildContext context,String url) async {
    ApiResponse apiResponse = await freeVideosRepo.freeVideos(url);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      List<FreeVideoModel> myList = List<FreeVideoModel>.from(apiResponse.response!.data.map((x) => FreeVideoModel.fromJson(x)));
      return myList;

    } else {
      AppConstants.showBottomMessage(context, getTranslated(context, LangString.serverError), AppColors.red);
      AppConstants.goAndReplace(context, ErrorScreen());
    }
    notifyListeners();
  }


  Future<FreeVideoListModel?> getfreeVideoList(BuildContext context,String subjectId) async {
    ApiResponse apiResponse = await freeVideosRepo.freeVideosList(API.freeVideoListUrl,subjectId);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      _freeVideoListModel = FreeVideoListModel.fromJson(json.decode(apiResponse.response.toString()));
      return _freeVideoListModel;
    } else {
      AppConstants.showBottomMessage(context, getTranslated(context, LangString.serverError), AppColors.red);
      AppConstants.goAndReplace(context, ErrorScreen());
    }
    notifyListeners();
  }
  Future<FreeVideoContentModel?> getfreeVideoContentList(BuildContext context,String subjectId) async {
    ApiResponse apiResponse = await freeVideosRepo.freeVideosList(API.freeVideoContentUrl,subjectId);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      _freeVideoContentListModel = FreeVideoContentModel.fromJson(json.decode(apiResponse.response.toString()));
      return _freeVideoContentListModel;
    } else {
      AppConstants.showBottomMessage(context, getTranslated(context, LangString.serverError), AppColors.red);
      AppConstants.goAndReplace(context, ErrorScreen());
    }
    notifyListeners();
  }
}