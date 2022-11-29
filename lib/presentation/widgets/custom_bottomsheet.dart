import 'package:exampur_mobile/utils/app_colors.dart';
import 'package:flutter/material.dart';

import '../../utils/images.dart';


class ModalBottomSheet {
  static void moreModalBottomSheet(context) {
    Size size = MediaQuery.of(context).size;
    showModalBottomSheet(
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40.0),
        ),
        context: context,
        builder: (BuildContext bc) {
          return Container(
            height: size.height * 0.7,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20.0),
                topLeft: Radius.circular(20.0),
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  right: 0,
                    child: InkWell(onTap: (){Navigator.pop(context);}, child: Padding(
                        padding: const EdgeInsets.all(10),
                        child:Icon(Icons.clear)))),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
                  child:ListView(
                    physics: ClampingScrollPhysics(),
                    children: [
                      Image.asset(Images.unlock,height: 120,),
                      SizedBox(height: 15,),
                      Text('To unlock the videos \nPurchace the course and continue watching.',style: TextStyle(fontSize: 20),textAlign: TextAlign.center,),
                      SizedBox(height: 15,),
                      CustomContainerText('500+ Interactive Videos'),
                      SizedBox(height: 20,),
                      CustomContainerText('500+ Live Videos'),
                      SizedBox(height: 20,),
                      CustomContainerText('500+ chapter Notes'),
                      SizedBox(height: 20,),
                      CustomContainerText('500+ Test Series'),
                      SizedBox(height: 35,),
                      InkWell(
                        onTap: (){},
                        child: Container(height: 60,decoration: BoxDecoration(
                            color: AppColors.amber,
                            borderRadius: BorderRadius.all(Radius.circular(8))
                        ),
                          child: Center(child: Text('Purchase Now',style: TextStyle(color: AppColors.white,fontSize: 16),)),
                        ),
                      )
                    ],
                  ),
                )
              ],
            )

          );
        });
  }


  static Widget CustomContainerText(String text) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
          color: AppColors.grey300,
          borderRadius: BorderRadius.all(Radius.circular(8))
      ),
      child: Center(child: Text(text)),
    );
  }
}


