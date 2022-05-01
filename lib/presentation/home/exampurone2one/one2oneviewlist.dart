import 'dart:convert';

import 'package:exampur_mobile/Localization/language_constrants.dart';
import 'package:exampur_mobile/data/model/one2_one_models.dart';
import 'package:exampur_mobile/dynamicLink/firebase_dynamic_link.dart';
import 'package:exampur_mobile/presentation/theme/custom_text_style.dart';

import 'package:exampur_mobile/utils/appBar.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:exampur_mobile/utils/images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:share/share.dart';

import 'one2oneViedo.dart';

class One2onelist extends StatefulWidget {
  final One2OneCourses one2oneData;

  const One2onelist(this.one2oneData) : super();

  @override
  _One2onelistState createState() => _One2onelistState();
}

class _One2onelistState extends State<One2onelist> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 14.0,top:6,bottom: 7),
            child: Text(
              getTranslated(context, StringConstant.exampurOne2one)!,
              style: CustomTextStyle.headingBold(context),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                boxShadow: const [
                  BoxShadow(
                    color: AppColors.grey,
                    offset: Offset(
                      0.0,
                      0.0,
                    ),
                    blurRadius: 4.0,
                    spreadRadius: 0.0,
                  ),
                ],
                color: Theme.of(context).backgroundColor,
              ),
              child: Material(
                color: AppColors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  onTap: () {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => One2OneVideo(widget.one2oneList[widget.index])));
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: [
                        Container(
                            padding: EdgeInsets.only(left: 10),
                            width: MediaQuery.of(context).size.width * 0.17,

                          child: widget.one2oneData.logoPath.toString().contains('http') ?
                          AppConstants.image(widget.one2oneData.logoPath.toString()) :
                          AppConstants.image(AppConstants.BANNER_BASE +  widget.one2oneData.logoPath.toString()),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                 Row(
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                   children: [

                                     Text(
                                      widget.one2oneData.title.toString(),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15,
                                      ),
                                ),

                                     widget.one2oneData.flag != null?Container(
                                         width: 80,
                                         height: 25,
                                         //margin: EdgeInsets.all(5),
                                         //padding: EdgeInsets.all(5),
                                         decoration: BoxDecoration(
                                           borderRadius:
                                           BorderRadius.circular(15),

                                           border: Border.all(
                                               color: AppColors.black, width: 2),

                                           //color: AppColors.black
                                         ),
                                         child: Row(
                                           children: [
                                             Lottie.asset('assets/LiveLottie.json'),
                                             // Lottie.network(
                                             //     'https://assets2.lottiefiles.com/packages/lf20_HztQu8.json'),
                                             Text(getTranslated(context, StringConstant.newBatch)!,
                                                 style: TextStyle(
                                                   fontSize: 10,
                                                 )),
                                           ],
                                         )):SizedBox()
                                   ],
                                 ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    InkWell(
                                      onTap: (){
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    One2OneVideo(widget.one2oneData)));
                                      },
                                      child: Container(
                                          width: 100,
                                          height: 30,
                                          margin: EdgeInsets.all(5),
                                          padding: EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              border: Border.all(
                                                  color: Color(0xFF060929)),
                                              color: Color(0xFF060929)),
                                          child: Center(
                                              child: Text(getTranslated(context,StringConstant.viewDetails)!,
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      color: AppColors.white)))),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),

                                  ],
                                ),
                                InkWell(
                                  onTap: () async {
                                    String data = json.encode(widget.one2oneData);
                                    String dynamicUrl = await FirebaseDynamicLinkService.createDynamicLink('one2one', data, '0');
                                    String shareContent =
                                        'Get "' + widget.one2oneData.title.toString() + '" Course from Exampur Now.\n' +
                                            dynamicUrl;
                                    Share.share(shareContent);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Image.asset(Images.share,height: 15,width: 15,),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(getTranslated(context, StringConstant.share)!,
                                            style: TextStyle(fontSize: 13))
                                      ],
                                    ),
                                  ),
                                )
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
          )
        ],
      ),
    );
  }
}
