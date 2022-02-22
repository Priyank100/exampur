import 'dart:convert';

import 'package:exampur_mobile/Helper/api_checker.dart';
import 'package:exampur_mobile/Localization/language_constrants.dart';

import 'package:exampur_mobile/data/model/c_a_bytes_model.dart';

import 'package:exampur_mobile/data/model/response/Base/api_response.dart';

import 'package:exampur_mobile/data/repository/CA_Bytes.dart';

import 'package:exampur_mobile/utils/app_constants.dart';

import 'package:flutter/cupertino.dart';

class CABytesProvider extends ChangeNotifier {
  final CaBytesRepo  caBytesRepo;

  CABytesProvider ({required this.caBytesRepo});


  CABytesModel _caBytesModel = CABytesModel();
  CABytesModel get caBytesModel => _caBytesModel;

  //homeBanner request
  Future<List<Data>?> getCaBytesList(BuildContext context, String encodeCat,int pageNo) async {
    ApiResponse apiResponse = await caBytesRepo.caBytes(encodeCat, pageNo);

    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      var statusCode = apiResponse.response!.data['statusCode'].toString();
      if (statusCode == '200') {
        _caBytesModel = CABytesModel.fromJson(
            json.decode(apiResponse.response.toString()));
        return _caBytesModel.data;
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
