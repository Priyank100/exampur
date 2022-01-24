import 'package:exampur_mobile/Localization/language_constrants.dart';
import 'package:exampur_mobile/data/model/dummy_model.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:exampur_mobile/utils/dimensions.dart';
import 'package:exampur_mobile/utils/images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ContainerwithBuyandView extends StatelessWidget {

  final List<DummyModel> list;
  final int index;
  const  ContainerwithBuyandView (this.list, this.index) : super();


  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: EdgeInsets.only(bottom: 10,top: 10,left: 5,right: 5),
            decoration: BoxDecoration(
              color: Theme.of(context).backgroundColor,
             // border: Border.all(color: AppColors.white24),
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
              boxShadow:const [
                BoxShadow(
                  color: AppColors.grey,
                  offset:  Offset(
                    0.0,
                    0.0,
                  ),
                  blurRadius: 3.0,
                  spreadRadius: 0.0,
                ),
              ],
            ),
child: Row(
  crossAxisAlignment: CrossAxisAlignment.start,
  mainAxisAlignment: MainAxisAlignment.spaceAround,
  children: [
 Padding(
   padding: const EdgeInsets.only(top: 10),
   child: Image.asset(list[index].imagePath.toString(),height: 50,width: 50,),
 ),
  SizedBox(width: 10,),
  Flexible(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(list[index].title.toString(),maxLines: 3,softWrap:false, overflow: TextOverflow.ellipsis,),
        SizedBox(height: Dimensions.FONT_SIZE_SMALL,),
        Row(
          children: [
            Container(height: 30,decoration: BoxDecoration(
              color: Color(0xFF060929),
              // border: Border.all(color: AppColors.white24),
              borderRadius: BorderRadius.all(
                Radius.circular(6),
              ),
            ),width: 100,
              child: Center(child: Text(getTranslated(context, 'buy_course')!,textAlign: TextAlign.center,style: TextStyle(color: AppColors.white),)),
            ),
            SizedBox(width:Dimensions.FONT_SIZE_SMALL),
            Container(height: 30,  decoration: BoxDecoration(
              color: AppColors.amber,
              // border: Border.all(color: AppColors.white24),
              borderRadius: BorderRadius.all(
                Radius.circular(6),
              ),
            ),width: 100, child: Center(child: Text(getTranslated(context, 'view_details')!,style: TextStyle(color: AppColors.white),)),),
          ],
        ),

      ],
    ),
  ),
    SizedBox(width: 8,),
    Column(

      children: [
        Container(height: 30,decoration: BoxDecoration(
          //color: AppColors.amber,
          border: Border.all(color: AppColors.black),
          borderRadius: BorderRadius.all(
            Radius.circular(6),
          ),
        ),width: 100, child:
        Row(
            children: [
            Lottie.network(
            'https://assets7.lottiefiles.com/packages/lf20_buuuwhvb.json',width: 21),
          Text("New Batch",
              style: TextStyle(
                fontSize: 13,
              )),])),
        SizedBox(height: 30,),
        Row(
          children: [
            Image.asset(Images.share,height: 15,width: 15,),
            SizedBox(width: 5,),
            Text('Share')
          ],
        )
      ],
    )
],),



    );
  }
}
