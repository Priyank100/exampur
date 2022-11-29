import 'dart:convert';
import 'package:exampur_mobile/Localization/language_constrants.dart';
import 'package:exampur_mobile/SharePref/shared_pref.dart';
import 'package:exampur_mobile/data/model/course_timeline_live_stream_model.dart';
import 'package:exampur_mobile/data/model/my_course_material_model.dart';
import 'package:exampur_mobile/data/model/my_course_subject_model.dart';
import 'package:exampur_mobile/data/model/my_course_timeline_model.dart';
import 'package:exampur_mobile/data/model/response/Base/api_response.dart';
import 'package:exampur_mobile/data/model/sampling_features_model.dart';
import 'package:exampur_mobile/data/model/teacher_chapter_model.dart';
import 'package:exampur_mobile/data/repository/new_my_course_repo.dart';
import 'package:exampur_mobile/utils/app_colors.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:exampur_mobile/utils/lang_string.dart';
import 'package:flutter/material.dart';

class NewMyCourseProvider extends ChangeNotifier {
  final NewMyCourseRepo newMyCourseRepo;
  NewMyCourseProvider({required this.newMyCourseRepo});

  SamplingFeaturesModel _samplingFeaturesModel = SamplingFeaturesModel();
  SamplingFeaturesModel get samplingFeaturesModel => _samplingFeaturesModel;

  MyCourseTimelineModel _myCourseTimelineListModel = MyCourseTimelineModel();
  MyCourseTimelineModel get myCourseTimelineListModel => _myCourseTimelineListModel;

  CourseTimelineLiveStreamModel _myCourseTimelineliveStreamModel = CourseTimelineLiveStreamModel();
  CourseTimelineLiveStreamModel get myCourseTimelineliveStreamModel => _myCourseTimelineliveStreamModel;

  MyCourseSubjectModel _myCourseSubjectModel = MyCourseSubjectModel();
  MyCourseSubjectModel get myCourseSubjectModel => _myCourseSubjectModel;

  TeacherChapterModel _teacherchapterModel = TeacherChapterModel();
  TeacherChapterModel get teacherchapterModel => _teacherchapterModel;

  MyCourseMaterialModel _myCourseMaterialModel = MyCourseMaterialModel();
  MyCourseMaterialModel get myCourseMaterialModel => _myCourseMaterialModel;

  Future<List<String>?> getSamplingFeaturesList(BuildContext context, String courseId) async {
    ApiResponse apiResponse = await newMyCourseRepo.samplingFeatures(courseId);

    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      var statusCode = apiResponse.response!.data['statusCode'].toString();
      if (statusCode == '200') {
        _samplingFeaturesModel = SamplingFeaturesModel.fromJson(json.decode(apiResponse.response.toString()));
        return _samplingFeaturesModel.data!.features;
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

  Future<List<TimelineData>?> getMyCourseTimeLineList(BuildContext context, String courseId, String activeBtn) async {
    ApiResponse apiResponse = await newMyCourseRepo.myCourseTimelineRepo(courseId,activeBtn);

    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      var statusCode = apiResponse.response!.data['statusCode'].toString();
      if (statusCode == '200') {
        _myCourseTimelineListModel = MyCourseTimelineModel.fromJson(json.decode(apiResponse.response.toString()));
        return _myCourseTimelineListModel.data;
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
    ApiResponse apiResponse = await newMyCourseRepo.myCourseTimelineStreamRepo(courseId, token);

    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      var statusCode = apiResponse.response!.data['statusCode'].toString();
      if (statusCode == '200') {
        _myCourseTimelineliveStreamModel = CourseTimelineLiveStreamModel.fromJson(json.decode(apiResponse.response.toString()));
        return _myCourseTimelineliveStreamModel.data;
      } else {
        String error = apiResponse.response!.data['data'].toString();
        AppConstants.showBottomMessage(context, error, AppColors.black);
      }
      notifyListeners();
    } else {
      AppConstants.showBottomMessage(context, getTranslated(context, LangString.serverError)!, AppColors.red);
      notifyListeners();
    }
  }

  Future<List<SubjectData>?> getSubjectList(BuildContext context, String courseId) async {
    ApiResponse apiResponse = await newMyCourseRepo.subjectListRepo(courseId);

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
      AppConstants.showBottomMessage(context, getTranslated(context, LangString.serverError)!, AppColors.red);
      notifyListeners();
    }
  }

  Future<List<String>?> getChapterList(BuildContext context, String subjectId, String courseId,) async {
    ApiResponse apiResponse = await newMyCourseRepo.chapterListRepo(subjectId, courseId, );

    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      var statusCode = apiResponse.response!.data['statusCode'].toString();
      if (statusCode == '200') {
        _teacherchapterModel = TeacherChapterModel.fromJson(json.decode(apiResponse.response.toString()));
        return _teacherchapterModel.data??[];
      } else {
        String error = apiResponse.response!.data['data'].toString();
        AppConstants.showBottomMessage(context, error, AppColors.black);
      }
      notifyListeners();
    } else {
      AppConstants.showBottomMessage(context, getTranslated(context, LangString.serverError)!, AppColors.red);
      notifyListeners();
    }
  }

  Future<List<MaterialData>?> getTopicList(BuildContext context, String subjectId, String courseId,String chapterName) async {
    ApiResponse apiResponse = await newMyCourseRepo.topicListRepo(subjectId, courseId,chapterName);

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
      AppConstants.showBottomMessage(context, getTranslated(context, LangString.serverError)!, AppColors.red);
      notifyListeners();
    }
  }

}