import 'dart:convert';

import 'package:exampur_mobile/Helper/api_checker.dart';
import 'package:exampur_mobile/SharePref/shared_pref.dart';
import 'package:exampur_mobile/data/datasource/remote/http/services.dart';
import 'package:exampur_mobile/data/model/UserInformationModel.dart';
import 'package:exampur_mobile/data/model/Userinfo.dart';
import 'package:exampur_mobile/data/model/createUserModel.dart';
import 'package:exampur_mobile/data/model/loginmodel.dart';
import 'package:exampur_mobile/data/model/response/Base/api_response.dart';
import 'package:exampur_mobile/data/model/response/Base/error_response.dart';
import 'package:exampur_mobile/data/repository/Authrepo.dart';
import 'package:exampur_mobile/presentation/authentication/landing_page.dart';
import 'package:exampur_mobile/presentation/authentication/otp_screen.dart';
import 'package:exampur_mobile/presentation/drawer/choose_category.dart';
import 'package:exampur_mobile/presentation/home/LandingChooseCategory.dart';
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
    ApiResponse apiResponse = await authRepo.updateProfile(registerModel);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      AppConstants.printLog(apiResponse.response);

      var statusCode = apiResponse.response!.data['statusCode'].toString();
      if(statusCode == '200') {
        _informationModel = UserInformationModel.fromJson(json.decode(apiResponse.response.toString()));
        List<UserInformationModel> _userData = [];
        _userData.add(_informationModel);
        await SharedPref.saveSharedPref(AppConstants.USER_DATA, jsonEncode(_userData));
        return true;
      } else {
        return false;
      }
      // notifyListeners();
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
      return false;
    }
  }


  ///TokenValidate
  Future<void> tokenValidation(BuildContext context) async {
    ApiResponse apiResponse = await authRepo.checkValidToken();
    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      AppConstants.printLog(apiResponse.response);

      var statusCode = apiResponse.response!.data['statusCode'].toString();
      String data = apiResponse.response!.data['data'].toString();

      if (statusCode == '200') {
        _informationModel = UserInformationModel.fromJson(json.decode(apiResponse.response.toString()));
        SharedPref.saveSharedPref(AppConstants.TOKEN, _informationModel.data!.authToken.toString());

        List<UserInformationModel> _userData = [];
        _userData.add(_informationModel);
        await SharedPref.saveSharedPref(AppConstants.USER_DATA, jsonEncode(_userData));

        checkSelectCategory(context);

      } else {
        // String msg = _informationModel.data.toString();
        // AppConstants.printLog('priyank>>'+_informationModel.data.toString());
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Logged Out'),
          backgroundColor: Colors.black,
        ));
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
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Server Error'),
        backgroundColor: Colors.black,
      ));
      notifyListeners();
    }
  }

  Future<void> getBannerBaseUrl(context) async {
    await Service.get(AppConstants.BANNER_BASE_URL).then((response) async {
      // {"statusCode":200,"data":"https://exampur-mumbai.b-cdn.net"}
      if(response != null && response.statusCode == 200) {
        var jsonObject =  jsonDecode(response.body);
        if(jsonObject['statusCode'].toString() == '200') {
          await SharedPref.saveSharedPref(AppConstants.BANNER_BASE_SP, jsonObject['data'].toString());
          AppConstants.BANNER_BASE = jsonObject['data'].toString() + '/';
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(jsonObject['data'].toString()),
            backgroundColor: Colors.red,
          ));
        }

      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Server Error'),
          backgroundColor: Colors.red,
        ));
      }
    });
  }

  Future<void> checkSelectCategory(context) async {

    await SharedPref.getSharedPref(AppConstants.SELECT_CATEGORY_LENGTH).then((value) => {
      if(value == '0') {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (context) =>
                LandingChooseCategory()
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

  Future changePasswordPro(context, parameters) async {
    ApiResponse apiResponse = await authRepo.changePassword(parameters);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      AppConstants.printLog(apiResponse.response);

      var statusCode = apiResponse.response!.data['statusCode'].toString();
      var msg = apiResponse.response!.data['data'].toString();
      if(statusCode == '200') {
        AppConstants.showBottomMessage(context, msg, Colors.black);
        notifyListeners();
        return true;
      } else {
        AppConstants.showBottomMessage(context, msg, Colors.black);
        notifyListeners();
        return false;
      }

    } else {
      String errorMessage = '';
      if (apiResponse.error is String) {
        AppConstants.printLog(apiResponse.error.toString());
        errorMessage = apiResponse.error.toString();
      } else {
        ErrorResponse errorResponse = apiResponse.error;
        AppConstants.printLog(errorResponse.errors![0].message);
        errorMessage = errorResponse.errors![0].message!;
      }
      AppConstants.showBottomMessage(context, errorMessage, Colors.red);
      notifyListeners();
      return false;
    }
  }

}
