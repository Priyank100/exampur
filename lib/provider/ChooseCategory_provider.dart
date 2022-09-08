
import 'dart:convert';

import 'package:exampur_mobile/Helper/api_checker.dart';
import 'package:exampur_mobile/data/model/ChooseCategoryModel.dart';
import 'package:exampur_mobile/data/model/GetcategoruModel.dart';
import 'package:exampur_mobile/data/model/response/Base/api_response.dart';
import 'package:exampur_mobile/utils/app_colors.dart';
import 'package:exampur_mobile/utils/app_constants.dart';

import 'package:flutter/cupertino.dart';
import 'package:exampur_mobile/data/repository/ChooseCategory_repo.dart';

class ChooseCategoryProvider extends ChangeNotifier {
  final ChooseCategoryRepo chooseCategoryRepo;

  ChooseCategoryProvider({required this.chooseCategoryRepo});


  ChooseCategory _categoryModel = ChooseCategory();
  ChooseCategory get categoryModel =>_categoryModel;

  GetCategoriesModel _getCategoriesModel =GetCategoriesModel();
  GetCategoriesModel get getCategoriesModel => _getCategoriesModel;

  Future<List<Data>?> getAllCategoryList(BuildContext context) async {
    ApiResponse apiResponse = await chooseCategoryRepo.allCategory();

    if(apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      AppConstants.printLog(apiResponse.response!.data);
      var statusCode = apiResponse.response!.data['statusCode'].toString();
      if(statusCode == '200') {
        _categoryModel = ChooseCategory.fromJson(json.decode(apiResponse.response.toString()));
        List<Data> categoryList = [];
        for(int i=0; i<_categoryModel.data!.length; i++) {
          if(_categoryModel.data![i].name.toString().toLowerCase() != 'all exams') {
            categoryList.add(_categoryModel.data![i]);
          }
        }
        return categoryList;
        // return _categoryModel.data;
      } else {
        AppConstants.showBottomMessage(context, apiResponse.response!.data['data'].toString(), AppColors.black);
      }

    } else {
      ApiChecker.checkApi(context, apiResponse);
    }
    notifyListeners();
  }

  Future<List<String>?> getSelectchooseCategoryList(BuildContext context, String token) async {
    ApiResponse apiResponse = await chooseCategoryRepo.selectCategory(token);

    if(apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      AppConstants.printLog(apiResponse.response!.data);
      var statusCode = apiResponse.response!.data['statusCode'].toString();
      if(statusCode == '200') {
        _getCategoriesModel = GetCategoriesModel.fromJson(json.decode(apiResponse.response.toString()));
        return _getCategoriesModel.data;
      } else {
        AppConstants.showBottomMessage(context, apiResponse.response!.data['data'].toString(), AppColors.black);
      }

    } else {
      ApiChecker.checkApi(context, apiResponse);
    }
    notifyListeners();
  }

}