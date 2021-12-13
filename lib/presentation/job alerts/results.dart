import 'package:exampur_mobile/widgets/pdf_card_ca.dart';
import 'package:exampur_mobile/widgets/video_card_ca.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Results extends StatefulWidget {
  @override
  _ResultsState createState() => _ResultsState();
}

class _ResultsState extends State<Results> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              PDFCardCA()
            ],
          ),
        ));
  }
}

