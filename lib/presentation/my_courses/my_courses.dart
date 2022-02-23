import 'package:exampur_mobile/SharePref/shared_pref.dart';
import 'package:exampur_mobile/data/model/my_course_list_model.dart';
import 'package:exampur_mobile/presentation/theme/custom_text_style.dart';
import 'package:exampur_mobile/provider/MyCourseProvider.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:exampur_mobile/utils/images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'myCoursetabview.dart';

class MyCourses extends StatefulWidget {
  @override
  MyCoursesState createState() => MyCoursesState();
}

class MyCoursesState extends State<MyCourses> {
  List<Data> myCourseList = [];
  bool isLoading = false;

  @override
  void initState() {
    callProvider();
    super.initState();
  }

  Future<void> callProvider() async {
    isLoading = true;
    String token = await SharedPref.getSharedPref(SharedPrefConstants.TOKEN);
    myCourseList = (await Provider.of<MyCourseProvider>(context, listen: false).getMyCourseList(context, token))!;
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading ? Center(child: CircularProgressIndicator()) : myCourseList.length == 0 ?
      Center(child: Text('No Data')) :
        SingleChildScrollView(
        padding: EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text('Group Name'),
        GridViewData()
      ],
    );
  }

  Widget GridViewData() {
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: MediaQuery.of(context).size.width /
              (MediaQuery.of(context).size.height / 2.5)
      ),
      itemBuilder: (_, index) => GridItem(index),
      itemCount: myCourseList.length,
    );
  }

  Widget GridItem(index) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) =>
            MyCourseTabView(myCourseList[index].id.toString())
        ));
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(width: 1.5),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppConstants.image(AppConstants.BANNER_BASE + myCourseList[index].logoPath.toString()),
            SizedBox(height: 20),
            Text(myCourseList[index].title.toString(), overflow: TextOverflow.ellipsis, maxLines: 2),
          ],
        )
      ),
    );
  }
}