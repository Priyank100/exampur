import 'dart:collection';

import 'package:exampur_mobile/Localization/language_constrants.dart';
import 'package:exampur_mobile/SharePref/shared_pref.dart';
import 'package:exampur_mobile/data/model/my_course_list_model.dart';
import 'package:exampur_mobile/presentation/theme/custom_text_style.dart';
import 'package:exampur_mobile/presentation/widgets/loading_indicator.dart';
import 'package:exampur_mobile/provider/MyCourseProvider.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:exampur_mobile/utils/images.dart';
import 'package:exampur_mobile/utils/refreshwidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'myCoursetabview.dart';

class MyCourses extends StatefulWidget {
  @override
  MyCoursesState createState() => MyCoursesState();
}

class MyCoursesState extends State<MyCourses> {
  List<CourseData> allCourseList = [];
  List<CourseData> myCourseList = [];
  bool isLoading = false;
  // var groupedLists = {};
  final keyRefresh = GlobalKey<RefreshIndicatorState>();

  TextEditingController _controller = TextEditingController();
  List<String> allCategoryNameList = [];
  String dropdownValue = 'Select Category';

  @override
  void initState() {
    callProvider();
    super.initState();
  }

  Future<void> callProvider() async {
    isLoading = true;
    String token = await SharedPref.getSharedPref(SharedPrefConstants.TOKEN);
    allCourseList = (await Provider.of<MyCourseProvider>(context, listen: false).getMyCourseList(context, token))!;
    myCourseList = allCourseList;
    getAllCategoryNameList();
    isLoading = false;
    // grouping();
    setState(() {});
  }
  Future<void>_refreshScreen() async{
    myCourseList.clear();
    return callProvider();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshWidget(
        keyRefresh: keyRefresh,
        onRefresh:_refreshScreen,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(getTranslated(context, StringConstant.myCourses)!,
                      style: CustomTextStyle.headingBold(context)),
                  myCourseList.length == 0 ? SizedBox() : CategoryDropDownButton()
                ],
              ),
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
                    controller: _controller,
                    autocorrect: false,
                    onChanged: (s) {
                      dropdownValue = 'Select Category';
                      myCourseList = allCourseList.where((CourseData item)=>item.title.toString().toLowerCase().contains(s.toLowerCase())).toList();
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
              isLoading
                  ? Center(child: LoadingIndicator(context))
                  : myCourseList.length == 0
                      ? AppConstants.noDataFound()
                      : DataContainer()
            ],
          ),
        ),
      ),
    );
  }

  Widget DataContainer() {
    return ListView.builder(
        itemCount: myCourseList.length,
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return ListItem(index);
        });
  }

  Widget ListItem(index) {
    return Container(
      padding: const EdgeInsets.all(5),
      margin: EdgeInsets.all(2),
      decoration: BoxDecoration(
          border: Border.all(width: 1.5),
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: InkWell(
        onTap: () {
          FocusScope.of(context).unfocus();
          Navigator.of(context, rootNavigator: true).push(
              MaterialPageRoute(
                  builder: (_) =>
                      MyCourseTabView(myCourseList[index].id.toString())));
        },
        child: Row(
          children: [
            Container(
                height: 80,
                width: MediaQuery.of(context).size.width/2.5,
                child:
                myCourseList[index].bannerPath.toString().contains('http')
                    ? AppConstants.image(
                    myCourseList[index].bannerPath.toString(),
                    boxfit: BoxFit.fill)
                    : AppConstants.image(
                    AppConstants.BANNER_BASE +
                        myCourseList[index].bannerPath.toString(),
                    boxfit: BoxFit.fill)),
            SizedBox(width: 5),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(myCourseList[index].title.toString()),
                  Text('Categories : ' + CategoryNameList(myCourseList[index].category), style: TextStyle(fontSize: 12))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  /*Widget DataContainer() {
    return GridView.builder(
        itemCount: myCourseList.length,
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          // String key = myFilterList.keys.elementAt(index);
          // var value = myFilterList.values.elementAt(index);
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Center(child: Text(key, style: TextStyle(fontSize: 16))),
              // GridViewData(value)
              Text('Group Name'),
              GridViewData()
            ],
          );
        });
  }*/

  /*Widget GridViewData() {
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: MediaQuery.of(context).size.width /
              (MediaQuery.of(context).size.height / 2.5)),
      itemBuilder: (_, index) => GridItem(index),
      itemCount: myCourseList.length,
    );
    // return GridView.builder(
    //   physics: NeverScrollableScrollPhysics(),
    //   shrinkWrap: true,
    //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    //       crossAxisCount: 2,
    //       childAspectRatio: MediaQuery.of(context).size.width /
    //           (MediaQuery.of(context).size.height / 2.5)
    //   ),
    //   itemCount: val.length,
    //   itemBuilder: (_, index) {
    //     var courseData = val[index];
    //     return GridItem(courseData);
    //   },
    // );
  }*/

  /*Widget GridItem(index) {
    return InkWell(
      onTap: () {
        Navigator.of(context, rootNavigator: true).push(
            MaterialPageRoute(
                builder: (_) =>
                    MyCourseTabView(myCourseList[index].id.toString())));
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
                  height: 70,
                  width: MediaQuery.of(context).size.width,
                  child:
                      myCourseList[index].bannerPath.toString().contains('http')
                          ? AppConstants.image(
                              myCourseList[index].bannerPath.toString(),
                              boxfit: BoxFit.fill)
                          : AppConstants.image(
                              AppConstants.BANNER_BASE +
                                  myCourseList[index].bannerPath.toString(),
                              boxfit: BoxFit.fill)),
              SizedBox(height: 10),
              Flexible(
                  child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  myCourseList[index].title.toString(),
                  style: TextStyle(fontSize: 12),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                ),
              )),
            ],
          )),
    );
  }*/

//use for grouping
/*Widget GridItem(courseData) {
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
  }*/

//grouping
/*void grouping() {
    myCourseList.forEach((course) {
      course.category!.forEach((category) {
        if (groupedLists['${category.name}'] == null) {
          groupedLists['${category.name}'] = <CourseData>[];
        }
        (groupedLists['${category.name}'] as List<CourseData>).add(course);
      });
    });
    myFilterList = groupedLists;
  }*/

  Widget CategoryDropDownButton() {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: Icon(Icons.arrow_drop_down),
      iconSize: 24,
      elevation: 16,
      style: TextStyle(color: AppColors.black, fontSize: 16),
      underline: Container(
        height: 1,
        color: AppColors.amber,
      ),
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      onChanged: (data) {
        setState(() {
          _controller.text = '';
          dropdownValue = data.toString();
          if(dropdownValue == allCategoryNameList[0]) {
            myCourseList = allCourseList;
          } else {
            myCourseList = allCourseList
                .where((m) => m.category!
                .where((s) =>
                s.name!.toLowerCase().contains(dropdownValue.toLowerCase()))
                .isNotEmpty)
                .toList();
          }
        });
      },
      items: allCategoryNameList.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  String CategoryNameList(list) {
    List<String> catNameList = [];
    for(int i=0; i<list.length; i++) {
      catNameList.add(list[i].name.toString());
    }
    return catNameList.toString().replaceAll('[', '').replaceAll(']', '');
  }

  void getAllCategoryNameList() {
    if(allCourseList.length > 0) {
      for (int i = 0; i < allCourseList.length; i++) {
        for (int j = 0; j < allCourseList[i].category!.length; j++) {
          allCategoryNameList.add(allCourseList[i].category![j].name.toString());
        }
      }
      allCategoryNameList.insert(0, 'Select Category');
      allCategoryNameList = LinkedHashSet<String>.from(allCategoryNameList).toList();
      AppConstants.printLog(allCategoryNameList.toString());
    }
  }

}
