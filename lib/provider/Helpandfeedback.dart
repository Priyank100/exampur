import 'package:exampur_mobile/data/model/helpandfeedback.dart';
import 'package:exampur_mobile/data/model/response/Base/api_response.dart';
import 'package:exampur_mobile/data/model/response/Base/error_response.dart';
import 'package:exampur_mobile/data/repository/HelpandFeedback.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:flutter/material.dart';

class HelpandFeedbackprovider extends ChangeNotifier {
  final HelpandFeedbackRepo helpandFeedbackRepo;

  HelpandFeedbackprovider ({required this.helpandFeedbackRepo});


  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future helpandfeedback(HelpandFeedbackModel helpandFeedbackModel) async {
    _isLoading = true;
    notifyListeners();
    ApiResponse apiResponse = await helpandFeedbackRepo.helpandfeedback(helpandFeedbackModel);
    _isLoading = false;
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      AppConstants.printLog(apiResponse.response);

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

      notifyListeners();
    }
  }
}