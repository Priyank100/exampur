import 'package:exampur_mobile/Helper/api_checker.dart';
import 'package:exampur_mobile/data/model/Userinfo.dart';
import 'package:exampur_mobile/data/model/response/Base/api_response.dart';
import 'package:exampur_mobile/data/repository/user_repo.dart';
import 'package:flutter/cupertino.dart';

class AuthProvider extends ChangeNotifier {
  final AuthRepo? authRepo;
  AuthProvider({this.authRepo});

 late List<UserInfo> _userList;
  List< UserInfo> get userList =>_userList;



  ///userinfo request
  Future<void> initAddressList(BuildContext context) async {
    ApiResponse apiResponse = await authRepo!.getUserList();
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      _userList = [];
      apiResponse.response!.data.forEach((user) => _userList.add(UserInfo.fromJson(user)));
    } else {
      ApiChecker.checkApi(context, apiResponse);
    }
    notifyListeners();
  }
}