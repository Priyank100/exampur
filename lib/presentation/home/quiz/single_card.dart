import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'answer.dart';

class SingleCard extends StatefulWidget {
  @override
  _SingleCardState createState() => _SingleCardState();
}

class _SingleCardState extends State<SingleCard> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(65.0),
          child: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.transparent,
              elevation: 0,

              title: Text(
                "Exampur",
                style: TextStyle(color: Colors.black),
              )),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [


            ],
          ),
        ));
  }
}
