import 'dart:io';
import 'package:exampur_mobile/presentation/home/books/books_screen.dart';
import 'package:exampur_mobile/presentation/home/books/e_books.dart';
import 'package:exampur_mobile/presentation/home/books/editorial_analysis.dart';
import 'package:exampur_mobile/presentation/widgets/custom_tab_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Books extends StatefulWidget {
  @override
  BooksState createState() => BooksState();
}

class BooksState extends State<Books> {
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomTabBar(
            length: 3,
            names: [
              "Books",
              "Editorial Analysis",
              "e-Books",
            ],
            routes: [BooksScreen(), EditorialAnalysis(), EBooks()],
            title: "Books"));
  }
}
