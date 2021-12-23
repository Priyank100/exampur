import 'dart:convert';

import 'package:exampur_mobile/Helper/api_checker.dart';
import 'package:exampur_mobile/SharePref/shared_pref.dart';
import 'package:exampur_mobile/data/model/UserInformationModel.dart';
import 'package:exampur_mobile/data/model/Userinfo.dart';
import 'package:exampur_mobile/data/model/loginmodel.dart';
import 'package:exampur_mobile/data/model/response/Base/api_response.dart';
import 'package:exampur_mobile/data/model/response/Base/error_response.dart';
import 'package:exampur_mobile/data/repository/Authrepo.dart';
import 'package:exampur_mobile/utils/app_constants.dart';

import 'package:flutter/cupertino.dart';

class AuthProvider extends ChangeNotifier {
  final AuthRepo authRepo;

  AuthProvider({required this.authRepo});

  //List<UserInfo> _userList = [];
  //List<UserInfo> get userList => _userList;

  UserInfo _userInfo=UserInfo();
  UserInfo get userInfo => _userInfo;

  UserInformationModel _informationModel=UserInformationModel();
  UserInformationModel get informationModel =>_informationModel;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  ///userinfo request
  Future<void> initUserList(BuildContext context) async {
    ApiResponse apiResponse = await authRepo.getUserList();
    if (apiResponse.response == null) {
      ApiChecker.checkApi(context, apiResponse);
    } else if (apiResponse.response!.statusCode == 200) {
      AppConstants.printLog(apiResponse.response);
     // Map map = apiResponse.response!.data;
      _userInfo=UserInfo.fromJson(jsonDecode(apiResponse.response!.data.toString()));
      AppConstants.printLog("init address fail");
      AppConstants.printLog(_userInfo.first_name);
      //_userList.add(UserInfo.fromJson(apiResponse.response!.data));
    } else {
      AppConstants.printLog("init address fail");
      ApiChecker.checkApi(context, apiResponse);
    }
    notifyListeners();
  }

  ///login
  Future login(LoginModel loginBody, Function callback) async {
    _isLoading = true;
    ApiResponse apiResponse = await authRepo.login(loginBody);
    _isLoading = false;
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      AppConstants.printLog(apiResponse.response);
      // Map map = apiResponse.response!.data;
     // String token = map["token"];
     // authRepo.saveUserToken(token);
     // await authRepo.updateToken();
     // callback(true, token);

      // AppConstants.printLog(apiResponse.response!.data['statusCode']);

      _informationModel = UserInformationModel.fromJson(json.decode(apiResponse.response.toString()));

      var statusCode = apiResponse.response!.data['statusCode'].toString();
      if(statusCode == '200') {
        SharedPref.saveSharedPref(AppConstants.TOKEN, _informationModel.data!.authToken.toString());
        AppConstants.printLog('ToKEN2>> ${_informationModel.data!.authToken}');
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


  String getUserPhone() {
    return authRepo.getUserPhone() ;
  }



  String getUserPassword() {
    return authRepo.getUserPassword() ;
  }
}
