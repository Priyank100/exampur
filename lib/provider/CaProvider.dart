import 'dart:collection';
import 'dart:convert';
import 'package:exampur_mobile/Localization/language_constrants.dart';
import 'package:exampur_mobile/data/model/ca_sm_model.dart';
import 'package:exampur_mobile/data/model/response/Base/api_response.dart';
import 'package:exampur_mobile/data/model/study_material_new_model.dart';
import 'package:exampur_mobile/data/model/study_material_sub_cat_model.dart';
import 'package:exampur_mobile/data/repository/CaRepo.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:flutter/material.dart';

class CaProvider extends ChangeNotifier {
  final CaRepo caRepo;

  CaProvider({required this.caRepo});

  CaSmModel _caSmModel = CaSmModel();
  CaSmModel get caSmModel => _caSmModel;

  StudyMaterialSubCatModel _studyMaterialSubCatModel = StudyMaterialSubCatModel();
  StudyMaterialSubCatModel get studyMaterialSubCatModel => _studyMaterialSubCatModel;


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
    ApiResponse apiResponse = await caRepo.studyMaterialSubCatData(catId);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      _studyMaterialSubCatModel = StudyMaterialSubCatModel.fromJson(json.decode(apiResponse.response.toString()));
      return _studyMaterialSubCatModel;

    } else {
      AppConstants.showBottomMessage(context, getTranslated(context, StringConstant.serverError)!, AppColors.red);
      notifyListeners();
    }
  }
  //studyMaterialNew

}