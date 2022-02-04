import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:exampur_mobile/utils/dimensions.dart';
import 'package:exampur_mobile/utils/images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class QuizCardCA extends StatefulWidget {
  const QuizCardCA({
    Key? key,
  }) : super(key: key);

  @override
  _QuizCardCAState createState() => _QuizCardCAState();
}

class _QuizCardCAState extends State<QuizCardCA> {
  Widget build(BuildContext context) {
    return  Container(
     // padding: EdgeInsets.only(left: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: const [
            BoxShadow(color: Color.fromRGBO(64, 64, 64, 0.12), blurRadius: 16)
          ],
          color: Theme.of(context).backgroundColor,
        ),
        child: Material(
          color: AppColors.transparent,
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             Row(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: const [
                 Flexible(
                   child: Padding(
                     padding: EdgeInsets.only(left: 8.0,top: 8),
                     child: Text('REET L-2(Sci+Maths)[91-150 Q] Test series',style: TextStyle(fontSize: 19),maxLines: 2,),
                   ),
                 ),
                 //Image.asset(Images.exampur_logo,height: 80,width: 90,)
               ],
             ),


             Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               crossAxisAlignment: CrossAxisAlignment.center,
               children: [
                 Column(
                   crossAxisAlignment: CrossAxisAlignment.center,
                   children: const [

                     Padding(
                       padding: EdgeInsets.all(8.0),
                       child: Text('REET L-2(Sci+Maths)[91-150 Q] Test series',style: TextStyle(fontSize: 12)),
                     ),
                     Text('10,0000000+'+ 'Attempts',style: TextStyle(fontSize: 10),),
                   ],
                 ),
                 Image.asset(Images.exampur_logo,height: 60,width: 90,),
               ],
             ),
Row(
  children: const [
    SizedBox(width: 8,),
        Text('60 Questions'),
    SizedBox(width: 8,),
    Text('60 Marks'),
    SizedBox(width: 8,),
    Text('60 Minutes')
  ],
),
             const SizedBox(height: 8,),
             Align(
               alignment: FractionalOffset.bottomCenter,
               child: InkWell(
                 onTap: () {},
                 child: Container(
                   height: 40,
                   alignment: Alignment.center,
                   decoration: const BoxDecoration(
                     color: AppColors.amber,
                     borderRadius: BorderRadius.only(
                       bottomRight: Radius.circular(5),
                       bottomLeft: Radius.circular(5),
                     ),
                   ),
                   child: const Text('Attempt', style: TextStyle(color: AppColors.white)),
                 ),
               ),
             ),
           ],
         ),
        ),

    );
  }
}
