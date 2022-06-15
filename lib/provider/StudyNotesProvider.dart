import 'dart:convert';

import 'package:exampur_mobile/Localization/language_constrants.dart';
import 'package:exampur_mobile/data/model/study_notes_chape_model.dart';
import 'package:exampur_mobile/data/model/study_notes_description_model.dart';
import 'package:exampur_mobile/data/model/study_notes_model.dart';
import 'package:exampur_mobile/data/model/response/Base/api_response.dart';
import 'package:exampur_mobile/data/model/study_notes_subject_model.dart';
import 'package:exampur_mobile/utils/api.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:exampur_mobile/utils/error_screen.dart';
import 'package:flutter/material.dart';
import 'package:exampur_mobile/data/repository/StudyNotesRepo.dart';

class StudyNotesProvider extends ChangeNotifier {
  final StudyNotesRepo studyNotesRepo;

  StudyNotesProvider({required this.studyNotesRepo});

  StudyNotesModel _studyNotesModel = StudyNotesModel();
  StudyNotesModel get studyNotesModel => _studyNotesModel;

  StudyNotesSubjectModel _studyNotesSubjectModel = StudyNotesSubjectModel();
  StudyNotesSubjectModel get studyNotesSubjectModel => _studyNotesSubjectModel;

  StudyNotesChaperModel _studyNotesChapterModel = StudyNotesChaperModel();
  StudyNotesChaperModel get studyNotesChapterModel => _studyNotesChapterModel;

  StudyNotesDescriptionModel _studyNotesChapterDescriptionModel = StudyNotesDescriptionModel();
  StudyNotesDescriptionModel get studyNotesChapterDescriptionModel => _studyNotesChapterDescriptionModel;

  Future<List<StudyNotesModel>?> getStudyNotesList(BuildContext context,String url) async {
    ApiResponse apiResponse = await studyNotesRepo.studyNotes(url);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      List<StudyNotesModel> myList = List<StudyNotesModel>.from(apiResponse.response!.data.map((x) => StudyNotesModel.fromJson(x)));
      return myList;

    } else {
      AppConstants.showBottomMessage(context, getTranslated(context, StringConstant.serverError), AppColors.red);
      AppConstants.goAndReplace(context, ErrorScreen());
    }
    notifyListeners();
  }

  Future<StudyNotesSubjectModel?> getStudyNotesSubjectList(BuildContext context,String courseId) async {
    ApiResponse apiResponse = await studyNotesRepo.studyNotesSubject(API.studyNotesSubjectUrl,courseId);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      _studyNotesSubjectModel = StudyNotesSubjectModel.fromJson(json.decode(apiResponse.response.toString()));
      return _studyNotesSubjectModel;
    } else {
      AppConstants.showBottomMessage(context, getTranslated(context, StringConstant.serverError), AppColors.red);
      AppConstants.goAndReplace(context, ErrorScreen());
    }
    notifyListeners();
  }
  Future<StudyNotesChaperModel?> getStudyNotesChapterList(BuildContext context,String subjectId) async {
    ApiResponse apiResponse = await studyNotesRepo.studyNotesSubject(API.studyNotesChapterUrl,subjectId);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      _studyNotesChapterModel = StudyNotesChaperModel.fromJson(json.decode(apiResponse.response.toString()));
      return _studyNotesChapterModel;
    } else {
      AppConstants.showBottomMessage(context, getTranslated(context, StringConstant.serverError), AppColors.red);
      AppConstants.goAndReplace(context, ErrorScreen());
    }
    notifyListeners();
  }
Future<StudyNotesDescriptionModel?> getStudyNotesChapterDescriptionList(BuildContext context,String contentId) async {
    ApiResponse apiResponse = await studyNotesRepo.studyNotesSubject(API.studyNotesChapterDescriptionUrl,contentId);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      _studyNotesChapterDescriptionModel = StudyNotesDescriptionModel.fromJson(json.decode(apiResponse.response.toString()));
      return _studyNotesChapterDescriptionModel;
    } else {
      AppConstants.showBottomMessage(context, getTranslated(context, StringConstant.serverError), AppColors.red);
      AppConstants.goAndReplace(context, ErrorScreen());
    }
    notifyListeners();
  }

}