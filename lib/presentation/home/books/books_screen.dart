
import 'package:exampur_mobile/data/model/DummyModel.dart';
import 'package:exampur_mobile/presentation/widgets/loading_indicator.dart';
import 'package:exampur_mobile/shared/books_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BooksScreen extends StatefulWidget {
  final List<DummyModel> list;
  const BooksScreen(this.list) : super();
  @override
  _BooksScreenState createState() => _BooksScreenState();
}

class _BooksScreenState extends State<BooksScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:widget.list!=0? ListView.builder(
            itemCount: widget.list.length,
            shrinkWrap: true,
            itemBuilder: (BuildContext context,int index){
          return  BooksCard(widget.list, index);
        }):CircularProgressIndicator()


    );
  }
}
