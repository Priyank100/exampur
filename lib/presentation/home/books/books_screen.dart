import 'package:exampur_mobile/shared/books_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BooksScreen extends StatefulWidget {
  @override
  _BooksScreenState createState() => _BooksScreenState();
}

class _BooksScreenState extends State<BooksScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [BooksCard(subject: "subject", name: "name")],
      ),
    ));
  }
}
