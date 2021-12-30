import 'package:exampur_mobile/data/model/DummyModel.dart';
import 'package:exampur_mobile/shared/books_card.dart';
import 'package:exampur_mobile/shared/pdf_card_ca.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EBooks extends StatefulWidget {
  final List<DummyModel> list;
  const EBooks(this.list) : super();
  @override
  _EBooksState createState() => _EBooksState();
}

class _EBooksState extends State<EBooks> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.list;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // body: SingleChildScrollView(
        //   child: Column(
        //     children: [
        //       PDFCardCA()
        //     ],
        //   ),
        // )

    body:   ListView.builder(

        shrinkWrap: true,
        itemCount: widget.list.length,
            itemBuilder: (context, index) {
          return    PDFCardCA(widget.list, index);
            } ),


    );
  }
}
