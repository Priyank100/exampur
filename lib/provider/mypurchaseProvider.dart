import 'dart:convert';
import 'package:exampur_mobile/Helper/api_checker.dart';
import 'package:exampur_mobile/Localization/language_constrants.dart';
import 'package:exampur_mobile/data/model/job_alert_list_model.dart';
import 'package:exampur_mobile/data/model/job_alert_tab_model.dart';
import 'package:exampur_mobile/data/model/job_alerts_detail_model.dart';
import 'package:exampur_mobile/utils/lang_string.dart';
import 'package:exampur_mobile/data/model/my_purchase_model.dart';
import 'package:exampur_mobile/data/model/mypurchase_innvoice.dart';
import 'package:exampur_mobile/data/model/response/Base/api_response.dart';
import 'package:exampur_mobile/data/repository/JobAlertsRepo.dart';
import 'package:exampur_mobile/data/repository/MyPurchaseRepo.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:exampur_mobile/utils/app_colors.dart';
import 'package:exampur_mobile/utils/error_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyPurchaseProvider extends ChangeNotifier {
  final MyPurchaseRepo myPurchaseRepo;
  MyPurchaseProvider({required this.myPurchaseRepo});



  MyPurchaseModel _my_purchaseModel = MyPurchaseModel();
  MyPurchaseModel get my_purchaseModel => _my_purchaseModel;


  MypurchaseInnvoice _mypurchaseInnvoiceModel = MypurchaseInnvoice();
  MypurchaseInnvoice get mypurchaseInnvoiceModel => _mypurchaseInnvoiceModel;


  Future<List<Data>?> getMyPurchaseList(BuildContext context, String token) async {
    ApiResponse apiResponse = await myPurchaseRepo.mypurchase(token);

    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      var statusCode = apiResponse.response!.data['statusCode'].toString();
      if (statusCode == '200') {
        _my_purchaseModel = MyPurchaseModel.fromJson(
            json.decode(apiResponse.response.toString()));
        return _my_purchaseModel.data;
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


  Future<InvoiceData?> getMyInvoice(BuildContext context,String token, String id,String type) async {
    ApiResponse apiResponse = await myPurchaseRepo.myinvoice(token, id, type);

    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      var statusCode = apiResponse.response!.data['statusCode'].toString();
      if (statusCode == '200') {
        _mypurchaseInnvoiceModel = MypurchaseInnvoice.fromJson(
            json.decode(apiResponse.response.toString()));
        return _mypurchaseInnvoiceModel.data;
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