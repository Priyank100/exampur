import 'dart:convert';

import 'package:exampur_mobile/Helper/api_checker.dart';
import 'package:exampur_mobile/data/model/CoursesModel.dart';
import 'package:exampur_mobile/data/model/Userinfo.dart';
import 'package:exampur_mobile/data/model/loginmodel.dart';
import 'package:exampur_mobile/data/model/response/Base/api_response.dart';
import 'package:exampur_mobile/data/model/response/Base/error_response.dart';
import 'package:exampur_mobile/data/model/response/E-booksModel.dart';
import 'package:exampur_mobile/data/model/response/HomeBannerModel.dart';
import 'package:exampur_mobile/data/repository/Authrepo.dart';
import 'package:exampur_mobile/data/repository/Books_repo.dart';
import 'package:exampur_mobile/data/repository/HomeBanner_repo.dart';
import 'package:exampur_mobile/data/repository/courserepo.dart';
import 'package:exampur_mobile/utils/app_constants.dart';

import 'package:flutter/cupertino.dart';

class BooksProvider extends ChangeNotifier {
  final BooksRepo  booksRepo;

  BooksProvider({required this.booksRepo});

  // List<EBooksModel>  _ebooksModel = [];
  // List<EBooksModel> get  ebooksModel =>  _ebooksModel;

  EBooksModel _ebooksModel = EBooksModel();
  EBooksModel get ebooksModel => _ebooksModel;

  Future<List<Book>?> getE_booksList(BuildContext context) async {
    ApiResponse apiResponse = await booksRepo.eBooksRepo();
    if (apiResponse.response == null) {
      ApiChecker.checkApi(context, apiResponse);
    } else if (apiResponse.response!.statusCode == 200) {
      AppConstants.printLog(apiResponse.response);
      _ebooksModel = EBooksModel.fromJson(json.decode(apiResponse.response.toString()));
      return _ebooksModel.books;



    } else {
      AppConstants.printLog("init address fail");
      ApiChecker.checkApi(context, apiResponse);
    }
    notifyListeners();
  }


}
