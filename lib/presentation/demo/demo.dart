import 'dart:io';
import 'package:exampur_mobile/data/model/demo_models.dart';
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
   List<Courses> demoList= [];
  @override
  void initState() {
    super.initState();
    getDemoList();
  }

  Future<void> getDemoList() async {
    AppConstants.printLog(demoList);
    demoList= (await Provider.of<DemoProvider>(context, listen: false).getdemosList(context))!;
    setState(() {});
    // return one2oneList;

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(
              "Demo Classes",
              style: CustomTextStyle.headingBigBold(context),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0),
        body:demoList.length==0?Center(child: CircularProgressIndicator(color: Colors.amber,)) :Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // VideoCardAT(),
                SizedBox(height: Dimensions.FONT_SIZE_SMALL,),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: TitleRow(title: 'Recorded', onTap: () {  },  ),
                ),
               Expanded(
                 child: ListView.builder(
                   shrinkWrap: true,
                   itemCount: demoList.length,
                     itemBuilder: (BuildContext context, index){
                   return DemoContainer(demoList,index);
                 }),
               )

              ],
            )));
  }
}
