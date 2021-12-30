import 'dart:io';
import 'package:exampur_mobile/data/model/DummyModel.dart';
import 'package:exampur_mobile/presentation/home/books/books_screen.dart';
import 'package:exampur_mobile/presentation/home/books/e_books.dart';
import 'package:exampur_mobile/presentation/home/books/editorial_analysis.dart';
import 'package:exampur_mobile/presentation/widgets/custom_tab_bar.dart';
import 'package:exampur_mobile/utils/images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Books extends StatefulWidget {
  @override
  BooksState createState() => BooksState();
}

class BooksState extends State<Books>  with TickerProviderStateMixin  {
  late TabController _controller;
  int _selectedIndex = 0;
  List<DummyModel> teachingList = [];
  List<DummyModel> e_bookList = [];
  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 3, vsync: this);

    _controller.addListener(() {
      setState(() {
        _selectedIndex = _controller.index;
      });
      print("Selected Index: " + _controller.index.toString());
      switch( _controller.index) {
        case 0:
          setState(() {

          });
          teachingList.add(DummyModel(imagePath: Images.exampur_logo,title: 't1',target: 'tg1'));
          teachingList.add(DummyModel(imagePath: Images.exampur_logo,title: 't2',target: 'tg2'));
          teachingList.add(DummyModel(imagePath: Images.exampur_logo,title: 't3',target: 'tg3'));
          teachingList.add(DummyModel(imagePath: Images.exampur_logo,title: 't4',target: 'tg4'));
          break;
        case 1:

          break;
        case 2:
          e_bookList.add(DummyModel(imagePath: Images.exampur_logo,title: 't1kjhgfdrtfyuioiuytfrfgyhujikol',target: 'tg1'));
          e_bookList.add(DummyModel(imagePath: Images.exampur_logo,title: 't2',target: 'tg2'));
          e_bookList.add(DummyModel(imagePath: Images.exampur_logo,title: 't3',target: 'tg3'));
          e_bookList.add(DummyModel(imagePath: Images.exampur_logo,title: 't4',target: 'tg4'));
          break;
        default: {
          Center(child: Text('Hello'));
        }
        break;
      }
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: TabBarDemo(
            controller: _controller,
            length: 3,
            names: [
              "Books",
              "Editorial Analysis",
              "e-Books",
            ],
            routes: [BooksScreen(teachingList),EBooks(e_bookList) , EBooks(e_bookList)],
            title: "Books"));
  }
}
