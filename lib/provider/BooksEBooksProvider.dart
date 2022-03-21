import 'dart:convert';

import 'package:exampur_mobile/Helper/api_checker.dart';
import 'package:exampur_mobile/Localization/language_constrants.dart';
import 'package:exampur_mobile/data/model/e_book_model.dart';
import 'package:exampur_mobile/data/model/response/Base/api_response.dart';
import 'package:exampur_mobile/data/repository/Books_EBooks_repo.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:exampur_mobile/utils/error_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BooksEBooksProvider extends ChangeNotifier {
  final BooksEBooksRepo  booksEbooksRepo;

  BooksEBooksProvider({required this.booksEbooksRepo});

  // BooksModel _booksModel = BooksModel();
  // BooksModel get booksModel => _booksModel;

  EBookModel _ebooksModel = EBookModel();
  EBookModel get ebooksModel => _ebooksModel;


  Future<List<BookEbook>?> getBooksList(BuildContext context,int pageNo) async {
    ApiResponse apiResponse = await booksEbooksRepo.books(pageNo);
    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      var statusCode = apiResponse.response!.data['statusCode'].toString();
      if (statusCode == '200') {
        _ebooksModel = EBookModel.fromJson(
            json.decode(apiResponse.response.toString()));
        return _ebooksModel.data;
      } else {
        String error = apiResponse.response!.data['data'].toString();
        AppConstants.showBottomMessage(context, error, AppColors.black);
      }
      notifyListeners();
    } else {
      AppConstants.showBottomMessage(
          context, getTranslated(context, StringConstant.serverError)!,
          AppColors.red);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => ErrorScreen()
          )
      );
      notifyListeners();
    }
  }


  Future<List<BookEbook>?> getE_booksList(BuildContext context,int pageNo) async {
    ApiResponse apiResponse = await booksEbooksRepo.eBooks(pageNo);
    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      var statusCode = apiResponse.response!.data['statusCode'].toString();
      if (statusCode == '200') {
        _ebooksModel = EBookModel.fromJson(
            json.decode(apiResponse.response.toString()));
        return _ebooksModel.data;
      } else {
        String error = apiResponse.response!.data['data'].toString();
        AppConstants.showBottomMessage(context, error, AppColors.black);
      }
      notifyListeners();
    } else {
      AppConstants.showBottomMessage(
          context, getTranslated(context, StringConstant.serverError)!,
          AppColors.red);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => ErrorScreen()
          )
      );
      notifyListeners();
    }
  }
}