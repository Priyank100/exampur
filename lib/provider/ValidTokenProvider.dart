import 'dart:convert';

import 'package:exampur_mobile/Helper/api_checker.dart';
import 'package:exampur_mobile/SharePref/shared_pref.dart';
import 'package:exampur_mobile/data/model/UserInformationModel.dart';
import 'package:exampur_mobile/data/model/response/Base/api_response.dart';
import 'package:exampur_mobile/data/model/response/Base/error_response.dart';
import 'package:exampur_mobile/data/repository/VaildToken_repo.dart';
import 'package:exampur_mobile/presentation/authentication/landing_page.dart';
import 'package:exampur_mobile/presentation/home/bottom_navigation.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:flutter/material.dart';

class ValidTokenProvider extends ChangeNotifier {
  final ValidTokenRepo validTokenRepo;

  ValidTokenProvider({required this.validTokenRepo});

  UserInformationModel _informationModel=UserInformationModel();
  UserInformationModel get informationModel =>_informationModel;

  Future<void> tokenValidation(BuildContext context) async {
    ApiResponse apiResponse = await validTokenRepo.checkVaildToken();
    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      AppConstants.printLog(apiResponse.response);

      _informationModel = UserInformationModel.fromJson(
          json.decode(apiResponse.response.toString()));

      var statusCode = apiResponse.response!.data['statusCode'].toString();

      if (statusCode == '200') {
        SharedPref.saveSharedPref(
            AppConstants.TOKEN, _informationModel.data!.authToken.toString());
        AppConstants.printLog('ToKEN2>> ${_informationModel.data!.authToken}');
        // go to homepage

        Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (context) =>
                BottomNavigation()
            )
        );
      } else {
        String msg = _informationModel.data.toString();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(msg),
          backgroundColor: Colors.red,
        ));
        // go to login page
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (context) =>
                LandingPage()
            )
        );
      }

      notifyListeners();
    } else {
      String errorMessage;
      if (apiResponse.error is String) {
        AppConstants.printLog(apiResponse.error.toString());
        errorMessage = apiResponse.error.toString();
      } else {
        ErrorResponse errorResponse = apiResponse.error;
        AppConstants.printLog(errorResponse.errors![0].message);
        errorMessage = errorResponse.errors![0].message!;
      }
      //callback(false, errorMessage);
      notifyListeners();
    }
  }
}