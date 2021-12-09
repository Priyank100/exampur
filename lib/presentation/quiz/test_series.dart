

import 'dart:io';
import 'package:exampur_mobile/presentation/quiz/single_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TestSeries extends StatefulWidget {
  @override
  TestSeriesState createState() => TestSeriesState();
}

class TestSeriesState extends State<TestSeries> {
  @override
  void initState() {
    super.initState();
  }

  List<String> categories = ["ahhh", "bjbjknk", ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(

        length: categories.length,
        child: Scaffold(
            appBar: AppBar(
                title: Text("Quiz"),
                bottom: TabBar(

                    isScrollable: true,
                    unselectedLabelColor: Colors.white.withOpacity(0.3),
                    indicatorColor: Colors.white,
                    tabs: List<Widget>.generate(categories.length, (int index) {
                      print(categories[index]);
                      return Tab(
                          text: categories[index]);
                    }))),
            body: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: List<Widget>.generate(categories.length, (int index) {
              return SingleCard();
            })),
          bottomNavigationBar: BottomAppBar(
            color: Theme.of(context).backgroundColor,
            child:  SizedBox(
                height: 55,
                child: Column(
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [IconButton(onPressed:(){}, icon:  FaIcon(FontAwesomeIcons.backward)),
                        IconButton(onPressed:(){}, icon:  FaIcon(FontAwesomeIcons.forward))],
                    )
                  ],
                ),
              )

          ),));
  }
}
