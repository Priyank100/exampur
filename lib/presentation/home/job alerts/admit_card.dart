import 'package:exampur_mobile/shared/pdf_card_ca.dart';
import 'package:exampur_mobile/shared/video_card_ca.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdmitCard extends StatefulWidget {
  @override
  _AdmitCardState createState() => _AdmitCardState();
}

class _AdmitCardState extends State<AdmitCard> {
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

