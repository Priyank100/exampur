import 'dart:convert';

import 'package:exampur_mobile/Helper/api_checker.dart';
import 'package:exampur_mobile/SharePref/shared_pref.dart';
import 'package:exampur_mobile/data/model/UserInformationModel.dart';
import 'package:exampur_mobile/data/model/Userinfo.dart';
import 'package:exampur_mobile/data/model/createUserModel.dart';
import 'package:exampur_mobile/data/model/loginmodel.dart';
import 'package:exampur_mobile/data/model/response/Base/api_response.dart';
import 'package:exampur_mobile/data/model/response/Base/error_response.dart';
import 'package:exampur_mobile/data/repository/Authrepo.dart';
import 'package:exampur_mobile/presentation/authentication/landing_page.dart';
import 'package:exampur_mobile/presentation/drawer/choose_category.dart';
import 'package:exampur_mobile/presentation/home/bottom_navigation.dart';
import 'package:exampur_mobile/utils/app_constants.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  final AuthRepo authRepo;

  AuthProvider({required this.authRepo});

  UserInfo _userInfo=UserInfo();
  UserInfo get userInfo => _userInfo;

  UserInformationModel _informationModel=UserInformationModel();
  UserInformationModel get informationModel =>_informationModel;

  CreateUserModel _userupdate =CreateUserModel();
  CreateUserModel get uerupdate =>_userupdate;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  ///login
  Future login(LoginModel loginBody, Function callback) async {
    _isLoading = true;
    ApiResponse apiResponse = await authRepo.login(loginBody);
    _isLoading = false;
    print("login provider entered");
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      AppConstants.printLog(apiResponse.response);

      var statusCode = apiResponse.response!.data['statusCode'].toString();
      if(statusCode == '200') {
        _informationModel = UserInformationModel.fromJson(json.decode(apiResponse.response.toString()));
        SharedPref.saveSharedPref(AppConstants.TOKEN, _informationModel.data!.authToken.toString());
        AppConstants.printLog('ToKEN2>> ${_informationModel.data!.authToken}');

        List<UserInformationModel> _userData = [];
        _userData.add(_informationModel);
        await SharedPref.saveSharedPref(AppConstants.USER_DATA, jsonEncode(_userData));

        callback(true, '');
      } else {

        callback(false, apiResponse.response!.data['data'].toString());
      }

      notifyListeners();
    } else {
      String errorMessage;
      print("eeeror ");
      if (apiResponse.error is String) {
        AppConstants.printLog(apiResponse.error.toString());
        errorMessage = apiResponse.error.toString();
      } else {
        ErrorResponse errorResponse = apiResponse.error;
        AppConstants.printLog(errorResponse.errors![0].message);
        errorMessage = errorResponse.errors![0].message!;
      }
      callback(false, errorMessage);
      notifyListeners();
    }
  }

  ///userRegister
  Future userResgister(CreateUserModel registerModel, Function callback) async {
    _isLoading = true;
    ApiResponse apiResponse = await authRepo.registerUser(registerModel);
    _isLoading = false;
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      AppConstants.printLog(apiResponse.response);



      var statusCode = apiResponse.response!.data['statusCode'].toString();
      if(statusCode == '200') {
        _informationModel = UserInformationModel.fromJson(json.decode(apiResponse.response.toString()));

        SharedPref.saveSharedPref(AppConstants.TOKEN, _informationModel.data!.authToken.toString());
        AppConstants.printLog('ToKEN2>> ${_informationModel.data!.authToken}');

        List<UserInformationModel> _userData = [];
        _userData.add(_informationModel);
        await SharedPref.saveSharedPref(AppConstants.USER_DATA, jsonEncode(_userData));

        callback(true, '');
      } else {
        callback(false, apiResponse.response!.data['data'].toString());
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
      callback(false, errorMessage);
      notifyListeners();
    }
  }

///UpdateUser
  Future updateUserProfile(CreateUserModel registerModel) async {
    // _isLoading = true;
    ApiResponse apiResponse = await authRepo.updateProfile(registerModel);
    // _isLoading = false;
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      AppConstants.printLog(apiResponse.response);

      var statusCode = apiResponse.response!.data['statusCode'].toString();
      if(statusCode == '200') {
        _informationModel = UserInformationModel.fromJson(json.decode(apiResponse.response.toString()));
        List<UserInformationModel> _userData = [];
        _userData.add(_informationModel);
        await SharedPref.saveSharedPref(AppConstants.USER_DATA, jsonEncode(_userData));
        return true;

       // callback(true, '');
      } else {
        return false;
      //  callback(false, apiResponse.response!.data['data'].toString());
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

      notifyListeners();
    }
  }


  ///TokenValidate
  Future<void> tokenValidation(BuildContext context) async {
    ApiResponse apiResponse = await authRepo.checkVaildToken();
    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      AppConstants.printLog(apiResponse.response);

      var statusCode = apiResponse.response!.data['statusCode'].toString();

      if (statusCode == '200') {
        _informationModel = UserInformationModel.fromJson(json.decode(apiResponse.response.toString()));
        SharedPref.saveSharedPref(AppConstants.TOKEN, _informationModel.data!.authToken.toString());
        AppConstants.printLog('ToKEN2>> ${_informationModel.data!.authToken}');

        List<UserInformationModel> _userData = [];
        _userData.add(_informationModel);
        await SharedPref.saveSharedPref(AppConstants.USER_DATA, jsonEncode(_userData));

        checkSelectCategory(context);

      } else {
        String msg = _informationModel.data.toString();
        AppConstants.printLog(_informationModel.data.toString());
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

  Future<void> checkSelectCategory(context) async {

    await SharedPref.getSharedPref(AppConstants.SELECT_CATEGORY_LENGTH).then((value) => {
      if(value == '0') {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (context) =>
                ChooseCategory()
            )
        )
      } else {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (context) =>
                BottomNavigation()
            )
        )
      }
    });
  }

}
