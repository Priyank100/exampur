import 'dart:convert';

import 'package:exampur_mobile/Helper/api_checker.dart';
import 'package:exampur_mobile/data/model/e_book_model.dart';
import 'package:exampur_mobile/data/model/response/Base/api_response.dart';
import 'package:exampur_mobile/data/repository/Books_EBooks_repo.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:flutter/cupertino.dart';

class BooksEBooksProvider extends ChangeNotifier {
  final BooksEBooksRepo  booksEbooksRepo;

  BooksEBooksProvider({required this.booksEbooksRepo});

  // BooksModel _booksModel = BooksModel();
  // BooksModel get booksModel => _booksModel;

  EBookModel _ebooksModel = EBookModel();
  EBookModel get ebooksModel => _ebooksModel;


  Future<List<BookEbook>?> getBooksList(BuildContext context,int pageNo) async {
    ApiResponse apiResponse = await booksEbooksRepo.books(pageNo);
    if (apiResponse.response == null) {
      ApiChecker.checkApi(context, apiResponse);
    } else if (apiResponse.response!.statusCode == 200) {
      AppConstants.printLog(apiResponse.response);
      _ebooksModel=  EBookModel.fromJson(json.decode(apiResponse.response.toString()));
      // return _booksModel.books;
      return _ebooksModel.data?? [];

    } else {
      AppConstants.printLog("init address fail");
      ApiChecker.checkApi(context, apiResponse);
    }
    notifyListeners();
  }


  Future<List<BookEbook>?> getE_booksList(BuildContext context,int pageNo) async {
    ApiResponse apiResponse = await booksEbooksRepo.eBooks(pageNo);
    if (apiResponse.response == null) {
      ApiChecker.checkApi(context, apiResponse);
    } else if (apiResponse.response!.statusCode == 200) {
      AppConstants.printLog(apiResponse.response);
      // _ebooksModel = EBooksModel.fromJson(json.decode(apiResponse.response.toString()));
      // return _ebooksModel.books;
      _ebooksModel = EBookModel.fromJson(json.decode(apiResponse.response.toString()));
      // return _ebooksModel.data;
      return _ebooksModel.data ?? [];

    } else {
      AppConstants.printLog("init address fail");
      ApiChecker.checkApi(context, apiResponse);
    }
    notifyListeners();
  }
}