import 'dart:convert';
import 'package:exampur_mobile/Helper/api_checker.dart';
import 'package:exampur_mobile/data/model/OfflineBatchesModel.dart';
import 'package:exampur_mobile/data/model/offline_batches_model.dart';
import 'package:exampur_mobile/data/model/response/Base/api_response.dart';
import 'package:exampur_mobile/data/repository/OfflineBatches_repo.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:flutter/cupertino.dart';

class OfflinebatchesProvider extends ChangeNotifier {
  final OfflineBatchesRepo offlinebatchesRepo;

  OfflinebatchesProvider({required this.offlinebatchesRepo});



  OfflineBatchModel _offlineBatchesModel = OfflineBatchModel();
  OfflineBatchModel get offlineBatchesModel => _offlineBatchesModel;

  Future<List<Data>?> getOne2OneList(BuildContext context) async {
    ApiResponse apiResponse = await offlinebatchesRepo.offlineBatchRepo();
    if (apiResponse.response == null) {
      ApiChecker.checkApi(context, apiResponse);
    } else if (apiResponse.response!.statusCode == 200) {
      AppConstants.printLog(apiResponse.response!.data);


      AppConstants.printLog(apiResponse.response);
      _offlineBatchesModel =OfflineBatchModel.fromJson(json.decode(apiResponse.response.toString()));
      return _offlineBatchesModel.data;



    } else {
      AppConstants.printLog("init address fail");
      ApiChecker.checkApi(context, apiResponse);
    }
    notifyListeners();
  }


}
