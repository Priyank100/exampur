import 'package:exampur_mobile/presentation/widgets/custom_smaller_button.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CourseCard extends StatefulWidget {
  String subject;
  String name;

  CourseCard({
    Key? key,
    required this.subject,
    required this.name,
  }) : super(key: key);

  @override
  _CourseCardState createState() => _CourseCardState();
}

class _CourseCardState extends State<CourseCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: Material(
        elevation: 10,
        shadowColor: AppColors.black,
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.white54,
            border: Border.all(color: AppColors.white24),
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 40,
                  width: 40,
                  child: Image(
                    image: AssetImage(""), //todo: add images of courses here
                  ),
                ),
                Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.name,
                            style: TextStyle(
                              color: AppColors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: AppColors.white38,
                              border: Border.all(
                                color: AppColors.black,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 4.0, horizontal: 8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(
                                    CupertinoIcons.circle_filled,
                                    color: AppColors.red,
                                    size: 13,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "New Batch",
                                    style: TextStyle(
                                        color: AppColors.black, fontSize: 13),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          CustomSmallerElevatedButton(
                            color: AppColors.black,
                            onPressed: () {},
                            text: "Buy Course",
                          ),
                          CustomSmallerElevatedButton(
                            color: AppColors.yellow,
                            onPressed: () {},
                            text: "Buy Course",
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(
                            CupertinoIcons.share_up,
                            size: 17,
                            color: AppColors.black,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            "share",
                            style: TextStyle(color: AppColors.black),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
