import 'dart:convert';
import 'package:exampur_mobile/Localization/language_constrants.dart';
import 'package:exampur_mobile/SharePref/shared_pref.dart';
import 'package:exampur_mobile/data/datasource/remote/http/services.dart';
import 'package:exampur_mobile/data/model/ChooseCategoryModel.dart';
import 'package:exampur_mobile/presentation/theme/custom_text_style.dart';
import 'package:exampur_mobile/provider/ChooseCategory_provider.dart';
import 'package:exampur_mobile/utils/api.dart';
import 'package:exampur_mobile/utils/appBar.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:exampur_mobile/utils/dimensions.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChooseCategoryScreen extends StatefulWidget {
  final List<Data> allCategoryList;
  const ChooseCategoryScreen(this.allCategoryList) : super();

  @override
  _ChooseCategoryScreenState createState() => _ChooseCategoryScreenState();
}

class _ChooseCategoryScreenState extends State<ChooseCategoryScreen> {
  // List<Data> allCategoryList = [];
  //List<String> getSelectList = [];
  List<String> selectedCountries = [];

  // late final List<Category> selectedList;
  // late final bool isSelected;
//  List<String> selectedList = [];

  List<Data> myList = [];

  @override
  initState() {
    callProvider();
    super.initState();
    //selectedCountries = allCategoryList;
  }

  Future<void> callProvider() async {
    //allCategoryList = (await Provider.of<ChooseCategoryProvider>(context, listen: false).getAllCategoryList(context))!;
    myList = widget.allCategoryList;

    for(int i=0; i < AppConstants.selectedCategoryList.length; i++) {
      for(int j=0; j<myList.length; j++) {
        if(AppConstants.selectedCategoryList[i] == myList[j].id) {
          myList[j].isSelected = true;
          selectedCountries.add(myList[j].id.toString());
        }
      }
    }

    setState(() {});
  }
  void subscription(String topic) async {
    await FirebaseMessaging.instance.subscribeToTopic(topic);
    AppConstants.printLog('>>>>>>>>>>>>>>>>>>>>>>>>>>>>'+topic);
  }
  void unsubscription(String topic) async {
    await FirebaseMessaging.instance.unsubscribeFromTopic(topic);
    AppConstants.printLog('>>>>>>>>>>>>>>>>>>>>>>>>>>>>unsubcribe'+topic);
  }
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: CustomAppBar(),
        body: SafeArea(
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
                    getTranslated(context, StringConstant.selectCategories)!,
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
                        List<Data> searchResults = widget.allCategoryList.where((Data item)=>item.name.toString().toLowerCase().contains(s.toLowerCase())).toList();
                        myList = searchResults;
                        setState(() {});
                      },
                      onEditingComplete: () {
                        FocusScope.of(context).nextFocus();
                      },

