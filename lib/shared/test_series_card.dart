import 'package:exampur_mobile/presentation/widgets/custom_smaller_button.dart';
import 'package:exampur_mobile/presentation/widgets/custom_outlined_button.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TestSeriesCard extends StatefulWidget {
  String subject;
  String name;

  TestSeriesCard({
    Key? key,
    required this.subject,
    required this.name,
  }) : super(key: key);

  @override
  _TestSeriesCardState createState() => _TestSeriesCardState();
}

class _TestSeriesCardState extends State<TestSeriesCard> {
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
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Container(
                  height: 60,
                  width: 60,
                  child: Icon(
                    CupertinoIcons.square_favorites_fill,
                    color: AppColors.red,
                    size: 60,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: Text(
                        widget.name,
                        maxLines: 3,
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                          color: AppColors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
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
                          "Share",
                          style: TextStyle(
                            color: AppColors.black,
                            fontSize: 17,
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
          ),
        ),
      ),
    );
  }
}
