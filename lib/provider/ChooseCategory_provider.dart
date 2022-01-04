
import 'dart:convert';

import 'package:exampur_mobile/Helper/api_checker.dart';
import 'package:exampur_mobile/data/model/ChooseCategoryModel.dart';
import 'package:exampur_mobile/data/model/response/Base/api_response.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:exampur_mobile/data/repository/ChooseCategory_repo.dart';

class ChooseCategoryProvider extends ChangeNotifier {
  final ChooseCategoryRepo chooseCategoryRepo;

  ChooseCategoryProvider({required this.chooseCategoryRepo});

  List<String> _category = [];
  List<String> get category=> _category;

  // CategoriesModel _categoryModel = CategoriesModel();
  // CategoriesModel get categoryModel =>_categoryModel;

  Future<List<String>> getchooseCategoryList(BuildContext context) async {
    ApiResponse apiResponse = await chooseCategoryRepo.chooseCategoryRepo();
    if (apiResponse.response == null) {
      ApiChecker.checkApi(context, apiResponse);
    } else if (apiResponse.response!.statusCode == 200) {
      AppConstants.printLog(apiResponse.response!.data);
      //  Map map = apiResponse.response!.data;
      // //_homeBannerList=HomeBannerModel.fromJson(jsonDecode(apiResponse.response!.data.toString()));
      // AppConstants.printLog("init address fail");
      // //AppConstants.printLog(_homeBannerList);
      //
      //_categoryModel=List<CategoriesModel>.from(json.decode(apiResponse.response!.data).map((x) => CategoriesModel.fromJson(x)));
      //_one2oneModel = CategoriesModel.fromJson(json.decode(apiResponse.response!.data));
      _category.addAll(CategoriesModel.fromJson(apiResponse.response!.data).categories!.map((e) => e.name!));
      AppConstants.printLog( _category);

        return _category;

      // AppConstants.printLog("Length> ${_homeBannerList.length}");
      //for(var item in _homeBannerList)

      //_categoryModel =  CategoriesModel.fromJson(json.decode(apiResponse.response!.data));
     // AppConstants.printLog(_categoryModel);
    } else {
      AppConstants.printLog("init address fail");
      ApiChecker.checkApi(context, apiResponse);
    }
    notifyListeners();
    throw '';
  }


}