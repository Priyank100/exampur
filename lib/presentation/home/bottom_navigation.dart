import 'dart:convert';
import 'package:exampur_mobile/Localization/language_constrants.dart';
import 'package:exampur_mobile/SharePref/shared_pref.dart';
import 'package:exampur_mobile/data/model/ChooseCategoryModel.dart';
import 'package:exampur_mobile/data/model/response/home_banner_model.dart';
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
import 'package:exampur_mobile/provider/HomeBannerProvider.dart';
import 'package:exampur_mobile/utils/analytics_constants.dart';
import 'package:exampur_mobile/utils/api.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:exampur_mobile/utils/app_colors.dart';
import 'package:exampur_mobile/utils/dimensions.dart';
import 'package:exampur_mobile/utils/images.dart';
import 'package:exampur_mobile/utils/lang_string.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:exampur_mobile/presentation/home/home.dart';
import 'package:provider/provider.dart';
import '../../main.dart';

class ItemClass {
  const ItemClass(this.index, this.label, this.icon);

  final int index;
  final String label;
  final icon;
}

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> with TickerProviderStateMixin {
  int _currIndex = 0;
  late AnimationController _hide;
  late List<AnimationController> _faders;
  late List<Key> _destinationKeys;
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  List<Data> allCategoriesList = [];
  List<String> selectedCategoryName = [];
  String TOKEN = '';

  List<BannerData> bannerList = [];

  final List<Widget> widgetList = [
    Home([]),
    Demo(),
    MyCourses(),
    Downloads(0),
    Help()
  ];

  @override
  void initState() {
    super.initState();
    var map = {
      'Page_Name':'Home_Page',
      'Mobile_Number':AppConstants.userMobile,
      'Language':'en',
      'User_ID':AppConstants.userMobile
    };
    AnalyticsConstants.trackEventMoEngage(AnalyticsConstants.Home_Page,map);

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

    await SharedPref.getSharedPref(SharedPref.TOKEN).then((token) async {
      AppConstants.printLog('TOKEN>> $token');
      TOKEN = token;
      allCategoriesList = (await Provider.of<ChooseCategoryProvider>(context, listen: false).getAllCategoryList(context))!;
      AppConstants.selectedCategoryList = (await Provider.of<ChooseCategoryProvider>(context, listen: false).getSelectchooseCategoryList(context, token))!;

      for (int i = 0; i < AppConstants.selectedCategoryList.length; i++) {
        for (int j = 0; j < allCategoriesList.length; j++) {
          if (AppConstants.selectedCategoryList[i] == allCategoriesList[j].id) {
            allCategoriesList[j].isSelected = true;
            selectedCategoryName.add(allCategoriesList[j].name.toString());
            AppConstants.selectedCategoryName = selectedCategoryName;
          }
        }
      }
      bannerList = (await Provider.of<HomeBannerProvider>(context, listen: false).getHomeBannner(context, AppConstants.encodeCategory()))!;
      widgetList[0] = Home(bannerList);
      setState(() {});
    });
  }

  @override
  void dispose() {
    for (AnimationController controller in _faders) controller.dispose();
    _hide.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<ItemClass> allItems = <ItemClass>[
      ItemClass(
          0,
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
        getTranslated(context, 'demo')!,
        FaIcon(
          FontAwesomeIcons.graduationCap,
        ),
        //Icon(BottomNavBarIcons.course_icon),
      ),
      ItemClass(
          2,
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
          getTranslated(context, LangString.downloads)!,
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
          getTranslated(context, LangString.help)!,
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
          AppConstants.checkRatingCondition(context, true);
          // SystemChannels.platform.invokeMethod('SystemNavigator.pop');
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
                  Map<String, Object> stuff = {};
                  AnalyticsConstants.logEvent(AnalyticsConstants.sideBarClick,stuff);
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
        ),
        drawer: Drawer(
          elevation: 0,
          child: Container(
              color: Theme.of(context).cardColor,
              child: SingleChildScrollView(
                child: Column(
                  children: [
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
                     // AppConstants.subscription('onmessagetesting');
                        var map = {
                          'Page_Name':'Side_Bar_App_Tutorial',
                          'Mobile_Number':AppConstants.userMobile,
                          'Language':AppConstants.langCode,
                          'User_ID':AppConstants.userMobile,

                        };
                        AnalyticsConstants.trackEventMoEngage(AnalyticsConstants.Click_App_Tutorial_Page_Side_Nav,map);
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
                        var map = {
                          'Page_Name':'Side_Bar_Category',
                          'Mobile_Number':AppConstants.userMobile,
                          'Language':AppConstants.langCode,
                          'User_ID':AppConstants.userMobile,

                        };
                        AnalyticsConstants.trackEventMoEngage(AnalyticsConstants.Click_Choose_Category_Side_Nav,map);
                        _scaffoldKey.currentState?.openEndDrawer();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
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
                        var map = {
                          'Page_Name':'Side_Bar_Downloads',
                          'Mobile_Number':AppConstants.userMobile,
                          'Language':AppConstants.langCode,
                          'User_ID':AppConstants.userMobile,

                        };
                        AnalyticsConstants.trackEventMoEngage(AnalyticsConstants.Click_Downloads_Side_Nav,map);
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
                        var map = {
                          'Page_Name':'Side_Bar_Purchase',
                          'Mobile_Number':AppConstants.userMobile,
                          'Language':AppConstants.langCode,
                          'User_ID':AppConstants.userMobile,

                        };
                        AnalyticsConstants.trackEventMoEngage(AnalyticsConstants.Click_My_Purchase_Side_Nav,map);
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
                                      context, LangString.attemptTest)),
                            ),
                          ]),
                      onTap: () async {
                        var map = {
                          'Page_Name':'Side_Bar_TestSeries',
                          'Mobile_Number':AppConstants.userMobile,
                          'Language':AppConstants.langCode,
                          'User_ID':AppConstants.userMobile,

                        };
                        AnalyticsConstants.trackEventMoEngage(AnalyticsConstants.Click_Attempted_Test_Side_Nav,map);
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
                                      context, LangString.attemptedQuiz)),
                            ),
                          ]),
                      onTap: () async {
                        var map = {
                          'Page_Name':'Side_Bar_Attempt_Quiz',
                          'Mobile_Number':AppConstants.userMobile,
                          'Language':AppConstants.langCode,
                          'User_ID':AppConstants.userMobile,

                        };
                        AnalyticsConstants.trackEventMoEngage(AnalyticsConstants.Click_Attempted_Quiz_Side_Nav,map);
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
                                      context, LangString.savedQuestion)),
                            ),
                          ]),
                      onTap: () async {
                        var map = {
                          'Page_Name':'Side_Bar_SavedQuestion',
                          'Mobile_Number':AppConstants.userMobile,
                          'Language':AppConstants.langCode,
                          'User_ID':AppConstants.userMobile,

                        };
                        AnalyticsConstants.trackEventMoEngage(AnalyticsConstants.Click_Saved_Questions_Side_Nav,map);
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
                        var map = {
                          'Page_Name':'Side_Bar_Setting',
                          'Mobile_Number':AppConstants.userMobile,
                          'Language':AppConstants.langCode,
                          'User_ID':AppConstants.userMobile,

                        };
                        AnalyticsConstants.trackEventMoEngage(AnalyticsConstants.Click_Settings_Side_Nav,map);
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
                                      context, LangString.PrivacyPolicy)),
                            ),
                          ]),
                      onTap: () {
                        var map = {
                          'Page_Name':'Side_Bar_PrivacyPolicy',
                          'Mobile_Number':AppConstants.userMobile,
                          'Language':AppConstants.langCode,
                          'User_ID':AppConstants.userMobile,

                        };
                        AnalyticsConstants.trackEventMoEngage(AnalyticsConstants.Click_Privacy_Policy_Side_Nav,map);
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
                        var map = {
                          'Page_Name':'Side_Bar_Share',
                          'Mobile_Number':AppConstants.userMobile,
                          'Language':AppConstants.langCode,
                          'User_ID':AppConstants.userMobile,

                        };
                        AnalyticsConstants.trackEventMoEngage(AnalyticsConstants.Click_Share_Now_Side_Nav,map);
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
                      onTap: () async {
                        var map = {
                          'Page_Name':'Side_Bar_Rating',
                          'Mobile_Number':AppConstants.userMobile,
                          'Language':AppConstants.langCode,
                          'User_ID':AppConstants.userMobile,

                        };
                        AnalyticsConstants.trackEventMoEngage(AnalyticsConstants.Click_Share_Now_Side_Nav,map);
                        _scaffoldKey.currentState?.openEndDrawer();
                        await SharedPref.clearSharedPref(SharedPref.RATING).then((value) {
                          AppConstants.checkRatingCondition(context, false);
                        });
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
                      onTap: () async {
                        var map = {
                          'Page_Name':'Side_Bar_Logout',
                          'Mobile_Number':AppConstants.userMobile,
                          'Language':AppConstants.langCode,
                          'User_ID':AppConstants.userMobile,

                        };
                        AnalyticsConstants.trackEventMoEngage(AnalyticsConstants.Click_Log_Out_Side_Nav,map);
                        AnalyticsConstants.sendAnalyticsEvent(
                            AnalyticsConstants.logoutClick);
                        Map<String, Object> stuff = {};
                        AnalyticsConstants.logEvent(AnalyticsConstants.logoutClick,stuff);
                        SharedPref.clearSharedPref(SharedPref.TOKEN);
                        SharedPref.clearSharedPref(SharedPref.USER_DATA);
                        Locale _locale = await setLocale('en');
                        MyApp.setLocale(context, _locale);
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
                        context, LangString.Pleaseverifyyourphoneno)!,
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
              Map<String, Object> stuff = {};
              AnalyticsConstants.logEvent(_currIndex == 1?AnalyticsConstants.demoClick:_currIndex == 2
                  ?AnalyticsConstants.myCoursesClick:AnalyticsConstants.downloadsClick,stuff
              );
            }
            var map = {
              'Page_Name':'Home_Page',
              'Mobile_Number':AppConstants.userMobile,
              'Language':AppConstants.langCode,
              'User_ID':AppConstants.userMobile
            };
            AnalyticsConstants.trackEventMoEngage(
                _currIndex == 1 ? AnalyticsConstants.Click_Demo_Bottom_Nav :
                _currIndex == 2 ? AnalyticsConstants.Click_My_Courses_Bottom_Nav :
                _currIndex == 3? AnalyticsConstants.Click_Downloads_Bottom_Nav :
                _currIndex == 4 ? AnalyticsConstants.Click_Help_Bottom_Nav :
                AnalyticsConstants.Home_Page, map
            );
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
