import 'package:exampur_mobile/data/model/books_model.dart';
import 'package:exampur_mobile/data/model/dummy_model.dart';
import 'package:exampur_mobile/data/model/e_book_model.dart';
import 'package:exampur_mobile/presentation/home/books/books_screen.dart';
import 'package:exampur_mobile/presentation/home/books/e_books_screen.dart';
import 'package:exampur_mobile/presentation/widgets/custom_tab_bar.dart';
import 'package:exampur_mobile/provider/BooksEBooksProvider.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BooksEbook extends StatefulWidget {
  @override
  BooksEbookState createState() => BooksEbookState();
}

class BooksEbookState extends State<BooksEbook> with SingleTickerProviderStateMixin   {
  late TabController _controller;
  List<Books> booksList = [];
  List<Data> eBooksList = [];
  bool isLoading = false;

  Future<List> getBooksList() async {
    isLoading = true;
    booksList = (await Provider.of<BooksEBooksProvider>(context, listen: false).getBooksList(context))!;
    isLoading = false;
    return booksList;
  }

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this);

    _controller.addListener(() async {
      switch(_controller.index) {
        case 0:
          getBooksList();
          break;
        case 1:
          isLoading = true;
          eBooksList = (await Provider.of<BooksEBooksProvider>(context, listen: false).getE_booksList(context))!;
          isLoading = false;
          break;
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getBooksList(),
        builder: (context, snapshot) {
            return Scaffold(
                body: TabBarDemo(
                    controller: _controller,
                    length: 2,
                    names: [
                      "Books",
                      "e-Books",
                    ],
                    routes: [
                      isLoading ? Center(child: CircularProgressIndicator(color: AppColors.amber)) :
                      BooksScreen(booksList),
                      isLoading ? Center(child: CircularProgressIndicator(color: AppColors.amber)) :
                      EBooksScreen(eBooksList)
                    ],
                    title: "Books")
            );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
