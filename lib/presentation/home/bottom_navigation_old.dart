import 'dart:convert';
import 'package:exampur_mobile/Localization/language_constrants.dart';
import 'package:exampur_mobile/SharePref/shared_pref.dart';
import 'package:exampur_mobile/data/model/ChooseCategoryModel.dart';
import 'package:exampur_mobile/dynamicLink/firebase_dynamic_link.dart';
import 'package:exampur_mobile/presentation/AppTutorial/app_tutorial.dart';
import 'package:exampur_mobile/presentation/authentication/otp_screen.dart';
import 'package:exampur_mobile/presentation/authentication/terms_condition.dart';
import 'package:exampur_mobile/presentation/demo/demo.dart';
import 'package:exampur_mobile/presentation/downloads/downloads.dart';
import 'package:exampur_mobile/presentation/drawer/choose_category.dart';
import 'package:exampur_mobile/presentation/drawer/Parchase_course/my_purchases.dart';
import 'package:exampur_mobile/presentation/drawer/eligibility_calculator.dart';
import 'package:exampur_mobile/presentation/drawer/settings.dart';
import 'package:exampur_mobile/presentation/drawer/time_table.dart';
import 'package:exampur_mobile/presentation/help/help.dart';
import 'package:exampur_mobile/presentation/home/test_series_new/test_series_new.dart';
import 'package:exampur_mobile/presentation/my_courses/my_courses.dart';
import 'package:exampur_mobile/presentation/theme/custom_text_style.dart';
import 'package:exampur_mobile/provider/Authprovider.dart';
import 'package:exampur_mobile/provider/ChooseCategory_provider.dart';
import 'package:exampur_mobile/utils/api.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:exampur_mobile/utils/dimensions.dart';
import 'package:exampur_mobile/utils/images.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:exampur_mobile/presentation/home/home.dart';
import 'package:launch_review/launch_review.dart';
import 'package:provider/provider.dart';

class ItemClass {
  const ItemClass(this.index, this.label, this.icon);

  final int index;
  final String label;
  final icon;
}

class BottomNavigationOld extends StatefulWidget {
  const BottomNavigationOld({Key? key}) : super(key: key);

  @override
  _BottomNavigationOldState createState() => _BottomNavigationOldState();
}

class _BottomNavigationOldState extends State<BottomNavigationOld> with TickerProviderStateMixin {
  int _currIndex = 0;
  late AnimationController _hide;
  late List<AnimationController> _faders;
  late List<Key> _destinationKeys;
  int _counter = 0;
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  List<Data> allCategoriesList = [];
  List<String> selectedCategoryName = [];
  // String PHONE_VERIFY = '';
  String TOKEN = '';

  final List<Widget> widgetList = [
    Home(),
    Demo(),
    MyCourses(),
    Downloads(0),
    Help()
  ];

  @override
  void initState() {
    super.initState();
    FirebaseDynamicLinkService.initDynamicLink(context);

    _faders = widgetList.map<AnimationController>((item) {
      return AnimationController(
        duration: Duration(milliseconds: 300),
        vsync: this,
      );
    }).toList();
    _faders[_currIndex].value = 1.0;
    _destinationKeys =
        List<Key>.generate(widgetList.length, (int index) => GlobalKey())
            .toList();
    _hide = AnimationController(vsync: this, duration: kThemeAnimationDuration);

    callProvider();
  }

  Future<void> callProvider() async {
    await Provider.of<AuthProvider>(context, listen: false).getBannerBaseUrl(context);

    // var userData = jsonDecode(await SharedPref.getSharedPref(SharedPrefConstants.USER_DATA));
    // PHONE_VERIFY = userData[0]['data']['phone_conf'].toString();

    await SharedPref.getSharedPref(SharedPrefConstants.TOKEN).then((token) async {
      AppConstants.printLog('TOKEN>> $token');
      TOKEN = token;
      allCategoriesList = (await Provider.of<ChooseCategoryProvider>(context, listen: false).getAllCategoryList(context))!;
      AppConstants.selectedCategoryList = (await Provider.of<ChooseCategoryProvider>(context, listen: false).getSelectchooseCategoryList(context, token))!;

      for (int i = 0; i < AppConstants.selectedCategoryList.length; i++) {
        for (int j = 0; j < allCategoriesList.length; j++) {
          if (AppConstants.selectedCategoryList[i] == allCategoriesList[j].id) {
            allCategoriesList[j].isSelected = true;
            selectedCategoryName.add(allCategoriesList[j].name.toString());
          }
        }
      }

      setState(() {});
    });
  }

