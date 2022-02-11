import 'package:exampur_mobile/data/model/e_book_model.dart';
import 'package:exampur_mobile/provider/BooksEBooksProvider.dart';
import 'package:exampur_mobile/shared/pdf_card_ca.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EBooksScreen extends StatefulWidget {
  // final List<Data> eBooksList;
  // const EBooksScreen(this.eBooksList) : super();

  @override
  _EBooksScreenState createState() => _EBooksScreenState();
}

class _EBooksScreenState extends State<EBooksScreen> {
  List<Data> eBooksList = [];
  bool isLoading = false;
  var scrollController = ScrollController();
  int page = 0;
  bool isData = true;
  Future<void> getBooksList(pageNo) async {
    isLoading = true;
    List<Data> list = (await Provider.of<BooksEBooksProvider>(context, listen: false).getE_booksList(context,pageNo))!;
    if(list.length > 0) {
      isData = true;
      eBooksList = eBooksList + list;
    } else {
      isData = false;
    }
    isLoading = false;
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
             Center(child: CircularProgressIndicator(color: AppColors.amber,)):
         //Center(child: Column(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     Icon(Icons.error_outline),
        //     Text('No Data')
        //   ],
        // )) :
        ListView.builder(
            itemCount: eBooksList.length,
           // shrinkWrap: true,
            controller: scrollController,
            itemBuilder: (BuildContext context,int index){
              return  PDFCardCA(eBooksList[index], index);
            }),
      // bottomNavigationBar: isLoading ? Container(
      //   // padding: EdgeInsets.all(8),
      //     height:40,
      //     width: 40,
      //     child: Center(child: CircularProgressIndicator(color:AppColors.amber,))) :
      // SizedBox(),
    );
  }
}
