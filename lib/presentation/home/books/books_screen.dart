import 'package:exampur_mobile/data/model/books_model.dart';
import 'package:exampur_mobile/shared/books_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BooksScreen extends StatefulWidget {
  final List<Books> booksList;
  const BooksScreen(this.booksList) : super();

  @override
  _BooksScreenState createState() => _BooksScreenState();
}

class _BooksScreenState extends State<BooksScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:widget.booksList.length==0 ? Center(child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline),
            Text('No Data')
          ],
        )) :
        ListView.builder(
            itemCount: widget.booksList.length,
            shrinkWrap: true,
            itemBuilder: (BuildContext context,int index){
          return  BooksCard(widget.booksList[index]);
        })
    );
  }
}
