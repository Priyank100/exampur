import 'dart:convert';
import 'package:exampur_mobile/Localization/language_constrants.dart';
import 'package:exampur_mobile/SharePref/shared_pref.dart';
import 'package:exampur_mobile/data/model/course_timeline_live_stream_model.dart';
import 'package:exampur_mobile/data/model/my_course_list_model.dart';
import 'package:exampur_mobile/data/model/my_course_material_model.dart';
import 'package:exampur_mobile/data/model/my_course_notification_model.dart';
import 'package:exampur_mobile/data/model/my_course_subject_model.dart';
import 'package:exampur_mobile/data/model/my_course_timeline_model.dart';
import 'package:exampur_mobile/data/model/response/Base/api_response.dart';
import 'package:exampur_mobile/data/model/teacher_chapter_model.dart';
import 'package:exampur_mobile/data/repository/MyCourseRepo.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:exampur_mobile/utils/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:exampur_mobile/utils/lang_string.dart';

class MyCourseProvider extends ChangeNotifier {
  final MyCourseRepo myCourseRepo;
  MyCourseProvider({required this.myCourseRepo});

  MyCourseListModel _myCourseListModel = MyCourseListModel();
  MyCourseListModel get myCourseListModel => _myCourseListModel;

  MyCourseSubjectModel _myCourseSubjectModel = MyCourseSubjectModel();
  MyCourseSubjectModel get myCourseSubjectModel => _myCourseSubjectModel;

  MyCourseMaterialModel _myCourseMaterialModel = MyCourseMaterialModel();
  MyCourseMaterialModel get myCourseMaterialModel => _myCourseMaterialModel;


  MyCourseNotificationModel _myCourseNotificationModel =MyCourseNotificationModel();
  MyCourseNotificationModel get myCourseNotificationModel=> _myCourseNotificationModel;

  MyCourseTimelineModel _myCourseTimelineListModel = MyCourseTimelineModel();
  MyCourseTimelineModel get myCourseTimelineListModel => _myCourseTimelineListModel;


  CourseTimelineLiveStreamModel _myCourseTimelineliveStreamModel = CourseTimelineLiveStreamModel();
  CourseTimelineLiveStreamModel get myCourseTimelineliveStreamModel => _myCourseTimelineliveStreamModel;

  TeacherChapterModel _teacherchapterModel = TeacherChapterModel();
  TeacherChapterModel get teacherchapterModel => _teacherchapterModel;

