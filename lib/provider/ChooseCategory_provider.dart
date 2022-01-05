
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

  // List<String> _category = [];
  // List<String> get category=> _category;

  CategoriesModel _categoryModel = CategoriesModel();
  CategoriesModel get categoryModel =>_categoryModel;

  Future<List<Category>?> getchooseCategoryList(BuildContext context) async {
    ApiResponse apiResponse = await chooseCategoryRepo.chooseCategory();
    if (apiResponse.response == null) {
      ApiChecker.checkApi(context, apiResponse);
    } else if (apiResponse.response!.statusCode == 200) {
      AppConstants.printLog(apiResponse.response!.data);

_categoryModel = CategoriesModel.fromJson(json.decode(apiResponse.response.toString()));
return _categoryModel.categories;


    } else {
      AppConstants.printLog("init address fail");
      ApiChecker.checkApi(context, apiResponse);
    }
    notifyListeners();
    throw '';
  }


}