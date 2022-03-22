import 'dart:convert';
import 'package:exampur_mobile/Localization/language_constrants.dart';
import 'package:exampur_mobile/data/model/daily_quiz_model.dart';

import 'package:exampur_mobile/data/model/response/Base/api_response.dart';
import 'package:exampur_mobile/data/repository/DailyQuiz_repo.dart';

import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:exampur_mobile/utils/error_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DailyQuizProvider extends ChangeNotifier {
  final DailyQuizRepo dailyQuizRepo;
  DailyQuizProvider({required this.dailyQuizRepo});

  DailyQuizModel _dailyQuizListModel = DailyQuizModel();
  DailyQuizModel get dailyQuizListModel => _dailyQuizListModel;



  Future<List<Data>?> getDailyQuizList(BuildContext context,int pageNo) async {
    ApiResponse apiResponse = await dailyQuizRepo.dailyQuiz(pageNo);

    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      var statusCode = apiResponse.response!.data['statusCode'].toString();
      if (statusCode == '200') {
        _dailyQuizListModel = DailyQuizModel.fromJson(json.decode(apiResponse.response.toString()));
        return _dailyQuizListModel.data??[];
      } else {
        String error = apiResponse.response!.data['data'].toString();
        AppConstants.showBottomMessage(context, error, AppColors.black);
      }
      notifyListeners();
    } else {
      AppConstants.showBottomMessage(context, getTranslated(context, StringConstant.serverError)!, AppColors.red);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => ErrorScreen()
          )
      );
      notifyListeners();
    }
  }


}