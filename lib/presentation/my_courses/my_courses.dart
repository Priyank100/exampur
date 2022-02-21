import 'dart:io';
import 'package:exampur_mobile/presentation/theme/custom_text_style.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:exampur_mobile/utils/images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';

import 'myCoursetabview.dart';
List _elements = [
  {'name': 'Aa', 'group': 'Group 1'},
  {'name': 'Bb', 'group': 'Group 2'},
  {'name': 'Cc', 'group': 'Group 1'},
  {'name': 'Dd', 'group': 'Group 2'},
  {'name': 'Ee', 'group': 'Group 3'},
  {'name': 'Ff', 'group': 'Group 3'},
  {'name': 'Ff', 'group': 'Group 3'},
];

class MyCourses extends StatefulWidget {
  @override
  MyCoursesState createState() => MyCoursesState();
}

class MyCoursesState extends State<MyCourses> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(
              "My Courses",
              style: CustomTextStyle.headingBold(context),
            ),
            backgroundColor: AppColors.transparent,
            elevation: 0),
        body: GroupedListView<dynamic, String>(
    elements: _elements,
    groupBy: (element) => element['group'],
    groupComparator: (value1, value2) => value2.compareTo(value1),
    itemComparator: (item1, item2) =>
    item1['name'].compareTo(item2['name']),
    order: GroupedListOrder.DESC,
    useStickyGroupSeparators: true,
    groupSeparatorBuilder: (String value) => Padding(
    padding: const EdgeInsets.all(8.0),
    child: Text(
    value,
    textAlign: TextAlign.center,
    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    ),
    ),
    itemBuilder: (c, element) {
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (_) =>
            MyCourseTabView()
        ));
      },
      child: Card(
      elevation: 8.0,
     // margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        // height: 70,
        // child: Row(children: [
        //   Image.asset(Images.mypurchase),
        //   SizedBox(width: 5,),
        //   Text(element['name'])
        // ],),
      child: ListTile(
      contentPadding:
      EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      leading: Image.asset(Images.mypurchase),
      title: Text(element['name']),
      ),
      ),
      ),
    );}));
  }
}