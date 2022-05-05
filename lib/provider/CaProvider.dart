import 'dart:convert';
import 'package:exampur_mobile/Localization/language_constrants.dart';
import 'package:exampur_mobile/data/model/StudtMaterialNewModel.dart';
import 'package:exampur_mobile/data/model/ca_sm_model.dart';
import 'package:exampur_mobile/data/model/response/Base/api_response.dart';
import 'package:exampur_mobile/data/repository/CaRepo.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:flutter/material.dart';

class CaProvider extends ChangeNotifier {
  final CaRepo caRepo;

  CaProvider({required this.caRepo});

  CaSmModel _caSmModel = CaSmModel();
  CaSmModel get caSmModel => _caSmModel;


  StudyMaterialNewModel _studyMaterialNew = StudyMaterialNewModel();
  StudyMaterialNewModel get studyMaterialNew => _studyMaterialNew;


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
      // Navigator.pushReplacement(
      //     context,
      //     MaterialPageRoute(
      //         builder: (context) => ErrorScreen()
      //     )
      // );
      notifyListeners();
    }
  }

  //studyMaterialNew
  Future<List<StudyMaterialNewModel>?> getStudyMaterialNew(BuildContext context) async {
    ApiResponse apiResponse = await caRepo.studyMaterialNew();
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
        _studyMaterialNew = StudyMaterialNewModel.fromJson(json.decode(apiResponse.response.toString()));
        // return _studyMaterialNew ?? [];

    } else {
      AppConstants.showBottomMessage(context, getTranslated(context, StringConstant.serverError)!, AppColors.red);
      notifyListeners();
    }
  }
}