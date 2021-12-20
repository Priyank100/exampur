import 'dart:io' show Platform;
import 'package:exampur_mobile/shared/pdf_card_ca.dart';
import 'package:exampur_mobile/utils/images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'aatempttestseries.dart';

class TestSeriesCardView extends StatefulWidget {
  @override
  _TestSeriesCardViewState createState() => _TestSeriesCardViewState();
}

class _TestSeriesCardViewState extends State<TestSeriesCardView> {
  List<ChooseTestSeriesModel> a = [
    ChooseTestSeriesModel("All Exam", "SSC", Images.testseries),
    ChooseTestSeriesModel("All Exam", "SSC", Images.testseries),
    ChooseTestSeriesModel("All Exam", "SSC", Images.testseries),
    ChooseTestSeriesModel("All Exam", "SSC", Images.testseries),
    ChooseTestSeriesModel("All Exam", "SSC", Images.testseries),
    ChooseTestSeriesModel("All Exam", "SSC", Images.testseries),
  ];

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
              ListView.builder(
                  itemCount: a.length,
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        boxShadow: const [
                          BoxShadow(
                              color: Color.fromRGBO(64, 64, 64, 0.12),
                              blurRadius: 16)
                        ],
                        color: Theme.of(context).backgroundColor,
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AttemptSeries()));
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              children: [
                                Container(
                                    padding: EdgeInsets.only(left: 10),
                                    width: MediaQuery.of(context).size.width *
                                        0.25,
                                    //flex: 1,
                                    child: FadeInImage(
                                      image: NetworkImage(a[index].image),
                                      placeholder: AssetImage(
                                          "assets/images/no_image.jpg"),
                                      imageErrorBuilder:
                                          (context, error, stackTrace) {
                                        return Image.asset(
                                          a[index].image,
                                          height: 40,
                                          width: 60,
                                        );
                                      },
                                    )),
                                const SizedBox(
                                  width: 15,
                                ),
                                Flexible(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          a[index].name,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            const FaIcon(
                                              FontAwesomeIcons.shareAlt,
                                              size: 15,
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text("Share",
                                                style: TextStyle(fontSize: 13))
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  })
            ],
          ),
        ));
  }
}

class ChooseTestSeriesModel {
  late String name, course;
  String image;

  ChooseTestSeriesModel(this.name, this.course, this.image);
}