  @override
  void dispose() {
    for (AnimationController controller in _faders) controller.dispose();
    _hide.dispose();
    super.dispose();
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // return NotificationListener<ScrollNotification>(
    // onNotification: _handleScrollNotification,
    // child: Scaffold(
    //Provider.of<AuthProvider>(context, listen: false).initUserList(context);
    List<ItemClass> allItems = <ItemClass>[
      ItemClass(
          0,
          //'Home',

          getTranslated(context, 'home')!,
          _currIndex == 0
              ? Image.asset(Images.home,
                  height: 30, width: 25, color: AppColors.amber)
              : Image.asset(
                  Images.home,
                  height: 30,
                  width: 25,
                )),
      ItemClass(
        1,
        //'Courses',
        getTranslated(context, 'demo')!,
        FaIcon(
          FontAwesomeIcons.graduationCap,
        ),
        //Icon(BottomNavBarIcons.course_icon),
      ),
      ItemClass(
          2,
          //'Resources',
          getTranslated(context, 'my_courses')!,
          // FaIcon(FontAwesomeIcons.camera),
          _currIndex == 2
              ? Image.asset(
                  Images.mycourse2,
                  height: 30,
                  width: 25,
                )
              : Image.asset(
                  Images.mycourse,
                  height: 30,
                  width: 25,
                )),
      ItemClass(
          3,
          getTranslated(context, StringConstant.downloads)!,
          _currIndex == 3
              ? Image.asset(
                  Images.download,
                  height: 30,
                  width: 25,
                  color: AppColors.amber,
                )
              : Image.asset(
                  Images.download,
                  height: 30,
                  width: 25,
                )),
      ItemClass(
          4,
          getTranslated(context, StringConstant.help)!,
          _currIndex == 4
              ? Image.asset(Images.help,
                  height: 30, width: 25, color: AppColors.amber)
              : Image.asset(
                  Images.help,
                  height: 30,
                  width: 25,
                )),
    ];

    return WillPopScope(
      onWillPop: () async {
        //Use this code if you just want to go back to 0th index
        if (_currIndex == 0) {
          SystemChannels.platform.invokeMethod('SystemNavigator.pop');
          return true;
        } else {
          setState(() {
            _currIndex = 0;
          });
          return false;
        }
      },
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: AppColors.black),
          automaticallyImplyLeading: false,
          backgroundColor: AppColors.transparent,
          elevation: 0,
          leading: Builder(builder: (BuildContext context) {
            return IconButton(
                icon: Image.asset(
                  Images.menu_icon,
                  width: Dimensions.ICON_SIZE_LARGE,
                  color: AppColors.black,
                ),
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  AnalyticsConstants.sendAnalyticsEvent(
                      AnalyticsConstants.sideBarClick);
                  Scaffold.of(context).openDrawer();
                });
          }),
          title: InkWell(
            onTap: () {
              FocusScope.of(context).unfocus();
              Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              //LandingChooseCategory()
                              ChooseCategoryScreen(allCategoriesList)))
                  .then((value) {
                callProvider();
              });
            },
            child: Container(
              width: 120,
              child: Row(
                children: [
                  Flexible(
                      child: Text(
                    selectedCategoryName.length == 0
                        ? ''
                        : selectedCategoryName[selectedCategoryName.length - 1]
                            .toString(),
                    overflow: TextOverflow.fade,
                    style: TextStyle(color: AppColors.black, fontSize: 15),
                  )),
                  Icon(Icons.arrow_drop_down)
                ],
              ),
            ),
          ),
