import 'package:exampur_mobile/data/model/e_book_model.dart';
import 'package:exampur_mobile/presentation/widgets/loading_indicator.dart';
import 'package:exampur_mobile/provider/BooksEBooksProvider.dart';
import 'package:exampur_mobile/shared/ebooksContainer.dart';
import 'package:exampur_mobile/utils/lang_string.dart';
import 'package:exampur_mobile/utils/app_constants.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/analytics_constants.dart';

class EBooksScreen extends StatefulWidget {
  // final List<Data> eBooksList;
  // const EBooksScreen(this.eBooksList) : super();

  @override
  _EBooksScreenState createState() => _EBooksScreenState();
}

class _EBooksScreenState extends State<EBooksScreen> {
  List<BookEbook> eBooksList = [];
  bool isBottomLoading = false;
  var scrollController = ScrollController();
  int page = 0;
  bool isData = true;
  int isLoad = 0;

  Future<void> getBooksList(pageNo) async {
    List<BookEbook> list = (await Provider.of<BooksEBooksProvider>(context, listen: false).getE_booksList(context,pageNo))!;
    if(list.length > 0) {
      isData = true;
      eBooksList = eBooksList + list;
    } else {
      isData = false;
    }
    isBottomLoading = false;
    isLoad++;
    setState(() {});
  }

  @override
  void initState() {
    var map = {
      'Page_Name':'Books List',
      'Mobile_Number':AppConstants.userMobile,
      'Language':AppConstants.langCode,
      'User_ID':AppConstants.userMobile,
    };
    AnalyticsConstants.trackEventMoEngage(AnalyticsConstants.E_Bookclick,map);
    scrollController.addListener(pagination);
    isLoad = 0;
    getBooksList(page);
    super.initState();
  }
  void pagination() {
    if ((scrollController.position.pixels == scrollController.position.maxScrollExtent)) {
      setState(() {
        if(isData) {
          page += 10;
        }
        isBottomLoading = true;
        getBooksList(page);
        AppConstants.printLog('page>> ' + page.toString());
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
         body:isLoad==0 ? Center(child: LoadingIndicator(context)) :eBooksList.length==0 ?
         AppConstants.noDataFound() :
        ListView.builder(
            itemCount: eBooksList.length,
            controller: scrollController,
            itemBuilder: (BuildContext context,int index){
              return  PDFCardCA(eBooksList[index], index);
            }),
      bottomNavigationBar:isBottomLoading ? Container(
        // padding: EdgeInsets.all(8),
          height:40,
          width: 40,
          child: Center(child: LoadingIndicator(context))) :
      SizedBox(),
    );
  }
}
