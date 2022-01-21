import 'package:exampur_mobile/presentation/widgets/custom_smaller_button.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BigCourseCard extends StatefulWidget {
  String subject;
  String name;

  BigCourseCard({
    Key? key,
    required this.subject,
    required this.name,
  }) : super(key: key);

  @override
  _BigCourseCardState createState() => _BigCourseCardState();
}

class _BigCourseCardState extends State<BigCourseCard> {
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
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.width * 0.9 * 9 / 16,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Image(
                    image: AssetImage(""),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12.0,
                    vertical: 2,
                  ),
                  child: Row(
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
                        height: 40,
                        width: 40,
                        child: Image(
                          image:
                              AssetImage(""), //todo: add images of courses here
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          SizedBox(height: 30,),
                          Container(
                            child: Row(
                              children: [
                                Icon(
                                  CupertinoIcons.check_mark,
                                  color: AppColors.yellow,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "1400+ hours live",
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: Row(
                              children: [
                                Icon(
                                  CupertinoIcons.check_mark,
                                  color: AppColors.yellow,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Up to date pdf notes",
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                          ),Container(
                            child: Row(
                              children: [
                                Icon(
                                  CupertinoIcons.check_mark,
                                  color: AppColors.yellow,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Live doubt sessions",
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                          ),Container(
                            child: Row(
                              children: [
                                Icon(
                                  CupertinoIcons.check_mark,
                                  color: AppColors.yellow,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Writing Practice",
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                          ),Container(
                            child: Row(
                              children: [
                                Icon(
                                  CupertinoIcons.check_mark,
                                  color: AppColors.yellow,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Guest Lectures",
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          height: 40,
                        ),
                        CustomSmallerElevatedButton(
                          color: AppColors.black,
                          onPressed: () {},
                          text: "View Details",
                        ),
                        CustomSmallerElevatedButton(
                          color: AppColors.black,
                          onPressed: () {},
                          text: "Buy Course",
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(
                              CupertinoIcons.share_up,
                              size: 23,
                              color: AppColors.black,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              "share",
                              style: TextStyle(
                                color: AppColors.black,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
