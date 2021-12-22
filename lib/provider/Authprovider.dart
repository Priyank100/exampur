import 'dart:convert';

import 'package:exampur_mobile/Helper/api_checker.dart';
import 'package:exampur_mobile/data/model/Userinfo.dart';
import 'package:exampur_mobile/data/model/loginmodel.dart';
import 'package:exampur_mobile/data/model/response/Base/api_response.dart';
import 'package:exampur_mobile/data/model/response/Base/error_response.dart';
import 'package:exampur_mobile/data/repository/Authrepo.dart';

import 'package:flutter/cupertino.dart';

class AuthProvider extends ChangeNotifier {
  final AuthRepo authRepo;

  AuthProvider({required this.authRepo});

  //List<UserInfo> _userList = [];
  UserInfo _userInfo=UserInfo();

  //List<UserInfo> get userList => _userList;
  UserInfo get userInfo => _userInfo;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  ///userinfo request
  Future<void> initUserList(BuildContext context) async {
    ApiResponse apiResponse = await authRepo.getUserList();
    if (apiResponse.response == null) {
      ApiChecker.checkApi(context, apiResponse);
    } else if (apiResponse.response!.statusCode == 200) {
      print(apiResponse.response);
     // Map map = apiResponse.response!.data;
      _userInfo=UserInfo.fromJson(jsonDecode(apiResponse.response!.data.toString()));
      print("init address fail");
      print(_userInfo.first_name);
      //_userList.add(UserInfo.fromJson(apiResponse.response!.data));
    } else {
      print("init address fail");
      ApiChecker.checkApi(context, apiResponse);
    }
    notifyListeners();
  }

  ///login
  Future login(LoginModel loginBody, Function callback) async {
    _isLoading = true;
    notifyListeners();
    ApiResponse apiResponse = await authRepo.login(loginBody);
    _isLoading = false;
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      print('anchal');
     // Map map = apiResponse.response!.data;
     // String token = map["token"];
     // authRepo.saveUserToken(token);
     // await authRepo.updateToken();
     // callback(true, token);
      notifyListeners();
    } else {
      String errorMessage;
      if (apiResponse.error is String) {
        print(apiResponse.error.toString());
        errorMessage = apiResponse.error.toString();
      } else {
        ErrorResponse errorResponse = apiResponse.error;
        print(errorResponse.errors![0].message);
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
