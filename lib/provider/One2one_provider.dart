import 'dart:convert';
import 'package:exampur_mobile/Helper/api_checker.dart';
import 'package:exampur_mobile/Localization/language_constrants.dart';
import 'package:exampur_mobile/data/model/one2_one_models.dart';
import 'package:exampur_mobile/data/model/response/Base/api_response.dart';
import 'package:exampur_mobile/utils/lang_string.dart';
import 'package:exampur_mobile/data/repository/One2One_repo.dart';
import 'package:exampur_mobile/utils/app_colors.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:exampur_mobile/utils/error_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class One2OneProvider extends ChangeNotifier {
  final One2OneRepo one2oneRepo;

  One2OneProvider({required this.one2oneRepo});



  One2OneModels _one2oneModel = One2OneModels();
  One2OneModels get one2oneModel => _one2oneModel;

  Future<List<One2OneCourses>?> getOne2OneList(BuildContext context,int pageNo) async {
    ApiResponse apiResponse = await one2oneRepo.one2oneRepo(pageNo);
    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      var statusCode = apiResponse.response!.data['statusCode'].toString();
      if (statusCode == '200') {
        _one2oneModel = One2OneModels.fromJson(
            json.decode(apiResponse.response.toString()));
        return _one2oneModel.data;
      } else {
        String error = apiResponse.response!.data['data'].toString();
        AppConstants.showBottomMessage(context, error, AppColors.black);
      }
      notifyListeners();
    } else {
      AppConstants.showBottomMessage(
          context, getTranslated(context, LangString.serverError)!,
          AppColors.red);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => ErrorScreen()
          )
      );
      notifyListeners();
    }}

}
