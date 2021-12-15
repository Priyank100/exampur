import 'dart:io';
import 'package:exampur_mobile/presentation/home/quiz/single_card.dart';
import 'package:exampur_mobile/presentation/theme/custom_text_style.dart';
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

  List<String> categories = [
    "ahhh",
    "bjbjknk",
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: categories.length,
        child: Scaffold(
          appBar: AppBar(
              iconTheme: IconThemeData(
                color: Colors.black,
              ),
              title: Text(
                "Logo",
                style: CustomTextStyle.headingBold(context),
              ),
              backgroundColor: Colors.transparent,
              elevation: 0,
              bottom: PreferredSize(
                  preferredSize: Size.fromHeight(65.0),
                  child: Align(alignment: Alignment.centerLeft,
                    child: Column(
                        children: [
                      Text(
                        "Test series",
                        style: CustomTextStyle.headingBold(context),
                      ),
                      TabBar(
                          isScrollable: true,
                          unselectedLabelColor: Colors.grey,
                          indicatorColor: Colors.black,
                          tabs: List<Widget>.generate(categories.length,
                              (int index) {
                            print(categories[index]);
                            return Tab(text: categories[index]);
                          })),
                    ]),
                  ))),
          body: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              children: List<Widget>.generate(categories.length, (int index) {
                return SingleCard();
              })),
          bottomNavigationBar: BottomAppBar(
              color: Theme.of(context).backgroundColor,
              child: SizedBox(
                height: 55,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () {},
                            icon: FaIcon(FontAwesomeIcons.backward)),
                        IconButton(
                            onPressed: () {},
                            icon: FaIcon(FontAwesomeIcons.forward))
                      ],
                    )
                  ],
                ),
              )),
        ));
  }
}
