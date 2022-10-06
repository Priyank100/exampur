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
import 'package:exampur_mobile/utils/api.dart';
import 'package:exampur_mobile/utils/app_colors.dart';

import 'package:exampur_mobile/utils/app_constants.dart';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/analytics_constants.dart';

class AuthProvider extends ChangeNotifier {
  final AuthRepo authRepo;

  AuthProvider({required this.authRepo});

  UserInfo _userInfo=UserInfo();
  UserInfo get userInfo => _userInfo;

  UserInformationModel _informationModel=UserInformationModel();
  UserInformationModel get informationModel =>_informationModel;

  // CreateUserModel _userupdate =CreateUserModel();
  // CreateUserModel get uerupdate =>_userupdate;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  ///login
  Future login(BuildContext context, LoginModel loginBody, Function callback) async {
    _isLoading = true;
    ApiResponse apiResponse = await authRepo.login(loginBody);
    _isLoading = false;
    AppConstants.printLog("login provider entered");
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      AppConstants.printLog(apiResponse.response);

      var statusCode = apiResponse.response!.data['statusCode'].toString();
      if(statusCode == '200') {
        _informationModel = UserInformationModel.fromJson(json.decode(apiResponse.response.toString()));

        //MoEngage
        AppConstants.userName = _informationModel.data!.firstName.toString();
        AppConstants.userMobile = _informationModel.data!.phone.toString();
        AnalyticsConstants.moengagePlugin.setUserName(AppConstants.userName);
        AnalyticsConstants.moengagePlugin.setPhoneNumber(AppConstants.userMobile);
        // AnalyticsConstants.moengagePlugin.setUniqueId(AppConstants.userMobile);

        await SharedPref.saveSharedPref(SharedPref.TOKEN, _informationModel.data!.authToken.toString());
        AppConstants.printLog('ToKEN>> ${_informationModel.data!.authToken}');

        List<UserInformationModel> _userData = [];
        _userData.add(_informationModel);
        await SharedPref.saveSharedPref(SharedPref.USER_DATA, jsonEncode(_userData));
        // callback(true, '');

        AppConstants.CATEGORY_LENGTH = _informationModel.data!.countCategories.toString();
        AppConstants.isotpverify = _informationModel.data!.phoneConf!;
        if(_informationModel.data!.phoneConf == true) {
          // callback(true, '');
          checkSelectCategory(context, _informationModel.data!.countCategories);

        } else {
          Navigator.push(context, MaterialPageRoute(builder: (_) => OtpScreen(false)));
        }

      } else {
        var map = {
          'Page_Name':'App_Login',
          'Mobile_Number':loginBody.phone.toString(),
          'Language':'Eng',
          'User_ID':loginBody.phone.toString()
        };
        AnalyticsConstants.trackEventMoEngage(AnalyticsConstants.Error_Invalid_Mobile,map);
        callback(false, apiResponse.response!.data['data'].toString());
      }

      notifyListeners();
    } else {
      String errorMessage;
      AppConstants.printLog("eeeror ");
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
  Future userResgister(BuildContext context, CreateUserModel registerModel, Function callback) async {
    AppConstants.showLoaderDialog(context);
    ApiResponse apiResponse = await authRepo.registerUser(registerModel);
    Navigator.pop(context);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      AppConstants.printLog(apiResponse.response);
      var statusCode = apiResponse.response!.data['statusCode'].toString();
      if(statusCode == '200') {
        _informationModel = UserInformationModel.fromJson(json.decode(apiResponse.response.toString()));

        //MoEngage
        AppConstants.userName = _informationModel.data!.firstName.toString();
        AppConstants.userMobile = _informationModel.data!.phone.toString();
        AnalyticsConstants.moengagePlugin.setUserName(AppConstants.userName);
        AnalyticsConstants.moengagePlugin.setPhoneNumber(AppConstants.userMobile);
        // AnalyticsConstants.moengagePlugin.setUniqueId(AppConstants.userMobile);

        await SharedPref.saveSharedPref(SharedPref.TOKEN, _informationModel.data!.authToken.toString());
        AppConstants.printLog('ToKEN>> ${_informationModel.data!.authToken}');
        AppConstants.isotpverify = _informationModel.data!.phoneConf!;

        List<UserInformationModel> _userData = [];
        _userData.add(_informationModel);
        await SharedPref.saveSharedPref(SharedPref.USER_DATA, jsonEncode(_userData));
        AppConstants.CATEGORY_LENGTH = _informationModel.data!.countCategories.toString();

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
        await SharedPref.saveSharedPref(SharedPref.USER_DATA, jsonEncode(_userData));
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
  Future<void> tokenValidation(BuildContext context, String token) async {
    ApiResponse apiResponse = await authRepo.checkValidToken(token);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      AppConstants.printLog(apiResponse.response);

      var statusCode = apiResponse.response!.data['statusCode'].toString();
      List<UserInformationModel> _userData = [];

      if (statusCode == '200') {
        _informationModel = UserInformationModel.fromJson(json.decode(apiResponse.response.toString()));

        //MoEngage
        AppConstants.userName = _informationModel.data!.firstName.toString();
        AppConstants.userMobile = _informationModel.data!.phone.toString();
        AnalyticsConstants.moengagePlugin.setUserName(AppConstants.userName);
        AnalyticsConstants.moengagePlugin.setPhoneNumber(AppConstants.userMobile);
        // AnalyticsConstants.moengagePlugin.setUniqueId(AppConstants.userMobile);

        await SharedPref.saveSharedPref(SharedPref.TOKEN, _informationModel.data!.authToken.toString());
        _userData.add(_informationModel);
        await SharedPref.saveSharedPref(SharedPref.USER_DATA, jsonEncode(_userData));

        AppConstants.CATEGORY_LENGTH = _informationModel.data!.countCategories.toString();
        AppConstants.isotpverify = _informationModel.data!.phoneConf??false;
        if(_informationModel.data!.phoneConf == true) {
          checkSelectCategory(context, _informationModel.data!.countCategories);
        } else {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => OtpScreen(false)));
        }

      } else {
        // String msg = _informationModel.data.toString();
        AppConstants.showBottomMessage(context, 'Logged Out', AppColors.black);
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
        backgroundColor: AppColors.black,
      ));
      notifyListeners();
    }
  }

  Future<void> getBannerBaseUrl(context) async {
    await Service.get(API.BANNER_BASE_URL).then((response) async {
      // {"statusCode":200,"data":"https://exampur-mumbai.b-cdn.net"}

      if(response != null && response.statusCode == 200) {
        var jsonObject =  jsonDecode(response.body);
        if(jsonObject['statusCode'].toString() == '200') {
          // await SharedPref.saveSharedPref(SharedPref.BANNER_BASE_SP, jsonObject['data'].toString());
          AppConstants.printLog('BANNER_BASE>> ' + jsonObject['data'].toString());
          AppConstants.BANNER_BASE = jsonObject['data'].toString() + '/';
        } else {
          AppConstants.showBottomMessage(context, jsonObject['data'].toString(), AppColors.red);
        }

      } else {
        AppConstants.showBottomMessage(context, 'Server Error', AppColors.red);
      }
    });
  }

  Future<void> checkSelectCategory(context, countCategories) async {

    // await SharedPref.getSharedPref(SharedPref.CATEGORY_LENGTH).then((countCategories) => {
      if(countCategories == 0) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (context) =>
                LandingChooseCategory()
            )
        );
      } else {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (context) =>
                BottomNavigation()
            )
        );
      }
    // });
  }

  Future changePasswordPro(context, parameters) async {
    ApiResponse apiResponse = await authRepo.changePassword(parameters);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      AppConstants.printLog(apiResponse.response);

      var statusCode = apiResponse.response!.data['statusCode'].toString();
      var msg = apiResponse.response!.data['data'].toString();
      if(statusCode == '200') {
        AppConstants.showBottomMessage(context, msg, AppColors.black);
        notifyListeners();
        return true;
      } else {
        AppConstants.showBottomMessage(context, msg, AppColors.black);
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
      AppConstants.showBottomMessage(context, errorMessage, AppColors.red);
      notifyListeners();
      return false;
    }
  }

}
