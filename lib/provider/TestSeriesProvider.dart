import 'dart:convert';
import 'package:exampur_mobile/Localization/language_constrants.dart';
import 'package:exampur_mobile/data/model/test_series_model.dart';
import 'package:exampur_mobile/data/model/my_course_list_model.dart';
import 'package:exampur_mobile/data/model/my_course_material_model.dart';
import 'package:exampur_mobile/data/model/my_course_notification_model.dart';
import 'package:exampur_mobile/data/model/my_course_subject_model.dart';
import 'package:exampur_mobile/data/model/my_course_timeline_model.dart';
import 'package:exampur_mobile/data/model/response/Base/api_response.dart';
import 'package:exampur_mobile/data/repository/MyCourseRepo.dart';
import 'package:exampur_mobile/data/repository/test_series_repo.dart';
import 'package:exampur_mobile/utils/lang_string.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:exampur_mobile/utils/app_colors.dart';
import 'package:exampur_mobile/utils/error_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TestSeriesProvider extends ChangeNotifier {
  final TestSeriesRepo testseriesRepo;
  TestSeriesProvider({required this.testseriesRepo});

  TestSeriesModel _testSeiesListModel = TestSeriesModel();
  TestSeriesModel get testSeiesListModel => _testSeiesListModel;



  Future<List<Data>?> getLiveTestSeriesList(BuildContext context) async {
    ApiResponse apiResponse = await testseriesRepo.liveTestSeriesData();

    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      var statusCode = apiResponse.response!.data['statusCode'].toString();
      if (statusCode == '200') {
        try {
          _testSeiesListModel = TestSeriesModel.fromJson(json.decode(apiResponse.response.toString()));
          return _testSeiesListModel.data??[];
        } catch(e) {
          return [];
        }
      } else {
        String error = apiResponse.response!.data['data'].toString();
        AppConstants.showBottomMessage(context, error, AppColors.black);
      }
      notifyListeners();
    } else {
      AppConstants.showBottomMessage(context, getTranslated(context, LangString.serverError)!, AppColors.red);
      AppConstants.goAndReplace(context, ErrorScreen());
      notifyListeners();
    }
  }

  Future<List<Data>?> getMyTestSeriesList(BuildContext context) async {
    ApiResponse apiResponse = await testseriesRepo.myTestSeriesData();

    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      var statusCode = apiResponse.response!.data['statusCode'].toString();
      if (statusCode == '200') {
        try {
          _testSeiesListModel = TestSeriesModel.fromJson(
              json.decode(apiResponse.response.toString()));
          return _testSeiesListModel.data ?? [];
        } catch(e) {
          return [];
        }
      } else {
        String error = apiResponse.response!.data['data'].toString();
        AppConstants.showBottomMessage(context, error, AppColors.black);
      }
      notifyListeners();
    } else {
      AppConstants.showBottomMessage(context, getTranslated(context, LangString.serverError)!, AppColors.red);
      AppConstants.goAndReplace(context, ErrorScreen());
      notifyListeners();
    }
  }

  Future<List<Data>?> getAllTestSeriesList(BuildContext context) async {
    ApiResponse apiResponse = await testseriesRepo.allTestSeriesData();

    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      var statusCode = apiResponse.response!.data['statusCode'].toString();
      if (statusCode == '200') {
        try {
          _testSeiesListModel = TestSeriesModel.fromJson(
              json.decode(apiResponse.response.toString()));
          return _testSeiesListModel.data ?? [];
        } catch(e) {
          return [];
        }
      } else {
        String error = apiResponse.response!.data['data'].toString();
        AppConstants.showBottomMessage(context, error, AppColors.black);
      }
      notifyListeners();
    } else {
      AppConstants.showBottomMessage(context, getTranslated(context, LangString.serverError)!, AppColors.red);
      AppConstants.goAndReplace(context, ErrorScreen());
      notifyListeners();
    }
  }
}