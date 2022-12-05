import 'dart:convert';
import 'package:exampur_mobile/SharePref/shared_pref.dart';
import 'package:exampur_mobile/data/datasource/remote/http/services.dart';
import 'package:exampur_mobile/data/model/ChooseCategoryModel.dart';

import 'package:exampur_mobile/presentation/theme/custom_text_style.dart';
import 'package:exampur_mobile/provider/Authprovider.dart';
import 'package:exampur_mobile/provider/ChooseCategory_provider.dart';
import 'package:exampur_mobile/utils/api.dart';
import 'package:exampur_mobile/utils/appBar.dart';
import 'package:exampur_mobile/utils/lang_string.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:exampur_mobile/utils/app_colors.dart';
import 'package:exampur_mobile/utils/dimensions.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'bottom_navigation.dart';

class LandingChooseCategory extends StatefulWidget {

  const LandingChooseCategory();

  @override
  _LandingChooseCategoryState createState() => _LandingChooseCategoryState();
}

class _LandingChooseCategoryState extends State<LandingChooseCategory> {

  List<Data> chooseList = [];
  List<String> selectedCategoryIdList = [];
  bool isLoading = false;
  List<Data> myList = [];


  @override
  initState() {
    callProvider();
    super.initState();
  }

  Future<void> callProvider() async {
    isLoading = true;
    await Provider.of<AuthProvider>(context, listen: false).getBannerBaseUrl(context);
    chooseList = (await Provider.of<ChooseCategoryProvider>(context, listen: false).getAllCategoryList(context))!;
    myList = chooseList;
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(),
        body: isLoading ? Center(
            child: CircularProgressIndicator(
              color: Colors.amber,
            )
        ) :
        SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: Dimensions.FONT_SIZE_SMALL,
                            bottom: Dimensions.FONT_SIZE_SMALL),
                        child: Text(
                          'Select Categories',
                          style: CustomTextStyle.headingBigBold(context),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 0),
                        child: Container(
                          width: 300,
                          decoration: BoxDecoration(
                              color: AppColors.grey200,
                            border: Border.all(color: AppColors.grey, width: 1),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: TextField(
                            autocorrect: false,
                            onChanged: (s) {
                              List<Data> searchResults = chooseList.where((Data item)=>item.name.toString().toLowerCase().contains(s.toLowerCase())).toList();
                              myList = searchResults;
                              setState(() {});
                            },
                            onEditingComplete: () {
                              FocusScope.of(context).nextFocus();
                            },

                            cursorColor: AppColors.amber,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.search,size: 25,color: AppColors.grey400),
                              hintText: 'Search Category',
                              hintStyle: TextStyle(
                                color: AppColors.grey400,
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 13.0, horizontal: 10),
                              isDense: true,
                              counterText: '',
                              errorStyle: TextStyle(height: 1.5),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 15,),

                      myList.length == 0 ? Center(
                          child: AppConstants.noDataFound()
                      ):
                      Expanded(
                        child: CustomScrollView(slivers: [
                          SliverGrid(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                final isSelected = myList[index].isSelected;
                                return Padding(
                                    padding: const EdgeInsets.all(0),
                                    child: InkWell(
                                      onTap: () {
                                        setState(()  {
                                          myList[index].isSelected = !myList[index].isSelected;

                                          if (myList[index].isSelected == true) {
                                            selectedCategoryIdList.add(myList[index].id.toString());

                                          } else if (myList[index].isSelected == false) {
                                            selectedCategoryIdList.removeWhere((element) => element.toString() == myList[index].id);
                                          }
                                        });
                                      },
                                      child: Container(

                                        padding: EdgeInsets.all(8),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Flexible(
                                                  child: Text(
                                                    myList[index]
                                                        .name
                                                        .toString(),
                                                    overflow: TextOverflow.ellipsis,
                                                    maxLines: 2,
                                                    style: TextStyle(
                                                      fontSize: 14.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: AppColors.black,
                                                    ),
                                                  ),
                                                ),
                                                CircleAvatar(
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  backgroundImage:
                                                  myList[index].logoPath.toString().contains('http') ?
                                                      new NetworkImage(myList[index].logoPath.toString()) :
                                                      new NetworkImage(AppConstants.BANNER_BASE + myList[index].logoPath.toString()),
                                                  radius: 20.0,
                                                ),
                                              ],
                                            ),
                                            Flexible(
                                              child: Text(
                                                myList[index]
                                                    .description
                                                    .toString(),overflow: TextOverflow.ellipsis,maxLines: 1,
                                                style: TextStyle(
                                                  fontSize: 12.0,
                                                  color: AppColors.grey600,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        decoration: BoxDecoration(
                                          border:
                                          myList[index].isSelected
                                              ? Border.all(
                                                  color: Colors.amber,
                                                  width: 3,
                                                )
                                              :Border.all(
                                            color: Colors.white,
                                            width: 3,
                                          ) ,
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                              AppColors.grey.withOpacity(0.2),
                                              spreadRadius: 0.95,
                                              blurRadius: 0.100,
                                              offset: Offset(0,
                                                  0), // changes position of shadow
                                            ),
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: Colors.white,
                                        ),
                                      ),
                                    ));
                              },
                              childCount: myList.length,
                            ),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 5,
                              crossAxisSpacing: 5,
                              childAspectRatio: 2.0,
                            ),
                          ),
                        ]),
                      ),

                      myList.length == 0 ? SizedBox() :
                      Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 25,
                                vertical: 10,
                              ),
                              // child: SizedBox(
                              //   width: double.infinity,
                              child: InkWell(
                                onTap: () async{
                                  await FirebaseAnalytics.instance.logEvent(name: 'EXAM_SELECTED',parameters: {
                                    'exam_categories': selectedCategoryIdList.toString()
                                  });

                                  // SharedPref.saveSharedPref(SharedPref.CATEGORY_LENGTH, selectedCountries.length.toString());

                                  AppConstants.printLog(selectedCategoryIdList.length.toString());
                                  if(selectedCategoryIdList.length > 0){
                                    UpdateChoosecategory(selectedCategoryIdList);

                                  } else {
                                    // AppConstants.printLog('test');
                                    var snackBar = SnackBar(content: Text('Please Choose the Category'),backgroundColor: AppColors.grey,);
                                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                  }

                                  // UpdateChoosecategory(selectedCountries.length);
                                  // Navigator.pushReplacement(context,
                                  //     MaterialPageRoute(builder:
                                  //         (context) =>
                                  //             BottomNavigation()
                                  //     )
                                  // );
                                },
                                child: Container(
                                  height: 50,
                                  width: double.infinity,
                                  decoration: const BoxDecoration(
                                    color: Colors.amber,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5.0) //
                                            ),
                                  ),
                                  child: Center(
                                      child: Text(
                                   // "Save (${selectedCountries.length})",
                                        "Save the course",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  )),
                                ),
                              ),
                            )
                    ],
                  ),
                ),
              )
    );
  }

  UpdateChoosecategory(List? categories) async {
    // Map<String, dynamic> args = {"categories": categories};
    // var body = {"categories": [
    //   "61cad845da1d8532b6f33fd1", "61d2cc701cea2fdab6e9cb06"
    // ]};
    var body = {"categories": categories};
    await Service.post(
      API.Update_Choose_category_URL,
      body: body,
    ).then((response) async {
      AppConstants.printLog(response.body.toString());
      if (response == null) {
        var snackBar = SnackBar( margin: EdgeInsets.all(20),
          behavior: SnackBarBehavior.floating,
          content: Text('Server Error'),backgroundColor: Colors.red,);
        ScaffoldMessenger.of(context).showSnackBar(snackBar);

            } else if (response.statusCode == 200) {
        AppConstants.printLog(response.body.toString());

        for(int i=0; i<myList.length; i++) {
          if(myList[i].isSelected == true) {
            AppConstants.subscription(myList[i].id.toString());
          } else {
            AppConstants.unSubscription(myList[i].id.toString());
          }
        }

        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BottomNavigation()));

      } else if(response.statusCode == 429) {
        await Service.post(
          API.Update_Choose_category_URL_2,
          body: body,
        ).then((response) async {
          AppConstants.printLog(response.body.toString());
          if (response == null) {
            var snackBar = SnackBar( margin: EdgeInsets.all(20),
              behavior: SnackBarBehavior.floating,
              content: Text('Server Error'),backgroundColor: Colors.red,);
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          } else if (response.statusCode == 200) {
            AppConstants.printLog(response.body.toString());
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder:
                    (context) =>
                    BottomNavigation()
                )
            );
          } else {
            AppConstants.printLog("init address fail");
            final body = json.decode(response.body);
            var snackBar = SnackBar( margin: EdgeInsets.all(20),
              behavior: SnackBarBehavior.floating,
              content: Text(body['data'].toString()),backgroundColor: Colors.red,);
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        });
      } else {
        AppConstants.printLog("init address fail");
       final body = json.decode(response.body);
        var snackBar = SnackBar( margin: EdgeInsets.all(20),
          behavior: SnackBarBehavior.floating,
          content: Text(body['data'].toString()),backgroundColor: Colors.red,);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    });
  }
}

class MyClip extends CustomClipper<Rect> {
  Rect getClip(Size size) {
    return Rect.fromLTWH(0, 0, 10, 10);
  }

  bool shouldReclip(oldClipper) {
    return false;
  }
}


