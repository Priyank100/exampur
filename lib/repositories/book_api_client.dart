import 'dart:convert';
import 'package:exampur_mobile/logic/globals.dart';
import 'package:exampur_mobile/logic/jwt_token.dart';
import 'package:exampur_mobile/models/book.dart';
import 'package:http/http.dart' as http;

import '../main.dart';

class BookApiClient {
  BookApiClient();

  Future<BookList> fetcher() async {
    BookList _localList = new BookList(bookList: []);
    String url = "${Globals.baseUrl}/book";
    final response = await http.get(
      Uri.parse(url),
      headers: <String, String>{'authorization': jwt.jwtToken},
    );
    if (response.statusCode == 200) {
      print(response.body);
    } else {
      print('got no response ' + response.body);
      throw Exception('Sorry fetching imp book failed');
    }
    return _localList;
  }
}