//           actions: [
//             // IconButton(
//             //     onPressed: () {
//             //       Navigator.push(context,
//             //           MaterialPageRoute(builder: (context) => SearchView()));
//             //     },
//             //     icon: const Icon(
//             //       Icons.search_outlined,
//             //       color: AppColors.black,
//             //       size: 30.0,
//             //     )),
//             // const SizedBox(
//             //   width: 20.0,
//             // ),
// // InkWell(
// //   onTap: (){
// //     Navigator.push(context,
// //                   MaterialPageRoute(builder: (context) => SearchView()));
// //   },
// //   child:   Icon( Icons.search_outlined,
// //
// //                   color: AppColors.black,
// //
// //                   size: 30.0,),
// // ),
// //             InkWell(
// //               onTap:() {
// //             Navigator.push(
// //                         context,
// //                         MaterialPageRoute(
// //                             builder: (context) => const Notifications()));
// //               },
// //               child: Container(
// //                // padding: EdgeInsets.all(8),
// //                 margin:EdgeInsets.all(8) ,
// //                 width: 30,
// //                 height: 30,
// //                 //color: Colors.amber,
// //                 child: Stack(
// //                   children: [
// //                     Icon(
// //                       Icons.notifications,
// //                       color: Colors.black,
// //                       size: 30,
// //                     ),
// //                     Container(
// //                       width: 30,
// //                       height: 30,
// //                       alignment: Alignment.topRight,
// //                       margin: EdgeInsets.only(top: 5),
// //                       child: Container(
// //                         width: 15,
// //                         height: 15,
// //                         decoration: BoxDecoration(
// //                             shape: BoxShape.circle,
// //                             color: Color(0xffc32c37),
// //                             border: Border.all(color: Colors.white, width: 1)),
// //                         child: Padding(
// //                           padding: const EdgeInsets.all(0.0),
// //                           child: Center(
// //                             child: Text(
// //                               _counter.toString(),
// //                               style: TextStyle(fontSize: 10),
// //                             ),
// //                           ),
// //                         ),
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //             )
//
//             // Padding(
//             //   padding: const EdgeInsets.only(right: 10.0),
//             //   child: IconButton(
//             //       onPressed: () {
//             //         Navigator.push(
//             //             context,
//             //             MaterialPageRoute(
//             //                 builder: (context) => const Notifications()));
//             //       },
//             //       icon: const Icon(
//             //         Icons.notifications,
//             //         color: AppColors.black,
//             //         size: 30.0,
//             //       )),
//             // ),
//           ],
        ),
        drawer: Drawer(
          elevation: 0,
          child: Container(
              color: Theme.of(context).cardColor,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Container(
                    //  // height: 200,
                    //   child: DrawerHeader(
                    //     child:  Image.asset(Images.exampur_logo,
                    //       width: Dimensions.ICON_SIZE_Logo,
                    //       height: Dimensions.ICON_SIZE_Logo,
                    //     ),),
                    // ),
                    Container(
                        margin: EdgeInsets.fromLTRB(0, 50, 0, 20),
                        child: Image.asset(
                          Images.exampur_logo,
                          width: Dimensions.ICON_SIZE_Logo,
                          height: Dimensions.ICON_SIZE_Logo,
                        )),
                    ListTile(
                      dense: true,
                      title: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset(
                              Images.apptutorial,
                              width: 30,
                              height: 20,
                              color: AppColors.amber,
                            ),
                            SizedBox(
                              width: Dimensions.PADDING_SIZE_SMALL,
                            ),
                            RichText(
                              text: TextSpan(
                                  style: CustomTextStyle.drawerText(context),
                                  text: getTranslated(context,
                                      'app_tutorial') //'Select Class: ',
                                  ),
                            ),
                          ]),
                      onTap: () async {
                        // await  FirebaseAnalytics.instance.logEvent(name: 'COURSE',parameters: {
                        //    'id':'123456'
                        //  });
                        FirebaseMessaging.instance.subscribeToTopic('Testing');

                        _scaffoldKey.currentState?.openEndDrawer();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AppTutorial()));
                      },
                    ),
                    ListTile(
                      dense: true,
                      title: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset(
                              Images.category,
                              width: 30,
                              height: 20,
                              color: AppColors.amber,
                            ),
                            SizedBox(
                              width: Dimensions.PADDING_SIZE_SMALL,
                            ),
                            RichText(
                              text: TextSpan(
                                  style: CustomTextStyle.drawerText(context),
                                  text: getTranslated(
                                      context, 'choose_category')),
                            ),
                          ]),
                      onTap: () {
                        _scaffoldKey.currentState?.openEndDrawer();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    //LandingChooseCategory()
                                    ChooseCategoryScreen(
                                        allCategoriesList))).then((value) {
                          callProvider();
                        });
                      },
                    ),
                    ListTile(
                      dense: true,
                      title: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset(
                              Images.download,
                              width: 30,
                              height: 20,
                              color: AppColors.amber,
                            ),
                            SizedBox(
                              width: Dimensions.PADDING_SIZE_SMALL,
                            ),
                            RichText(
                              text: TextSpan(
                                  style: CustomTextStyle.drawerText(context),
                                  text: getTranslated(context, 'downloads')),
                            ),
                          ]),
                      onTap: () {
                        _scaffoldKey.currentState?.openEndDrawer();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Downloads(0)));
                      },
                    ),
                    ListTile(
                      dense: true,
                      title: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset(
                              Images.mypurchase,
                              width: 30,
                              height: 20,
                              color: AppColors.amber,
                            ),
                            SizedBox(
                              width: Dimensions.PADDING_SIZE_SMALL,
                            ),
                            RichText(
                              text: TextSpan(
                                  style: CustomTextStyle.drawerText(context),
                                  text: getTranslated(context, 'my_purchase')),
                            ),
                          ]),
                      onTap: () {
                        _scaffoldKey.currentState?.openEndDrawer();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyPurchases()));
                      },
                    ),
                    ListTile(
                      dense: true,
                      title: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset(
                              Images.timetable,
                              width: 30,
                              height: 20,
                              color: AppColors.amber,
                            ),
                            SizedBox(
                              width: Dimensions.PADDING_SIZE_SMALL,
                            ),
                            RichText(
                              text: TextSpan(
                                  style: CustomTextStyle.drawerText(context),
                                  text: getTranslated(
                                      context, StringConstant.attemptTest)),
                            ),
                          ]),
                      onTap: () async {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TestSeriesNew(
                                    API.attemptTestWebUrl, TOKEN)));
                      },
                    ),
                    ListTile(
                      dense: true,
                      title: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset(
                              Images.attemptquiz,
                              width: 30,
                              height: 20,
                              color: AppColors.amber,
                            ),
                            SizedBox(
                              width: Dimensions.PADDING_SIZE_SMALL,
                            ),
                            RichText(
                              text: TextSpan(
                                  style: CustomTextStyle.drawerText(context),
                                  text: getTranslated(
                                      context, StringConstant.attemptedQuiz)),
                            ),
                          ]),
                      onTap: () async {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TestSeriesNew(
                                    API.attemptQuizzesWebUrl, TOKEN)));
                      },
                    ),
                    ListTile(
                      dense: true,
                      title: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset(
                              Images.savequestion,
                              width: 30,
                              height: 20,
                              color: AppColors.amber,
                            ),
                            SizedBox(
                              width: Dimensions.PADDING_SIZE_SMALL,
                            ),
                            RichText(
                              text: TextSpan(
                                  style: CustomTextStyle.drawerText(context),
                                  text: getTranslated(
                                      context, StringConstant.savedQuestion)),
                            ),
                          ]),
                      onTap: () async {
                        _scaffoldKey.currentState?.openEndDrawer();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TestSeriesNew(API.savedQuestionWebUrl, TOKEN)
                            )
                        );
                      },
                    ),
                    ListTile(
                      dense: true,
                      title: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.settings,
                              color: AppColors.amber,
                            ),
                            SizedBox(
                              width: Dimensions.PADDING_SIZE_SMALL,
                            ),
                            RichText(
                              text: TextSpan(
                                  style: CustomTextStyle.drawerText(context),
                                  text: getTranslated(context, 'settings')),
                            ),
                          ]),
                      onTap: () {
                        _scaffoldKey.currentState?.openEndDrawer();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Settings()));
                      },
                    ),
                    ListTile(
                      dense: true,
                      title: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.policy,
                              color: AppColors.amber,
                            ),
                            SizedBox(
                              width: Dimensions.PADDING_SIZE_SMALL,
                            ),
                            RichText(
                              text: TextSpan(
                                  style: CustomTextStyle.drawerText(context),
                                  text: getTranslated(
                                      context, StringConstant.PrivacyPolicy)),
                            ),
                          ]),
                      onTap: () {
                        _scaffoldKey.currentState?.openEndDrawer();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    TermsAndConditions(API.PrivacyPolicy_URL)));
                      },
                    ),
                    ListTile(
                      dense: true,
                      title: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.share,
                              color: AppColors.amber,
                            ),
                            SizedBox(
                              width: Dimensions.PADDING_SIZE_SMALL,
                            ),
                            RichText(
                              text: TextSpan(
                                  style: CustomTextStyle.drawerText(context),
                                  text: getTranslated(context, "share_now")),
                            ),
                          ]),
                      onTap: () {
                        _scaffoldKey.currentState?.openEndDrawer();
                        AppConstants.shareData(
                            message: AppConstants.shareAppContent);
                      },
                    ),
                    ListTile(
                      dense: true,
                      title: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.star_border,
                              color: AppColors.amber,
                            ),
                            SizedBox(
                              width: Dimensions.PADDING_SIZE_SMALL,
                            ),
                            RichText(
                              text: TextSpan(
                                  style: CustomTextStyle.drawerText(context),
                                  text: getTranslated(context, 'rate_us')),
                            ),
                          ]),
                      onTap: () {
                        _scaffoldKey.currentState?.openEndDrawer();
                        LaunchReview.launch(
                            androidAppId: AppConstants.androidId,
                            iOSAppId: AppConstants.iosId);
                      },
                    ),
                    // ListTile(
                    //   dense: true,
                    //   title: Row(
                    //       mainAxisAlignment: MainAxisAlignment.start,
                    //       children: [
                    //         Icon(
                    //           Icons.feedback_outlined,
                    //           color: AppColors.amber,
                    //         ),
                    //         SizedBox(
                    //           width: Dimensions.PADDING_SIZE_SMALL,
                    //         ),
                    //         RichText(
                    //           text: TextSpan(
                    //               style: CustomTextStyle.drawerText(context),
                    //               text: getTranslated(context, 'help_and_feedback')),
                    //         ),
                    //       ]),
                    //   onTap: () {
                    //     Navigator.push(context,
                    //         MaterialPageRoute(builder: (context) => Help()));
                    //   },
                    // ),
                    ListTile(
                      dense: true,
                      title: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.login,
                              color: AppColors.amber,
                            ),
                            SizedBox(
                              width: Dimensions.PADDING_SIZE_SMALL,
                            ),
                            RichText(
                              text: TextSpan(
                                  style: CustomTextStyle.drawerText(context),
                                  text: getTranslated(context, 'log_out')),
                            ),
                          ]),
                      onTap: () {
                        AnalyticsConstants.sendAnalyticsEvent(
                            AnalyticsConstants.logoutClick);
                        SharedPref.clearSharedPref(SharedPrefConstants.TOKEN);
                        SharedPref.clearSharedPref(
                            SharedPrefConstants.USER_DATA);
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            '/landingPage', (Route<dynamic> route) => false);
                      },
                    ),
                  ],
                ),
              )),
        ),
        body: SafeArea(
          top: false,
          child: Stack(
            fit: StackFit.expand,
            children: allItems.map(
              (item) {
                final Widget view = FadeTransition(
                  opacity: _faders[item.index].drive(
                    CurveTween(curve: Curves.fastOutSlowIn),
                  ),
                  child: KeyedSubtree(
                    key: _destinationKeys[item.index],
                    child: widgetList[item.index],
                  ),
                );
                if (item.index == _currIndex) {
                  _faders[item.index].forward();
                  return view;
                } else {
                  _faders[item.index].reverse();
                  if (_faders[item.index].isAnimating) {
                    return IgnorePointer(child: view);
                  }
                  return Offstage(child: view);
                }
              },
            ).toList(),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _currIndex,
          showUnselectedLabels: true,
          onTap: (index) {
            setState(() {
              //  if(index==2 && PHONE_VERIFY=='false') {
              if (AppConstants.isotpverify == false) {
                AppConstants.showAlertDialogWithButton(
                    context,
                    getTranslated(
                        context, StringConstant.Pleaseverifyyourphoneno)!,
                    route);
                return;
              }
              if (index == 2) {
                setState(() {
                  MyCourses();
                });
              }
              _currIndex = index;
            });
            if (_currIndex == 1 || _currIndex == 2 || _currIndex == 3) {
              AnalyticsConstants.sendAnalyticsEvent(_currIndex == 1
                  ? AnalyticsConstants.demoClick
                  : _currIndex == 2
                      ? AnalyticsConstants.myCoursesClick
                      : AnalyticsConstants.downloadsClick);
            }
          },
          iconSize: 20,
          selectedItemColor: AppColors.amber,
          unselectedFontSize: 12,
          selectedFontSize: 12,
          items: allItems.map((item) {
            return BottomNavigationBarItem(
              icon: item.icon,
              label: item.label,
            );
          }).toList(),
        ),
      ),
    );
  }

  route() {
    AppConstants.goAndReplace(context, OtpScreen(false));
  }
}
