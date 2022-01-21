import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:exampur_mobile/utils/images.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class VideoCardAT extends StatefulWidget {
  VideoCardAT({
    Key? key,
  }) : super(key: key);

  @override
  _VideoCardATState createState() => _VideoCardATState();
}

class _VideoCardATState extends State<VideoCardAT> {
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
                      width: MediaQuery.of(context).size.width * 0.3,
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
                            "fbdsfnjfnwiue fewfhuwe fweouf weuuh feiuf efuie fiuf euhff eiufwe fwiujf",
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
                              Container(
                                  width: 100,
                                  height: 25,
                                  decoration: BoxDecoration(color: AppColors.red),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          FontAwesomeIcons.play,
                                          size: 10,
                                          color: AppColors.white,
                                        ),
                                        SizedBox(width: 5),
                                        Text("View",
                                            style: TextStyle(
                                                color: AppColors.white,
                                                fontSize: 13))
                                      ])),
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
