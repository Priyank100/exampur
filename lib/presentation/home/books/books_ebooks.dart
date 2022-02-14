import 'package:exampur_mobile/Localization/language_constrants.dart';
import 'package:exampur_mobile/data/model/books_model.dart';
import 'package:exampur_mobile/data/model/booktitle.dart';
import 'package:exampur_mobile/data/model/dummy_model.dart';
import 'package:exampur_mobile/data/model/e_book_model.dart';
import 'package:exampur_mobile/presentation/home/books/books_screen.dart';
import 'package:exampur_mobile/presentation/home/books/e_books_screen.dart';
import 'package:exampur_mobile/presentation/widgets/custom_tab_bar.dart';
import 'package:exampur_mobile/provider/BooksEBooksProvider.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class BooksEbook extends StatefulWidget {
  @override
  BooksEbookState createState() => BooksEbookState();
}

class BooksEbookState extends State<BooksEbook> with SingleTickerProviderStateMixin   {
   TabController? _controller;
 // List<Books> booksList = [];
  List<Book> issueList = [];
  List<Data> eBooksList = [];
  int bookvalue = 0;
  bool isLoading = false;

  Future<String> loadJsonFromAssets() async {
    return await rootBundle.loadString('assets/Statejson/booklist.json');
  }
  void getStateList() async {
    String jsonString = await loadJsonFromAssets();
    final BookResponse = booktitleFromJson(jsonString);
    issueList  =BookResponse.book!;
    // for (var i = 0; i < issueList.length; i++) {
    //   print(issueList[i].name);
    //   bookvalue=issueList[i].name.toString();
    // }
    setState(() {});
  }
  // Future<List> getBooksList() async {
  //   isLoading = true;
  //  // eBooksList = (await Provider.of<BooksEBooksProvider>(context, listen: false).getBooksList(context,))!;
  //   isLoading = false;
  //   return eBooksList;
  // }

  @override
  void initState() {
    super.initState();
    getStateList();
    super.initState();
    // _controller = TabController(length: 2, vsync: this);
    //
    // _controller.addListener(() async {
    //   switch(_controller.index) {
    //     case 0:
    //       getBooksList();
    //       break;
    //     case 1:
    //       isLoading = true;
    //       eBooksList = (await Provider.of<BooksEBooksProvider>(context, listen: false).getE_booksList(context))!;
    //       isLoading = false;
    //       break;
    //   }
    //   setState(() {});
    // });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future:  Future.delayed(Duration.zero, () => getStateList()),
        builder: (context, snapshot) {
            return Scaffold(
                body: TabBarDemo(
                    controller: _controller,
                    length: issueList.length,
                    // names: [
                    //   "Books",
                    //   "e-Books",
                    // ],
                    names:issueList.map((item) => item.name.toString()).toList(),
                    routes: [
                      isLoading ? Center(child: CircularProgressIndicator(color: AppColors.amber)) :
                      BooksScreen(),
                      isLoading ? Center(child: CircularProgressIndicator(color: AppColors.amber)) :
                      EBooksScreen()
                    ],
                    // routes:bookvalue==0?
                    // issueList.map((item) => BooksScreen()).toList()
                    //     :
                    // issueList.map((item) =>EBooksScreen()).toList(),
                    title: getTranslated(context, StringConstant.books)!)
            );
    });
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }
}
