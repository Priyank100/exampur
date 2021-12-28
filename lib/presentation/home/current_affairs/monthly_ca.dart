import 'package:exampur_mobile/shared/pdf_card_ca.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MonthlyCA extends StatefulWidget {
  @override
  _MonthlyCAState createState() => _MonthlyCAState();
}

class _MonthlyCAState extends State<MonthlyCA> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              PDFCardCA(),
            ],
          ),
        ));
  }
}
