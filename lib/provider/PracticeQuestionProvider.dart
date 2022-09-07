import 'dart:convert';
import 'package:exampur_mobile/utils/lang_string.dart';
import 'package:exampur_mobile/Localization/language_constrants.dart';
import 'package:exampur_mobile/data/model/practice_question_categories_model.dart';
import 'package:exampur_mobile/data/model/practice_question_listing_model.dart';
import 'package:exampur_mobile/data/model/response/Base/api_response.dart';
import 'package:exampur_mobile/data/repository/PracticeQuestionRepo.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:exampur_mobile/utils/app_colors.dart';
import 'package:exampur_mobile/utils/error_screen.dart';
import 'package:flutter/material.dart';

class PracticeQuestionProvider extends ChangeNotifier {
  final PracticeQuestionRepo practiceQuestionRepo;

  PracticeQuestionProvider({required this.practiceQuestionRepo});

  PracticeQuestionCategoriesModel _practiceQuestionCategoriesModel = PracticeQuestionCategoriesModel();
  PracticeQuestionCategoriesModel get practiceQuestionCategoriesModel => _practiceQuestionCategoriesModel;

  PracticeQuestionListingModel _practiceQuestionListingModel = PracticeQuestionListingModel();
  PracticeQuestionListingModel get practiceQuestionListingModel => _practiceQuestionListingModel;

  Future<List<PracticeQuestionCategoriesModel>?> getPracticeQuestion(BuildContext context) async {
    List<PracticeQuestionCategoriesModel> myList = [];
    ApiResponse apiResponse = await practiceQuestionRepo.parcticequestion();
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      myList = List<PracticeQuestionCategoriesModel>.from(apiResponse.response!.data.map((x) => PracticeQuestionCategoriesModel.fromJson(x)));
      return myList;

    } else {
      AppConstants.showBottomMessage(context, getTranslated(context, LangString.serverError)!, AppColors.red);
      AppConstants.goAndReplace(context, ErrorScreen());
      notifyListeners();
    }
  }

//QuestionpaperApi
  Future<PracticeQuestionListingModel?> getPracticeQuestionListing(BuildContext context, String url) async {
    ApiResponse apiResponse = await practiceQuestionRepo.practiceQuestionList(url);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      _practiceQuestionListingModel = PracticeQuestionListingModel.fromJson(json.decode(apiResponse.response.toString()));
      return _practiceQuestionListingModel;

    } else {
      AppConstants.showBottomMessage(context, getTranslated(context, LangString.serverError)!, AppColors.red);
      AppConstants.goAndReplace(context, ErrorScreen());
      notifyListeners();
    }
  }
}