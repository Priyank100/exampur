


import 'package:exampur_mobile/Localization/language_constrants.dart';
import 'package:exampur_mobile/data/model/one2_one_models.dart';
import 'package:exampur_mobile/presentation/theme/custom_text_style.dart';
import 'package:exampur_mobile/shared/one_two_one_card.dart';
import 'package:exampur_mobile/utils/appBar.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:exampur_mobile/utils/images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';

import 'one2oneViedo.dart';

class One2onelist extends StatefulWidget {
  final List<Courses> one2oneList;
  final int index;

  const One2onelist(this.one2oneList, this.index) : super();

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
            padding: const EdgeInsets.only(left: 14.0),
            child: Text(
              getTranslated(context, 'exampur_one2one')!,
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
                            //flex: 1,
                            // child: FadeInImage(
                            //   image: NetworkImage(AppConstants.BANNER_BASE+  widget.one2oneList[widget.index].logoPath.toString(),),
                            //   placeholder: AssetImage(Images.noimage),
                            //   imageErrorBuilder: (context, error, stackTrace) {
                            //     return Image.network(
                            //         AppConstants.BANNER_BASE+  widget.one2oneList[widget.index].logoPath.toString(),
                            //     );
                            //   },
                            // )
                          child: AppConstants.image(AppConstants.BANNER_BASE+  widget.one2oneList[widget.index].logoPath.toString()),
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
                                      widget.one2oneList[widget.index].title.toString(),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15,
                                      ),
                                ),

                                     widget.one2oneList[widget.index].flag != null?Container(
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
                                             Lottie.network(
                                                 'https://assets2.lottiefiles.com/packages/lf20_HztQu8.json'),
                                             Text(getTranslated(context, 'new_batch')!,
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
                                                builder: (context) => One2OneVideo(widget.one2oneList[widget.index])));
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
                                              child: Text(getTranslated(context, 'view_details')!,
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      color: AppColors.white)))),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),

                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                     Image.asset(Images.share,height: 15,width: 15,),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(getTranslated(context, 'share')!,
                                          style: TextStyle(fontSize: 13))
                                    ],
                                  ),
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
          )
        ],
      ),
    );
  }
}
