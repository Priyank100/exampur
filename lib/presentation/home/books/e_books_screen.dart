import 'package:exampur_mobile/data/model/e_book_model.dart';
import 'package:exampur_mobile/shared/pdf_card_ca.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EBooksScreen extends StatefulWidget {
  final List<EBooks> eBooksList;
  const EBooksScreen(this.eBooksList) : super();

  @override
  _EBooksScreenState createState() => _EBooksScreenState();
}

class _EBooksScreenState extends State<EBooksScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:widget.eBooksList.length==0 ? Center(child: CircularProgressIndicator(color: AppColors.amber,)) :
        ListView.builder(
            itemCount: widget.eBooksList.length,
            shrinkWrap: true,
            itemBuilder: (BuildContext context,int index){
              return  PDFCardCA(widget.eBooksList[index], index);
            })
    );
  }
}
