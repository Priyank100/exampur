import 'package:exampur_mobile/widgets/pdf_card_ca.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DailyCA extends StatefulWidget {
  @override
  _DailyCAState createState() => _DailyCAState();
}

class _DailyCAState extends State<DailyCA> {
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
