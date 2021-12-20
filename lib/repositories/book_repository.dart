import 'dart:async';
import 'package:exampur_mobile/models/book.dart';
import 'book_api_client.dart';

class BookRepository {
  final BookApiClient bookApiClient;

  BookRepository({required this.bookApiClient});

  Future<BookList> fetcher() async {
    return await bookApiClient.fetcher();
  }
}
