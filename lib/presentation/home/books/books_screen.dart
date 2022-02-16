import 'package:exampur_mobile/Localization/language_constrants.dart';
import 'package:exampur_mobile/data/model/books_model.dart';
import 'package:exampur_mobile/provider/BooksEBooksProvider.dart';
import 'package:exampur_mobile/shared/books_card.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:exampur_mobile/data/model/e_book_model.dart';
import 'package:provider/provider.dart';

class BooksScreen extends StatefulWidget {
  // final List<Data> eBooksList;
  // const BooksScreen(this.eBooksList) : super();

  @override
  _BooksScreenState createState() => _BooksScreenState();
}

class _BooksScreenState extends State<BooksScreen> {
  List<Data> eBooksList = [];
  bool isLoading = false;
  var scrollController = ScrollController();
  int page = 0;
  bool isData = true;

  Future<void> getBooksList(pageNo) async {
   List<Data> list = (await Provider.of<BooksEBooksProvider>(context, listen: false).getBooksList(context,pageNo))!;
    if(list.length > 0) {
      isData = true;
      eBooksList = eBooksList + list;
    } else {
      isData = false;
    }
    isLoading = false;
    setState(() {});
  }
  @override
  void initState() {
    scrollController.addListener(pagination);
    getBooksList(page);
    super.initState();
  }
  void pagination() {
    if ((scrollController.position.pixels == scrollController.position.maxScrollExtent)) {
      setState(() {
        if(isData) {
          page += 1;
        }
        isLoading = true;
        getBooksList(page);
        AppConstants.printLog('page>> ' + page.toString());
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:eBooksList.length==0 ?
        Center(child: CircularProgressIndicator(color: AppColors.amber,))    :
        ListView.builder(
            itemCount: eBooksList.length,
            controller: scrollController,
           // shrinkWrap: true,
            itemBuilder: (BuildContext context,int index){
          return  BooksCard(eBooksList[index]);
        }),
        bottomNavigationBar: isLoading ? Container(
        // padding: EdgeInsets.all(8),
        height:40,
        width: 40,
        child: Center(child: CircularProgressIndicator(color:AppColors.amber,))) :
    SizedBox(),
    );
  }
}
