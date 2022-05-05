import 'package:exampur_mobile/Localization/language_constrants.dart';
import 'package:exampur_mobile/SharePref/shared_pref.dart';
import 'package:exampur_mobile/data/model/my_course_list_model.dart';
import 'package:exampur_mobile/presentation/theme/custom_text_style.dart';
import 'package:exampur_mobile/presentation/widgets/loading_indicator.dart';
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
  List<CourseData> myCourseList = [];
  bool isLoading = false;
  var groupedLists = {};
  var myFilterList = {};

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
    grouping();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(getTranslated(context, StringConstant.myCourses)!, style: CustomTextStyle.headingBold(context)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 5),
              child: Container(
                height: 30,
                decoration: BoxDecoration(
                  color: AppColors.grey200,
                  border: Border.all(color: AppColors.grey, width: 1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextField(
                  autocorrect: false,
                  onChanged: (s) {
                    myFilterList.clear();
                    List<CourseData> searchResults = myCourseList.where((CourseData item)=>item.title.toString().toLowerCase().contains(s.toLowerCase())).toList();

                    searchResults.forEach((course) {
                      course.category!.forEach((category) {
                        if (myFilterList['${category.name}'] == null) {
                          myFilterList['${category.name}'] = <CourseData>[];
                        }
                        (myFilterList['${category.name}'] as List<CourseData>).add(course);
                      });
                    });
                    setState(() {});
                  },
                  onEditingComplete: () {
                    FocusScope.of(context).nextFocus();
                  },
                  cursorColor: AppColors.amber,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search,size: 20,color: AppColors.grey400),
                    hintText: getTranslated(context,StringConstant.searchCourse),
                    hintStyle: TextStyle(fontSize: 13,
                      color: AppColors.grey400,
                    ),
                    isDense: true,
                    counterText: '',
                    errorStyle: TextStyle(height: 1.5),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            isLoading ? Center(child: LoadingIndicator(context)) : myFilterList.length == 0 ?
            AppConstants.noDataFound() : DataContainer()
          ],
        ),
      ),
    );
  }

  Widget DataContainer() {
    return ListView.builder(
      // itemCount: groupedLists.length,
      itemCount: myFilterList.length,
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        itemBuilder:(context, index) {
          // String key = groupedLists.keys.elementAt(index);
          String key = myFilterList.keys.elementAt(index);
          // var value = groupedLists.values.elementAt(index);
          var value = myFilterList.values.elementAt(index);
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: Text(key, style: TextStyle(fontSize: 16))),
              GridViewData(value)
        ],
      );
    });
    // return Column(
    //   crossAxisAlignment: CrossAxisAlignment.start,
    //   children: [
    //     Text('Group Name'),
    //     GridViewData()
    //   ],
    // );

  }

  Widget GridViewData(var val) {
    // return GridView.builder(
    //   physics: NeverScrollableScrollPhysics(),
    //   shrinkWrap: true,
    //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    //       crossAxisCount: 2,
    //       childAspectRatio: MediaQuery.of(context).size.width /
    //           (MediaQuery.of(context).size.height / 2.5)
    //   ),
    //   itemBuilder: (_, index) => GridItem(index),
    //   itemCount: myCourseList.length,
    // );
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: MediaQuery.of(context).size.width /
              (MediaQuery.of(context).size.height / 2.5)
      ),
      itemCount: val.length,
      itemBuilder: (_, index) {
        var courseData = val[index];
        return GridItem(courseData);
      },
    );
  }

  /*Widget GridItem(index) {
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
        margin: EdgeInsets.all(8),
        padding: EdgeInsets.all(3),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                height:70,width:MediaQuery.of(context).size.width,child:
            //Image.asset(Images.exampur_logo,fit: BoxFit.fill)
           AppConstants.image(AppConstants.BANNER_BASE + myCourseList[index].bannerPath.toString(),boxfit: BoxFit.fill)
            ),
            SizedBox(height: 10),
            Flexible(child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(myCourseList[index].title.toString(),style: TextStyle(fontSize: 12
              ), overflow: TextOverflow.ellipsis,maxLines: 3,),
            )),
          ],
        )
      ),
    );
  }*/

  Widget GridItem(courseData) {
    return InkWell(
      onTap: () {
        Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(builder: (_) =>
            MyCourseTabView(courseData.id.toString())
        ));
      },
      child: Container(
          decoration: BoxDecoration(
              border: Border.all(width: 1.5),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          margin: EdgeInsets.all(8),
          padding: EdgeInsets.all(3),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  height:70,width:MediaQuery.of(context).size.width,
              child:
              //Image.asset(Images.exampur_logo,fit: BoxFit.fill)
              courseData.bannerPath.toString().contains('http') ?
              AppConstants.image(courseData.bannerPath.toString(),boxfit: BoxFit.fill) :
              AppConstants.image(AppConstants.BANNER_BASE + courseData.bannerPath.toString(),boxfit: BoxFit.fill)
              ),
              SizedBox(height: 10),
              Flexible(child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(courseData.title.toString(),style: TextStyle(fontSize: 12
                ), overflow: TextOverflow.ellipsis,maxLines: 3,),
              )),
            ],
          )
      ),
    );
  }

  void grouping() {
    myCourseList.forEach((course) {
      course.category!.forEach((category) {
        if (groupedLists['${category.name}'] == null) {
          groupedLists['${category.name}'] = <CourseData>[];
        }
        (groupedLists['${category.name}'] as List<CourseData>).add(course);
      });
    });
    myFilterList = groupedLists;
  }
}