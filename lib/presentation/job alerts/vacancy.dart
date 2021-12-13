import 'package:exampur_mobile/widgets/pdf_card_ca.dart';
import 'package:exampur_mobile/widgets/video_card_ca.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Vacancy extends StatefulWidget {
  @override
  _VacancyState createState() => _VacancyState();
}

class _VacancyState extends State<Vacancy> {
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

