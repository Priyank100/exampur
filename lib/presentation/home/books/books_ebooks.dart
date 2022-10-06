import 'package:exampur_mobile/Localization/language_constrants.dart';
import 'package:exampur_mobile/data/model/booktitle.dart';
import 'package:exampur_mobile/data/model/e_book_model.dart';
import 'package:exampur_mobile/presentation/home/books/books_screen.dart';
import 'package:exampur_mobile/presentation/home/books/e_books_screen.dart';
import 'package:exampur_mobile/presentation/widgets/custom_tab_bar.dart';
import 'package:exampur_mobile/utils/lang_string.dart';
import 'package:exampur_mobile/utils/app_constants.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../utils/analytics_constants.dart';

class BooksEbook extends StatefulWidget {
  @override
  BooksEbookState createState() => BooksEbookState();
}

class BooksEbookState extends State<BooksEbook> with SingleTickerProviderStateMixin   {
  List<Book> tabList = [];
  List<BookEbook> eBooksList = [];

  Future<String> loadJsonFromAssets() async {
    return await rootBundle.loadString('assets/LocalJson/booklist.json');
  }

  void getTabList() async {
    String jsonString = await loadJsonFromAssets();
    final BookResponse = booktitleFromJson(jsonString);
    tabList = BookResponse.book!;
    setState(() {});
  }

  @override
  void initState() {
    getTabList();
    var map = {
      'Page_Name':'Home_Page',
      'Mobile_Number':AppConstants.userMobile,
      'Language':AppConstants.langCode,
      'Course_Category':AppConstants.selectedCategoryName.toString(),
      'User_ID':AppConstants.userMobile
    };
    AnalyticsConstants.trackEventMoEngage(AnalyticsConstants.Click_Books,map);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future:  Future.delayed(Duration.zero, () => getTabList()),
        builder: (context, snapshot) {
            return Scaffold(
                body: TabBarDemo(
                    length: tabList.length,
                    names: tabList.map((item) => item.name.toString()).toList(),
                    routes: tabList.length == 0 ? [] : [
                      BooksScreen(),
                      EBooksScreen()
                    ],
                    title: getTranslated(context, LangString.books)!)
            );
    });
  }
}
