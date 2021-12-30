import 'dart:convert';

import 'package:exampur_mobile/Helper/api_checker.dart';
import 'package:exampur_mobile/data/model/CoursesModel.dart';
import 'package:exampur_mobile/data/model/Userinfo.dart';
import 'package:exampur_mobile/data/model/loginmodel.dart';
import 'package:exampur_mobile/data/model/response/Base/api_response.dart';
import 'package:exampur_mobile/data/model/response/Base/error_response.dart';
import 'package:exampur_mobile/data/model/response/HomeBannerModel.dart';
import 'package:exampur_mobile/data/repository/Authrepo.dart';
import 'package:exampur_mobile/data/repository/HomeBanner_repo.dart';
import 'package:exampur_mobile/data/repository/courserepo.dart';
import 'package:exampur_mobile/utils/app_constants.dart';

import 'package:flutter/cupertino.dart';

class CoursesProvider extends ChangeNotifier {
  final CoursesRepo  courseRepo;

 CoursesProvider({required this.courseRepo});

  // List<CoursesModel> _coursesList = [];
  // List<CoursesModel> get coursesModel => _coursesList;

  CoursesModel _coursesModel = CoursesModel();
  CoursesModel get coursesModel => _coursesModel;

  Future<void> getCoursesList(BuildContext context) async {
    ApiResponse apiResponse = await courseRepo.coursesRepo();
    if (apiResponse.response == null) {
      ApiChecker.checkApi(context, apiResponse);
    } else if (apiResponse.response!.statusCode == 200) {
      AppConstants.printLog(apiResponse.response);
      //  Map map = apiResponse.response!.data;
      // //_homeBannerList=HomeBannerModel.fromJson(jsonDecode(apiResponse.response!.data.toString()));
      // AppConstants.printLog("init address fail");
      // //AppConstants.printLog(_homeBannerList);
      //
      // _coursesList=List<CoursesModel>.from(json.decode(apiResponse.response!.data).map((x) => CoursesModel.fromJson(x)));
      _coursesModel = CoursesModel.fromJson(json.decode(apiResponse.response.toString()));
      // AppConstants.printLog("Length> ${_homeBannerList.length}");
      //for(var item in _homeBannerList)



    } else {
      AppConstants.printLog("init address fail");
      ApiChecker.checkApi(context, apiResponse);
    }
    notifyListeners();
  }


}