                      cursorColor: AppColors.amber,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search,size: 25,color: AppColors.grey400),
                        hintText: getTranslated(context,StringConstant.searchCategory),
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
                Expanded(
                  child: CustomScrollView(slivers: [
                    SliverGrid(
                      delegate: SliverChildBuilderDelegate(
                            (context, index) {
                          final isSelected = myList[index].isSelected;
                          return Padding(
                              padding: const EdgeInsets.all(0),
                              child: InkWell(
                                onTap: ()  {
                                  // allCategoryList[index].isSelected = !allCategoryList[index].isSelected;
                                  // setState(() {});
                                  setState(()  {
                                    myList[index].isSelected =
                                    !myList[index].isSelected;
                                    if (myList[index].isSelected == true) {
                                      selectedCountries.add(myList[index].id.toString());
                                      subscription(myList[index].id.toString());


                                    } else if (myList[index].isSelected == false) {
                                  selectedCountries.removeWhere(
                                              (element) =>
                                          element.toString() == myList[index].id,

                                  );
                                  unsubscription(myList[index].id.toString());
                                    }
                                  });
                                },
                                child: Container(

                                  padding: EdgeInsets.all(5),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
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
                                              style: TextStyle(
                                                fontSize: 12.0,
                                                fontWeight:
                                                FontWeight.bold,
                                                color: AppColors.black,
                                              ),
                                            ),
                                          ),
                                          CircleAvatar(
                                            backgroundColor:
                                            AppColors.transparent,
                                            backgroundImage:
                                            myList[index].logoPath.toString().contains('http') ?
                                            new NetworkImage(myList[index].logoPath.toString()) :
                                            new NetworkImage(AppConstants.BANNER_BASE + myList[index].logoPath.toString()),
                                            radius: 20.0,
                                          ),
                                          // ClipOval(
                                          //   clipper: MyClip(),
                                          //   child: FadeInImage.assetNetwork(
                                          //     placeholder: Images.noimage,
                                          //     image: allCategoryList[index]
                                          //         .logoPath
                                          //         .toString(),
                                          //     fit: BoxFit.fill,
                                          //   ),
                                          // ),
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

                                  //height: 100.0,
                                  decoration: BoxDecoration(
                                    border:
                                    myList[index].isSelected
                                        ? Border.all(
                                      color: AppColors.amber,
                                      width: 3,
                                    )
                                        :Border.all(
                                      color: AppColors.white,
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
                                    color: AppColors.white,
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
                // selectedCountries.length > 0
                //     ?
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 25,
                    vertical: 10,
                  ),
                  // child: SizedBox(
                  //   width: double.infinity,
                  child: !isLoading
                      ?InkWell(
                    onTap: () {

                      // SharedPref.saveSharedPref(SharedPrefConstants.CATEGORY_LENGTH, selectedCountries.length.toString());

                      AppConstants.printLog(selectedCountries.length.toString());
                      if(selectedCountries.length >0){
                        setState(() {
                          isLoading = true;
                        });
                        UpdateChoosecategory(selectedCountries);

                      }
                      else {
                        setState(() {
                          isLoading = false;
                        });
                        AppConstants.printLog('test');
                        var snackBar = SnackBar(content: Text(getTranslated(context, StringConstant.pleaseChooseTheCategory)!),backgroundColor: AppColors.grey);
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
                        color: AppColors.amber,
                        borderRadius:
                        BorderRadius.all(Radius.circular(5.0) //
                        ),
                      ),
                      child: Center(
                          child: Text(
                            // "Save (${selectedCountries.length})",
                            getTranslated(context, StringConstant.saveTheCourse)!,
                            style: TextStyle(
                                color: AppColors.white, fontSize: 20),
                          )),
                    ),
                  ) : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(AppColors.amber))),
                  ),
                )
                // : Container(
                //     height: 50,
                //     width: double.infinity,
                //     margin: EdgeInsets.all(10),
                //     decoration: const BoxDecoration(
                //       color: AppColors.amber,
                //       //border: Border.all( color: AppColors.amber,),
                //       borderRadius:
                //           BorderRadius.all(Radius.circular(5.0) //
                //               ),
                //     ),
                //     child: Center(
                //         child: Text(
                //       "Save the course",
                //       style: TextStyle(
                //           color: AppColors.white, fontSize: 20),
                //     )),
                //   ),
              ],
            ),
          ),
        ));
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
      isLoading = false;
      AppConstants.printLog(response.body.toString());
      if (response == null) {
        var snackBar = SnackBar( margin: EdgeInsets.all(20),
          behavior: SnackBarBehavior.floating,
          content: Text('Server Error'),backgroundColor: AppColors.red);
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else if (response.statusCode == 200) {
        AppConstants.printLog(response.body.toString());
        var jsonObject = jsonDecode(response.body);
        AppConstants.printLog(
            'priyank>> ' + jsonObject['statusCode'].toString());
        if (jsonObject['statusCode'].toString() == '200') {
          AppConstants.selectedCategoryList = jsonObject['data'].cast<String>();
          Navigator.pop(context);
          // setState(() {});

        } else {
          AppConstants.showBottomMessage(
              context, jsonObject['data'].toString(), AppColors.black);
        }
      } else if(response.statusCode==429) {
        await Service.post(
          API.Update_Choose_category_URL_2,
          body: body,
        ).then((response) async {
          isLoading = false;
          AppConstants.printLog(response.body.toString());
          if (response == null) {
            var snackBar = SnackBar( margin: EdgeInsets.all(20),
                behavior: SnackBarBehavior.floating,
                content: Text('Server Error'),backgroundColor: AppColors.red);
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          } else if (response.statusCode == 200) {
            AppConstants.printLog(response.body.toString());
            var jsonObject =  jsonDecode(response.body);
            AppConstants.printLog('priyank>> '+jsonObject['statusCode'].toString());
            if(jsonObject['statusCode'].toString() == '200'){
              AppConstants.selectedCategoryList = jsonObject['data'].cast<String>();
              Navigator.pop(context);
              // setState(() {});

            }  else {
              AppConstants.showBottomMessage(context, jsonObject['data'].toString(), AppColors.black);
            }

          } else {

            AppConstants.printLog("init address fail");
            final body = json.decode(response.body);
            var snackBar = SnackBar( margin: EdgeInsets.all(20),
                behavior: SnackBarBehavior.floating,
                content: Text(body['data'].toString()),backgroundColor: AppColors.red);
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        });
      } else {
        AppConstants.printLog("init address fail");
        final body = json.decode(response.body);
        var snackBar = SnackBar( margin: EdgeInsets.all(20),
          behavior: SnackBarBehavior.floating,
          content: Text(body['data'].toString()),backgroundColor: AppColors.red);
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    });
  }
}
