import 'dart:convert';

import 'package:exampur_mobile/SharePref/shared_pref.dart';
import 'package:exampur_mobile/data/datasource/remote/http/services.dart';
import 'package:exampur_mobile/data/model/ChooseCategoryModel.dart';

import 'package:exampur_mobile/presentation/theme/custom_text_style.dart';

import 'package:exampur_mobile/provider/ChooseCategory_provider.dart';

import 'package:exampur_mobile/utils/appBar.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:exampur_mobile/utils/dimensions.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'bottom_navigation.dart';

class LandingChooseCategory extends StatefulWidget {
  final bool isMultiSelection;

  const LandingChooseCategory({
    this.isMultiSelection = false,
  });

  @override
  _LandingChooseCategoryState createState() => _LandingChooseCategoryState();
}

class _LandingChooseCategoryState extends State<LandingChooseCategory> {

  List<Data> chooseList = [];
  List<String> selectedCountries = [];

  // late final List<Category> selectedList;
  // late final bool isSelected;
//  List<String> selectedList = [];
  @override
  initState() {
    callProvider();
    super.initState();
    //selectedCountries = chooseList;
  }

  Future<void> callProvider() async {
    chooseList =
        (await Provider.of<ChooseCategoryProvider>(context, listen: false)
            .getchooseCategoryList(context))!;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: CustomAppBar(),
        body: chooseList.length != 0
            ? SafeArea(
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
                              color: Colors.grey[200],
                            border: Border.all(color: Colors.grey, width: 1),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: TextField(
                            autocorrect: false,
                            onChanged: (s) {},
                            onEditingComplete: () {
                              FocusScope.of(context).nextFocus();
                            },

                            cursorColor: Colors.amber,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.search,size: 25,color: Colors.grey.shade400),
                              hintText: 'Search Category',
                              hintStyle: TextStyle(
                                color: Colors.grey[400],
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
                      Expanded(
                        child: CustomScrollView(slivers: [
                          SliverGrid(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                final isSelected = chooseList[index].isSelected;
                                return Padding(
                                    padding: const EdgeInsets.all(0),
                                    child: InkWell(
                                      onTap: () {
                                        // chooseList[index].isSelected = !chooseList[index].isSelected;
                                        // setState(() {});
                                        setState(() {
                                          chooseList[index].isSelected =
                                              !chooseList[index].isSelected;
                                          if (chooseList[index].isSelected ==
                                              true) {
                                            selectedCountries.add(
                                                chooseList[index]
                                                    .id
                                                    .toString());
                                          } else if (chooseList[index]
                                                  .isSelected ==
                                              false) {
                                            selectedCountries.removeWhere(
                                                (element) =>
                                                    element.toString() ==
                                                    chooseList[index].id);
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
                                                    chooseList[index]
                                                        .name
                                                        .toString(),
                                                    style: TextStyle(
                                                      fontSize: 17.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ),
                                                CircleAvatar(
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  backgroundImage:
                                                      new NetworkImage(
                                                          chooseList[index]
                                                              .logoPath
                                                              .toString()),
                                                  radius: 20.0,
                                                ),
                                                // ClipOval(
                                                //   clipper: MyClip(),
                                                //   child: FadeInImage.assetNetwork(
                                                //     placeholder: Images.noimage,
                                                //     image: chooseList[index]
                                                //         .logoPath
                                                //         .toString(),
                                                //     fit: BoxFit.fill,
                                                //   ),
                                                // ),
                                              ],
                                            ),
                                            Flexible(
                                              child: Text(
                                                chooseList[index]
                                                    .description
                                                    .toString(),
                                                style: TextStyle(
                                                  fontSize: 12.0,
                                                  color: Colors.grey.shade600,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),

                                        //height: 100.0,
                                        decoration: BoxDecoration(
                                          border: chooseList[index].isSelected
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
                                                  Colors.grey.withOpacity(0.2),
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
                              childCount: chooseList.length,
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
                      // selectedCountries.length > 0
                      //     ?
                      Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 25,
                                vertical: 10,
                              ),
                              // child: SizedBox(
                              //   width: double.infinity,
                              child: InkWell(
                                onTap: () {
                                  SharedPref.saveSharedPref(
                                      AppConstants.SELECT_CATEGORY_LENGTH,
                                      selectedCountries.length.toString());
                                  // AppConstants.printLog(
                                  //     selectedCountries.length.toString());
                                  AppConstants.printLog(selectedCountries.length.toString());
                                  if(selectedCountries.length >0){
                                    UpdateChoosecategory(selectedCountries);

                                  }
                                  else {
                                    AppConstants.printLog('test');
                                    var snackBar = SnackBar(content: Text('Please Choose the Category'),backgroundColor: Colors.grey,);
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
                          // : Container(
                          //     height: 50,
                          //     width: double.infinity,
                          //     margin: EdgeInsets.all(10),
                          //     decoration: const BoxDecoration(
                          //       color: Colors.amber,
                          //       //border: Border.all( color: Colors.amber,),
                          //       borderRadius:
                          //           BorderRadius.all(Radius.circular(5.0) //
                          //               ),
                          //     ),
                          //     child: Center(
                          //         child: Text(
                          //       "Save the course",
                          //       style: TextStyle(
                          //           color: Colors.white, fontSize: 20),
                          //     )),
                          //   ),
                    ],
                  ),
                ),
              )
            : Center(
                child: CircularProgressIndicator(
                color: Colors.amber,
              )));
  }

  UpdateChoosecategory(List? categories) async {
    // Map<String, dynamic> args = {"categories": categories};
    // var body = {"categories": [
    //   "61cad845da1d8532b6f33fd1", "61d2cc701cea2fdab6e9cb06"
    // ]};
    var body = {"categories": categories};
    await Service.post(
      AppConstants.Update_Choose_category_URL,
      body: body,
    ).then((response) async {
      print(response.body.toString());
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
