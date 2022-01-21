import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:exampur_mobile/utils/dimensions.dart';
import 'package:exampur_mobile/utils/images.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class QuizCardCA extends StatefulWidget {
  QuizCardCA({
    Key? key,
  }) : super(key: key);

  @override
  _QuizCardCAState createState() => _QuizCardCAState();
}

class _QuizCardCAState extends State<QuizCardCA> {
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 7),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(color: Color.fromRGBO(64, 64, 64, 0.12), blurRadius: 16)
          ],
          color: Theme.of(context).backgroundColor,
        ),
        child: Material(
          color: AppColors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            onTap: () {},
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                  Container(
                      width: MediaQuery.of(context).size.width * 0.25,
                      //flex: 1,
                      padding: EdgeInsets.only(left: Dimensions.FONT_SIZE_SMALL),
                      // child: FadeInImage(
                      //   image: NetworkImage("widget.instance.image"),
                      //   placeholder: AssetImage(Images.noimage),
                      //   imageErrorBuilder: (context, error, stackTrace) {
                      //     return Image.asset(
                      //       Images.noimage,
                      //     );
                      //   },
                      // )
                    child: AppConstants.image('widget.instance.image'),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "fbdsjf",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                          SizedBox(height: 5,),
                          Row(
                            children: [
                              Container(
                                  width: 60,
                                  height: 25,
                                  decoration: BoxDecoration(
                                   // border: Border.all(color: AppColors.black),
                                    color: AppColors.amber
                                  ),
                                  child: Center(
                                      child: Text("Attempt",
                                          style: TextStyle(color: AppColors.white,fontSize: 13)))),
                              SizedBox(
                                width: 10,
                              ),
                              // FaIcon(
                              //   FontAwesomeIcons.eye,
                              //   size: 10,
                              // ),
                              // Text("1000", style: TextStyle(fontSize: 13)),
                              // SizedBox(
                              //   width: 10,
                              // ),

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
      ),
    );
  }
}
