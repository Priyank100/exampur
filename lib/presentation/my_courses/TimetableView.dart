
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:exampur_mobile/utils/images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TimeTableView extends StatefulWidget {
  const TimeTableView({Key? key}) : super(key: key);

  @override
  _TimeTableViewState createState() => _TimeTableViewState();
}

class _TimeTableViewState extends State<TimeTableView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body:  ListView.builder(itemCount: 5,
        
        itemBuilder: (BuildContext context,int index){
        return Container(
          padding: EdgeInsets.all(8),
            color: index % 2 == 0
                ? Theme.of(context).backgroundColor
                : AppColors.transparent,
       child:   Row(
         mainAxisAlignment:MainAxisAlignment.start,children: [
            Image.asset(Images.free_course,height: 120,width: 100,),
         SizedBox(width: 9,),
         Flexible(
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
             Text('Part-6 | Tense |21 Feb-2021| English |By Vikas Singh'),
               SizedBox(height: 6,),
               Container(decoration: BoxDecoration(
                   border: Border.all(color: AppColors.red)
               ),height: 25,width: 200,child: Center(child: Text('Live at: 21-02-2022 at 06:00pm',style: TextStyle(color: AppColors.red,fontSize: 10),)),)
             ],
           ),
         )
          ],)
        );
        })
    );
  }
}
