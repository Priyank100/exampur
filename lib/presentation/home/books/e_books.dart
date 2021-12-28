import 'package:exampur_mobile/shared/books_card.dart';
import 'package:exampur_mobile/shared/pdf_card_ca.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EBooks extends StatefulWidget {
  @override
  _EBooksState createState() => _EBooksState();
}

class _EBooksState extends State<EBooks> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [PDFCardCA()],
          ),
        ));
  }
}
