import 'dart:io';
import 'package:exampur_mobile/Localization/language_constrants.dart';
import 'package:exampur_mobile/data/model/demo_model.dart';


import 'package:exampur_mobile/presentation/theme/custom_text_style.dart';
import 'package:exampur_mobile/provider/Demoprovider.dart';
import 'package:exampur_mobile/shared/tile_row.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:exampur_mobile/utils/dimensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Demo_container.dart';

class Demo extends StatefulWidget {

  @override
  DemoState createState() => DemoState();
}

class DemoState extends State<Demo> {
   List<Datum> demoList= [];
   bool isLoading = false;
   bool isBottomLoading = false;
   int page =0;
   var scrollController =ScrollController();
   bool isData =true;

   @override
  void initState() {
    super.initState();
    scrollController.addListener(pagination);
     getDemoList();
  }

  Future<void> getDemoList() async {
   // AppConstants.printLog(demoList);
    isLoading=true;
    List<Datum> list= (await Provider.of<DemoProvider>(context, listen: false).getdemosList(context,))!;
    if(list.length > 0) {
    isData = true;
    demoList = demoList + list;
  } else {
   isData = false;
   }
   isLoading = false;
    isBottomLoading=false;
   setState(() {});
    // return one2oneList;

  }

   void pagination(){
     if(scrollController.position.pixels==scrollController.position.maxScrollExtent){
       setState(() {
         if(isData){
           page +=1;
           AppConstants.printLog(page.toString());
         }
      isBottomLoading = true;
         getDemoList();
       });
     }
   }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(
            getTranslated(context, StringConstant.demo_classes)!,
              style: CustomTextStyle.headingBigBold(context),
            ),
            backgroundColor: AppColors.transparent,
            elevation: 0),
        body:isLoading?Center(child: CircularProgressIndicator(color: AppColors.amber,)) :demoList.length==0?
        AppConstants.noDataFound():
        Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // VideoCardAT(),
                SizedBox(height: Dimensions.FONT_SIZE_SMALL,),
                // Padding(
                //   padding: const EdgeInsets.only(left: 10),
                //   child: TitleRow(title: getTranslated(context, StringConstant.recorded)!, onTap: () {  },  ),
                // ),
               Expanded(
                 child: ListView.builder(
                   shrinkWrap: true,
                   controller: scrollController,
                   itemCount: demoList.length,
                     itemBuilder: (BuildContext context, index){
                   return DemoContainer(demoList,index);
                 }),
               )

              ],
            )),
        bottomNavigationBar: isBottomLoading?Container(height:40,width: 40,child:Center(child: CircularProgressIndicator(color: AppColors.amber,),)):SizedBox()
    );
  }
}
