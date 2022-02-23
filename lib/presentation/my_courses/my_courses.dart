import 'package:exampur_mobile/presentation/theme/custom_text_style.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:exampur_mobile/utils/images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'myCoursetabview.dart';

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
            // title: Text(
            //   "My Courses",
            //   style: CustomTextStyle.headingBold(context),
            // ),
            // backgroundColor: AppColors.transparent,
            // elevation: 0
        ),
        /*body: GroupedListView<dynamic, String>(
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
                  child: Container(
                    child: ListTile(
                      contentPadding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                      leading: Image.asset(Images.mypurchase),
                      title: Text(element['name']),
                    ),
                  ),
                ),
              );
            })*/
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text('My Courses', style: CustomTextStyle.headingBold(context)),
            DataContainer()
          ],
        ),
      ),
    );
  }

  Widget DataContainer() {
    return Column(
      children: [
        Text('Group Name'),
        GridViewData()
      ],
    );
  }

  Widget GridViewData() {
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      itemBuilder: (_, index) => GridItem(),
      itemCount: 9,
    );
  }

  Widget GridItem() {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) =>
            MyCourseTabView()
        ));
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius:  BorderRadius.all(const Radius.circular(8)), color: AppColors.black),
        child: Card(
          elevation: 8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(Images.mypurchase),
              Text('Course Name', overflow: TextOverflow.ellipsis, maxLines: 2),
            ],
          ),
        ),
      ),
    );
  }
}