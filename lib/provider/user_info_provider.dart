import 'package:exampur_mobile/Helper/api_checker.dart';
import 'package:exampur_mobile/data/model/Userinfo.dart';
import 'package:exampur_mobile/data/model/response/Base/api_response.dart';
import 'package:exampur_mobile/data/repository/user_repo.dart';
import 'package:flutter/cupertino.dart';

class AuthProvider extends ChangeNotifier {
  final AuthRepo authRepo;

  AuthProvider({required this.authRepo});

  //List<UserInfo> _userList = [];
  UserInfo _userInfo=UserInfo();

  //List<UserInfo> get userList => _userList;
  UserInfo get userInfo => _userInfo;

  ///userinfo request
  Future<void> initAddressList(BuildContext context) async {
    ApiResponse apiResponse = await authRepo.getUserList();
    if (apiResponse.response == null) {
      ApiChecker.checkApi(context, apiResponse);
    } else if (apiResponse.response!.statusCode == 200) {
      print(apiResponse.response);
      //Map map = apiResponse.response!.data;
      _userInfo=UserInfo(firstName: "mayakfnkf");
      //_userList.add(UserInfo.fromJson(apiResponse.response!.data));
    } else {
      print("init address fail");
      ApiChecker.checkApi(context, apiResponse);
    }
    notifyListeners();
  }
}
