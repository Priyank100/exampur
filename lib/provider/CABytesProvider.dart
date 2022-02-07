import 'dart:convert';

import 'package:exampur_mobile/Helper/api_checker.dart';

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
  Future<List<Data>?> getCaBytesList(BuildContext context,int pageNo) async {
    ApiResponse apiResponse = await caBytesRepo.caBytes(pageNo);
    if (apiResponse.response == null) {
      ApiChecker.checkApi(context, apiResponse);
    } else if (apiResponse.response!.statusCode == 200) {
      AppConstants.printLog(apiResponse.response);
      // _homeBannerList=List<HomeBannerModel>.from(json.decode(apiResponse.response!.data).map((x) => HomeBannerModel.fromJson(x)));
      _caBytesModel = CABytesModel.fromJson(json.decode(apiResponse.response.toString()));
      return _caBytesModel.data;

    } else {
      AppConstants.printLog("init address fail");
      ApiChecker.checkApi(context, apiResponse);
    }
    notifyListeners();
  }


}
