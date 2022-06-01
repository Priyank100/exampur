import 'dart:collection';
import 'dart:convert';
import 'package:exampur_mobile/Localization/language_constrants.dart';
import 'package:exampur_mobile/data/model/ca_sm_model.dart';
import 'package:exampur_mobile/data/model/curent_affairs_new_tab_model.dart';
import 'package:exampur_mobile/data/model/current_affairs_new_detail_model.dart';
import 'package:exampur_mobile/data/model/current_affairs_new_list_model.dart';
import 'package:exampur_mobile/data/model/current_affairs_new_tag_list_model.dart';
import 'package:exampur_mobile/data/model/response/Base/api_response.dart';
import 'package:exampur_mobile/data/model/study_material_new_model.dart';
import 'package:exampur_mobile/data/model/study_material_sub_cat_model.dart';
import 'package:exampur_mobile/data/repository/CaRepo.dart';
import 'package:exampur_mobile/utils/api.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:exampur_mobile/utils/error_screen.dart';
import 'package:flutter/material.dart';

class CaProvider extends ChangeNotifier {
  final CaRepo caRepo;

  CaProvider({required this.caRepo});

  CaSmModel _caSmModel = CaSmModel();
  CaSmModel get caSmModel => _caSmModel;

  StudyMaterialSubCatModel _studyMaterialSubCatModel = StudyMaterialSubCatModel();
  StudyMaterialSubCatModel get studyMaterialSubCatModel => _studyMaterialSubCatModel;

  CurrentAffairsNewListModel _currentAffairsNewListModel = CurrentAffairsNewListModel();
  CurrentAffairsNewListModel get currentAffairsNewListModel => _currentAffairsNewListModel;

  CurrentAffairsNewDetailModel _currentAffairsNewDetailModel = CurrentAffairsNewDetailModel();
  CurrentAffairsNewDetailModel get currentAffairsNewDetailModel => _currentAffairsNewDetailModel;


  Future<List<Data>?> getCaSmList(BuildContext context, String contentCatId, String type, String encodeCat,int pageNo) async {
    ApiResponse apiResponse = await caRepo.caSmVideosContents(contentCatId, type, encodeCat,pageNo);

    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      var statusCode = apiResponse.response!.data['statusCode'].toString();
      if(statusCode == '200') {
        _caSmModel = CaSmModel.fromJson(json.decode(apiResponse.response.toString()));
        return _caSmModel.data ?? [];

      } else {
        String error = apiResponse.response!.data['data'].toString();
        AppConstants.showBottomMessage(context, error, AppColors.black);
      }
      notifyListeners();

    } else {
      AppConstants.showBottomMessage(context, getTranslated(context, StringConstant.serverError)!, AppColors.red);
      notifyListeners();
    }
  }

  //studyMaterialNew
  Future<List<StudyMaterialNewModel>?> getStudyMaterialNew(BuildContext context, String url) async {
    List<StudyMaterialNewModel> myList = [];
    ApiResponse apiResponse = await caRepo.studyMaterialNew(url);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      myList = List<StudyMaterialNewModel>.from(apiResponse.response!.data.map((x) => StudyMaterialNewModel.fromJson(x)));
      return myList;

    } else {
      AppConstants.showBottomMessage(context, getTranslated(context, StringConstant.serverError)!, AppColors.red);
      notifyListeners();
    }
  }

  Future<StudyMaterialSubCatModel?> getStudyMaterialSubCatData(BuildContext context, String catId) async {
    ApiResponse apiResponse = await caRepo.studyMaterialSubCatData(API.studyMaterialNewSubCatUrl, catId, '');
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      _studyMaterialSubCatModel = StudyMaterialSubCatModel.fromJson(json.decode(apiResponse.response.toString()));
      return _studyMaterialSubCatModel;

    } else {
      AppConstants.showBottomMessage(context, getTranslated(context, StringConstant.serverError)!, AppColors.red);
      notifyListeners();
    }
  }
  //studyMaterialNew


  //CurrentAffairsNew
  Future<List<CurentAffairsNewTabModel>?> getCurrentAffairsNewTab(BuildContext context) async {
    List<CurentAffairsNewTabModel> myList = [];
    ApiResponse apiResponse = await caRepo.studyMaterialNew(API.currentAffairsNewTabUrl);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      myList = List<CurentAffairsNewTabModel>.from(apiResponse.response!.data.map((x) => CurentAffairsNewTabModel.fromJson(x)));
      return myList;

    } else {
      AppConstants.showBottomMessage(context, getTranslated(context, StringConstant.serverError)!, AppColors.red);
      AppConstants.goAndReplace(context, ErrorScreen());
      notifyListeners();
    }
  }

  Future<CurrentAffairsNewListModel?> getCurrentAffairsNewList(BuildContext context, String url, String catId) async {
    ApiResponse apiResponse = await caRepo.studyMaterialSubCatData(url, catId, '');
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      _currentAffairsNewListModel = CurrentAffairsNewListModel.fromJson(json.decode(apiResponse.response.toString()));
      return _currentAffairsNewListModel;

    } else {
      AppConstants.showBottomMessage(context, getTranslated(context, StringConstant.serverError)!, AppColors.red);
      AppConstants.goAndReplace(context, ErrorScreen());
      notifyListeners();
    }
  }

  Future<CurrentAffairsNewDetailModel?> getCurrentAffairsNewDetail(BuildContext context, String articleId) async {
    ApiResponse apiResponse = await caRepo.studyMaterialSubCatData(API.currentAffairsNewDetailUrl, articleId,'');
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      _currentAffairsNewDetailModel = CurrentAffairsNewDetailModel.fromJson(json.decode(apiResponse.response.toString()));
      return _currentAffairsNewDetailModel;

    } else {
      AppConstants.showBottomMessage(context, getTranslated(context, StringConstant.serverError)!, AppColors.red);
      AppConstants.goAndReplace(context, ErrorScreen());
      notifyListeners();
    }
  }

  Future<CurrentAffairsNewListModel?> getCurrentAffairsNewListFilter(BuildContext context, String filter) async {
    ApiResponse apiResponse = await caRepo.studyMaterialSubCatData(API.currentAffairsNewListFilterUrl, '', filter);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      _currentAffairsNewListModel = CurrentAffairsNewListModel.fromJson(json.decode(apiResponse.response.toString()));
      return _currentAffairsNewListModel;

    } else {
      AppConstants.showBottomMessage(context, getTranslated(context, StringConstant.serverError)!, AppColors.red);
      AppConstants.goAndReplace(context, ErrorScreen());
      notifyListeners();
    }
  }

  Future<List<CurrentAffairsNewTagListModel>?> getCurrentAffairsTagList(BuildContext context) async {
    List<CurrentAffairsNewTagListModel> myList = [];
    ApiResponse apiResponse = await caRepo.studyMaterialNew(API.currentAffairsNewTagListUrl);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      myList = List<CurrentAffairsNewTagListModel>.from(apiResponse.response!.data.map((x) => CurrentAffairsNewTagListModel.fromJson(x)));
      return myList;

    } else {
      AppConstants.showBottomMessage(context, getTranslated(context, StringConstant.serverError)!, AppColors.red);
      AppConstants.goAndReplace(context, ErrorScreen());
      notifyListeners();
    }
  }

}