import 'dart:convert';
import 'package:exampur_mobile/Localization/language_constrants.dart';
import 'package:exampur_mobile/data/model/my_course_list_model.dart';
import 'package:exampur_mobile/data/model/my_course_material_model.dart';
import 'package:exampur_mobile/data/model/my_course_subject_model.dart';
import 'package:exampur_mobile/data/model/response/Base/api_response.dart';
import 'package:exampur_mobile/data/repository/MyCourseRepo.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:flutter/cupertino.dart';

class MyCourseProvider extends ChangeNotifier {
  final MyCourseRepo myCourseRepo;
  MyCourseProvider({required this.myCourseRepo});

  MyCourseListModel _myCourseListModel = MyCourseListModel();
  MyCourseListModel get myCourseListModel => _myCourseListModel;

  MyCourseSubjectModel _myCourseSubjectModel = MyCourseSubjectModel();
  MyCourseSubjectModel get myCourseSubjectModel => _myCourseSubjectModel;

  MyCourseMaterialModel _myCourseMaterialModel = MyCourseMaterialModel();
  MyCourseMaterialModel get myCourseMaterialModel => _myCourseMaterialModel;

  Future<List<CourseData>?> getMyCourseList(BuildContext context, String token) async {
    ApiResponse apiResponse = await myCourseRepo.myCourseData(token);

    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      var statusCode = apiResponse.response!.data['statusCode'].toString();
      if (statusCode == '200') {
        _myCourseListModel = MyCourseListModel.fromJson(json.decode(apiResponse.response.toString()));
        return _myCourseListModel.data??[];
      } else {
        String error = apiResponse.response!.data['data'].toString();
        AppConstants.showBottomMessage(context, error, AppColors.black);
      }
      notifyListeners();
    } else {
      AppConstants.showBottomMessage(
          context, getTranslated(context, StringConstant.serverError)!,
          AppColors.red);
      notifyListeners();
    }
  }

  Future<List<SubjectData>?> getSubjectList(BuildContext context, String courseId, String token) async {
    ApiResponse apiResponse = await myCourseRepo.subjectData(courseId, token);

    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      var statusCode = apiResponse.response!.data['statusCode'].toString();
      if (statusCode == '200') {
        _myCourseSubjectModel = MyCourseSubjectModel.fromJson(json.decode(apiResponse.response.toString()));
        return _myCourseSubjectModel.data??[];
      } else {
        String error = apiResponse.response!.data['data'].toString();
        AppConstants.showBottomMessage(context, error, AppColors.black);
      }
      notifyListeners();
    } else {
      AppConstants.showBottomMessage(
          context, getTranslated(context, StringConstant.serverError)!,
          AppColors.red);
      notifyListeners();
    }
  }

  Future<List<MaterialData>?> getMaterialList(BuildContext context, String courseId, String token) async {
    ApiResponse apiResponse = await myCourseRepo.materialData(courseId, token);

    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      var statusCode = apiResponse.response!.data['statusCode'].toString();
      if (statusCode == '200') {
        _myCourseMaterialModel = MyCourseMaterialModel.fromJson(json.decode(apiResponse.response.toString()));
        return _myCourseMaterialModel.data??[];
      } else {
        String error = apiResponse.response!.data['data'].toString();
        AppConstants.showBottomMessage(context, error, AppColors.black);
      }
      notifyListeners();
    } else {
      AppConstants.showBottomMessage(
          context, getTranslated(context, StringConstant.serverError)!,
          AppColors.red);
      notifyListeners();
    }
  }

}