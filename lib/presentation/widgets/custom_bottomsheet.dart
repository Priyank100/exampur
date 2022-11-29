import 'package:exampur_mobile/presentation/DeliveryDetail/delivery_detail_screen.dart';
import 'package:exampur_mobile/utils/app_colors.dart';
import 'package:exampur_mobile/utils/delivery_detail_screen_param.dart';
import 'package:exampur_mobile/utils/images.dart';
import 'package:flutter/material.dart';

import '../../utils/analytics_constants.dart';
import '../../utils/app_constants.dart';

class ModalBottomSheet {
  static void moreModalBottomSheet(context,pageName) {
    Map<String, dynamic> data = SamplingBottomSheetParam.getDeliveryDetailParam;
    List<String> featuresList = SamplingBottomSheetParam.getFeaturesList;
    Size size = MediaQuery.of(context).size;
    var analytics = {
      'Page_Name':pageName.toString(),
      'Course_Category':AppConstants.paidTabName,
      'Course_Name':data['title'].toString(),
      'Mobile_Number':AppConstants.userMobile,
      'Language':AppConstants.langCode,
      'User_ID':AppConstants.userMobile,
    };
    AnalyticsConstants.trackEventMoEngage(AnalyticsConstants.Purchase_Now_Sampling,analytics);
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
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 5),
                  child:ListView(
                    physics: ClampingScrollPhysics(),
                    children: [
                      Image.asset(Images.unlock,height: 120,),
                      SizedBox(height: 10),
                      Text('To unlock the videos \nPurchace the course and continue watching.',style: TextStyle(fontSize: 20),textAlign: TextAlign.center,),
                      SizedBox(height: 10),
                      ListView.builder(
                        shrinkWrap: true,
                          itemCount: featuresList.length,
                          itemBuilder: (context, index) {
                            return CustomContainerText(featuresList[index]);
                          }),
                      SizedBox(height: 20),
                      InkWell(
                        onTap: (){
                          var analytics = {
                            'Page_Name':pageName.toString(),
                            'Course_Category':AppConstants.paidTabName,
                            'Course_Name':data['title'].toString(),
                            'Mobile_Number':AppConstants.userMobile,
                            'Language':AppConstants.langCode,
                            'User_ID':AppConstants.userMobile,
                          };
                          AnalyticsConstants.trackEventMoEngage(AnalyticsConstants.Click_Purchase_Now_Sampling,analytics);
                          Navigator.pushReplacement(
                              context, MaterialPageRoute(builder: (context) =>
                              DeliveryDetailScreen(
                                  data['courseTabType'],
                                  data['id'],
                                  data['title'],
                                  data['salePrice'],
                                  upsellBookList: data['upsellBookList'],
                                  emiPlan: data['selectedEmiPlan'],
                                  pre_booktype: data['preBooktype'],
                                  preBookDetail: data['preBookDetail']
                              )
                          ));
                        },
                        child: Container(height: 50,decoration: BoxDecoration(
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
      margin: EdgeInsets.all(2),
      decoration: BoxDecoration(
          color: AppColors.grey300,
          borderRadius: BorderRadius.all(Radius.circular(8))
      ),
      child: Center(child: Text(text)),
    );
  }
}