  Future<List<CourseData>?> getMyCourseList(BuildContext context, String token) async {
    ApiResponse apiResponse = await myCourseRepo.myCourseData(token);

    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      var statusCode = apiResponse.response!.data['statusCode'].toString();
      if (statusCode == '200') {
        _myCourseListModel = MyCourseListModel.fromJson(
            json.decode(apiResponse.response.toString()));
        return _myCourseListModel.data ?? [];
      } else if(statusCode == '409') {
        SharedPref.clearSharedPref(SharedPref.TOKEN);
        SharedPref.clearSharedPref(SharedPref.USER_DATA);
        Navigator.of(context).pushNamedAndRemoveUntil('/landingPage', (Route<dynamic> route) => false);
      } else {
        String error = apiResponse.response!.data['data'].toString();
        AppConstants.showBottomMessage(context, error, AppColors.black);
      }
      notifyListeners();
    } else {
      AppConstants.showBottomMessage(
          context, getTranslated(context, LangString.serverError)!,
          AppColors.red);
      // Navigator.pushReplacement(
      //     context,
      //     MaterialPageRoute(
      //         builder: (context) => ErrorScreen()
      //     )
      // );
      notifyListeners();
    }
  }

  Future<List<SubjectData>?> getSubjectList(BuildContext context, String courseId,) async {
    ApiResponse apiResponse = await myCourseRepo.subjectData(courseId, );

    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      var statusCode = apiResponse.response!.data['statusCode'].toString();
      if (statusCode == '200') {
        _myCourseSubjectModel = MyCourseSubjectModel.fromJson(json.decode(apiResponse.response.toString()));
        return _myCourseSubjectModel.data??[];
      } else if(statusCode == '409') {
        SharedPref.clearSharedPref(SharedPref.TOKEN);
        SharedPref.clearSharedPref(SharedPref.USER_DATA);
        Navigator.of(context).pushNamedAndRemoveUntil('/landingPage', (Route<dynamic> route) => false);
      } else {
        String error = apiResponse.response!.data['data'].toString();
        AppConstants.showBottomMessage(context, error, AppColors.black);
      }
      notifyListeners();
    } else {
      AppConstants.showBottomMessage(
          context, getTranslated(context, LangString.serverError)!,
          AppColors.red);
      // Navigator.pushReplacement(
      //     context,
      //     MaterialPageRoute(
      //         builder: (context) => ErrorScreen()
      //     )
      // );
      notifyListeners();
    }
  }

  Future<List<MaterialData>?> getMaterialList(BuildContext context, String subjectId, String courseId,String chapterName) async {
    ApiResponse apiResponse = await myCourseRepo.materialData(subjectId, courseId,chapterName);

    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      var statusCode = apiResponse.response!.data['statusCode'].toString();
      if (statusCode == '200') {
        _myCourseMaterialModel = MyCourseMaterialModel.fromJson(json.decode(apiResponse.response.toString()));
        return _myCourseMaterialModel.data??[];
      } else if(statusCode == '409') {
        SharedPref.clearSharedPref(SharedPref.TOKEN);
        SharedPref.clearSharedPref(SharedPref.USER_DATA);
        Navigator.of(context).pushNamedAndRemoveUntil('/landingPage', (Route<dynamic> route) => false);
      } else {
        String error = apiResponse.response!.data['data'].toString();
        AppConstants.showBottomMessage(context, error, AppColors.black);
      }
      notifyListeners();
    } else {
      AppConstants.showBottomMessage(
          context, getTranslated(context, LangString.serverError)!,
          AppColors.red);
      // Navigator.pushReplacement(
      //     context,
      //     MaterialPageRoute(
      //         builder: (context) => ErrorScreen()
      //     )
      // );
      notifyListeners();
    }
  }



  Future<List<String>?> getChapterList(BuildContext context, String subjectId, String courseId,) async {
    ApiResponse apiResponse = await myCourseRepo.chapterData(subjectId, courseId, );

    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      var statusCode = apiResponse.response!.data['statusCode'].toString();
      if (statusCode == '200') {
        _teacherchapterModel = TeacherChapterModel.fromJson(json.decode(apiResponse.response.toString()));
        return _teacherchapterModel.data??[];
      } else if(statusCode == '409') {
        SharedPref.clearSharedPref(SharedPref.TOKEN);
        SharedPref.clearSharedPref(SharedPref.USER_DATA);
        Navigator.of(context).pushNamedAndRemoveUntil('/landingPage', (Route<dynamic> route) => false);
      } else {
        String error = apiResponse.response!.data['data'].toString();
        AppConstants.showBottomMessage(context, error, AppColors.black);
      }
      notifyListeners();
    } else {
      AppConstants.showBottomMessage(
          context, getTranslated(context, LangString.serverError)!,
          AppColors.red);
      // Navigator.pushReplacement(
      //     context,
      //     MaterialPageRoute(
      //         builder: (context) => ErrorScreen()
      //     )
      // );
      notifyListeners();
    }
  }


  Future<List<TimelineData>?> getMyCourseTimeLineList(BuildContext context, String courseId, String activeBtn) async {
    ApiResponse apiResponse = await myCourseRepo.myCourseTimelineData(courseId,activeBtn);

    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      var statusCode = apiResponse.response!.data['statusCode'].toString();
      if (statusCode == '200') {
        _myCourseTimelineListModel = MyCourseTimelineModel.fromJson(json.decode(apiResponse.response.toString()));
        return _myCourseTimelineListModel.data;
      } else if(statusCode == '409') {
        SharedPref.clearSharedPref(SharedPref.TOKEN);
        SharedPref.clearSharedPref(SharedPref.USER_DATA);
        Navigator.of(context).pushNamedAndRemoveUntil('/landingPage', (Route<dynamic> route) => false);
      } else {
        String error = apiResponse.response!.data['data'].toString();
        AppConstants.showBottomMessage(context, error, AppColors.black);
      }
      notifyListeners();
    } else {
      AppConstants.showBottomMessage(
          context, getTranslated(context, LangString.serverError)!,
          AppColors.red);
      notifyListeners();
    }
  }

  Future<Data?> getMyCourseTimeLineLiveStream(BuildContext context, String courseId ,String token) async {
    ApiResponse apiResponse = await myCourseRepo.myCourseTimelineshareStreamToMobile(courseId, token);

    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      var statusCode = apiResponse.response!.data['statusCode'].toString();
      if (statusCode == '200') {
        _myCourseTimelineliveStreamModel = CourseTimelineLiveStreamModel.fromJson(json.decode(apiResponse.response.toString()));
        return _myCourseTimelineliveStreamModel.data;
      } else if(statusCode == '409') {
        SharedPref.clearSharedPref(SharedPref.TOKEN);
        SharedPref.clearSharedPref(SharedPref.USER_DATA);
        Navigator.of(context).pushNamedAndRemoveUntil('/landingPage', (Route<dynamic> route) => false);
      } else {
        String error = apiResponse.response!.data['data'].toString();
        AppConstants.showBottomMessage(context, error, AppColors.black);
      }
      notifyListeners();
    } else {
      AppConstants.showBottomMessage(
          context, getTranslated(context, LangString.serverError)!,
          AppColors.red);
      // Navigator.pushReplacement(
      //     context,
      //     MaterialPageRoute(
      //         builder: (context) => ErrorScreen()
      //     )
      // );
      notifyListeners();
    }
  }

  Future<List<NotificationData>?> getMyCourseNotificationList(BuildContext context, String courseId ) async {
    ApiResponse apiResponse = await myCourseRepo.myCourseNotificationData(courseId);

    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      var statusCode = apiResponse.response!.data['statusCode'].toString();
      if (statusCode == '200') {
        _myCourseNotificationModel = MyCourseNotificationModel.fromJson(json.decode(apiResponse.response.toString()));
        return _myCourseNotificationModel.data;
      } else if(statusCode == '409') {
        SharedPref.clearSharedPref(SharedPref.TOKEN);
        SharedPref.clearSharedPref(SharedPref.USER_DATA);
        Navigator.of(context).pushNamedAndRemoveUntil('/landingPage', (Route<dynamic> route) => false);
      } else {
        String error = apiResponse.response!.data['data'].toString();
        AppConstants.showBottomMessage(context, error, AppColors.black);
      }
      notifyListeners();
    } else {
      AppConstants.showBottomMessage(
          context, getTranslated(context, LangString.serverError)!,
          AppColors.red);
      // Navigator.pushReplacement(
      //     context,
      //     MaterialPageRoute(
      //         builder: (context) => ErrorScreen()
      //     )
      // );
      notifyListeners();
    }
  }
}