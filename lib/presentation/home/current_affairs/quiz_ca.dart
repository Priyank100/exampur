import 'package:exampur_mobile/shared/quiz_card_ca.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class QuizCA extends StatefulWidget {
  @override
  _QuizCAState createState() => _QuizCAState();
}

class _QuizCAState extends State<QuizCA> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              QuizCardCA()
            ],
          ),
        ));
  }
}
