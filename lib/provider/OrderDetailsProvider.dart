import 'dart:convert';

import 'package:exampur_mobile/data/model/helpandfeedback.dart';
import 'package:exampur_mobile/data/model/order_details.dart';
import 'package:exampur_mobile/data/model/response/Base/api_response.dart';
import 'package:exampur_mobile/data/model/response/Base/error_response.dart';
import 'package:exampur_mobile/data/repository/CheckOutrepo.dart';
import 'package:exampur_mobile/data/repository/HelpandFeedback.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:flutter/material.dart';

class OrderDetailsprovider extends ChangeNotifier {
  final CheckOrderRepo checkOrderRepo;

  OrderDetailsprovider ({required this.checkOrderRepo});


  bool _isLoading = false;
  bool get isLoading => _isLoading;

  OrderDetailsModel _informationModel=OrderDetailsModel();
  OrderDetailsModel get informationModel =>_informationModel;

  Future orderdetails(OrderDetails orderdetails) async {
    _isLoading = true;
    notifyListeners();
    ApiResponse apiResponse = await checkOrderRepo.checkorderrepo(orderdetails);
    _isLoading = false;
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      AppConstants.printLog(apiResponse.response);
      var statusCode = apiResponse.response!.data['statusCode'].toString();

      String data = apiResponse.response!.data['data'].toString();
      AppConstants.printLog(data);
      String status = apiResponse.response!.data['data']['status'].toString();
      AppConstants.printLog(status);
      if(status == "Pending"){
        AppConstants.printLog('ok');
      }
      else{
        AppConstants.printLog('yes');
      }
      // if(statusCode == '200') {
      //   _informationModel = OrderDetailsModel.fromJson(json.decode(apiResponse.response.toString()));
      //   List<OrderDetailsModel> _userData = [];
      //   _userData.add(_informationModel);
      //
      //   return true;
      // } else {
      //   return false;
      // }
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