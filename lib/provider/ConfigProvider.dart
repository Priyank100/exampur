import 'dart:convert';

import 'package:exampur_mobile/Helper/api_checker.dart';
import 'package:exampur_mobile/Localization/language_constrants.dart';
import 'package:exampur_mobile/data/model/appp_toutorial.dart';
import 'package:exampur_mobile/data/model/response/Base/api_response.dart';
import 'package:exampur_mobile/data/repository/App_Toutorial.dart';
import 'package:exampur_mobile/data/repository/Demorepo.dart';

import 'package:exampur_mobile/data/repository/One2One_repo.dart';
import 'package:exampur_mobile/utils/app_colors.dart';

import 'package:exampur_mobile/utils/app_constants.dart';

import 'package:exampur_mobile/utils/error_screen.dart';
import 'package:exampur_mobile/utils/lang_string.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../data/model/DoubtCourseIdModel.dart';
import '../data/repository/config_Repo.dart';

class ConfigProvider extends ChangeNotifier {
  final ConfigRepo configRepo;

  ConfigProvider({required this.configRepo});


  Future<void> getContentLog(BuildContext context) async {
    ApiResponse apiResponse = await configRepo.contentRepo();
    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      var status = apiResponse.response!.data['status'];
      if (status == true) {
         AppConstants.contentLogList = List<String>.from(apiResponse.response!.data['courses']);
      } else {
        AppConstants.showBottomMessage(context, 'Status:false', AppColors.black);
      }
      notifyListeners();
    } else {
      AppConstants.showBottomMessage(
          context, getTranslated(context, LangString.serverError)!,
          AppColors.red);
      notifyListeners();
    }
  }

  Future<void> getDoubtCourseId(BuildContext context) async {
    ApiResponse apiResponse = await configRepo.doubtRepo();
    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      var status = apiResponse.response!.data['status'];
      if (status == true) {
        DoubtCourseIdModel model = DoubtCourseIdModel.fromJson(json.decode(apiResponse.response.toString()));
        AppConstants.doubtCourseIdList = model.courses! ;
      } else {
        AppConstants.showBottomMessage(context, 'Status:false', AppColors.black);
      }
      notifyListeners();
    } else {
      AppConstants.showBottomMessage(
          context, getTranslated(context, LangString.serverError)!,
          AppColors.red);
      notifyListeners();
    }
  }
}

class DoubtCourseId{
  String? course_id;
  String? web_id;
  DoubtCourseId({this.course_id,this.web_id});
}
