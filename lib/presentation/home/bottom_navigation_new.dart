import 'dart:convert';

import 'package:exampur_mobile/Localization/language_constrants.dart';
import 'package:exampur_mobile/SharePref/shared_pref.dart';
import 'package:exampur_mobile/data/model/ChooseCategoryModel.dart';
import 'package:exampur_mobile/dynamicLink/firebase_dynamic_link.dart';
import 'package:exampur_mobile/presentation/AppTutorial/app_tutorial.dart';
import 'package:exampur_mobile/presentation/authentication/otp_screen.dart';
import 'package:exampur_mobile/presentation/demo/demo.dart';
import 'package:exampur_mobile/presentation/downloads/downloads.dart';
import 'package:exampur_mobile/presentation/drawer/Parchase_course/my_purchases.dart';
import 'package:exampur_mobile/presentation/drawer/choose_category.dart';
import 'package:exampur_mobile/presentation/drawer/settings.dart';
import 'package:exampur_mobile/presentation/help/help.dart';
import 'package:exampur_mobile/presentation/my_courses/my_courses.dart';
import 'package:exampur_mobile/presentation/theme/custom_text_style.dart';
import 'package:exampur_mobile/provider/ChooseCategory_provider.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:exampur_mobile/utils/dimensions.dart';
import 'package:exampur_mobile/utils/images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:launch_review/launch_review.dart';
import 'package:provider/provider.dart';

import 'home.dart';

class BottomNavigationNew extends StatefulWidget {
  const BottomNavigationNew() : super();

  @override
  State<BottomNavigationNew> createState() => _BottomNavigationNewState();
}

class _BottomNavigationNewState extends State<BottomNavigationNew> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  List<Data> allCategoriesList = [];
  List<String> selectedCategoryName = [];
  int _currentTabIndex = 0;
  String PHONE_VERIFY = '';

  @override
  void initState() {
    super.initState();
    FirebaseDynamicLinkService.initDynamicLink(context);
    callProvider();
  }

  Future<void> callProvider() async {
    allCategoriesList = (await Provider.of<ChooseCategoryProvider>(context, listen: false).getAllCategoryList(context))!;

    var userData =  jsonDecode(await SharedPref.getSharedPref(SharedPrefConstants.USER_DATA));
    PHONE_VERIFY = userData[0]['data']['phone_conf'].toString();

    await SharedPref.getSharedPref(SharedPrefConstants.TOKEN).then((token) async {
      AppConstants.printLog('TOKEN>> $token');
      AppConstants.selectedCategoryList = (await Provider.of<ChooseCategoryProvider>(context, listen: false).getSelectchooseCategoryList(context, token))!;

      for(int i=0; i < AppConstants.selectedCategoryList.length; i++) {
        for(int j=0; j<allCategoriesList.length; j++) {
          if(AppConstants.selectedCategoryList[i] == allCategoriesList[j].id) {
            allCategoriesList[j].isSelected = true;
            selectedCategoryName.add(allCategoriesList[j].name.toString());
          }
        }
      }
      setState(() {});
    });
  }

  final List<Widget> widgetList = [
    Home(),
    Demo(),
    MyCourses(),
    Downloads(0),
    Help()
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          if (_currentTabIndex == 0) {
            SystemChannels.platform.invokeMethod('SystemNavigator.pop');
            return true;
          } else {
            setState(() {
              _currentTabIndex = 0;
              _navigatorKey.currentState!.pushReplacement(MaterialPageRoute(builder: (_) => Home()));
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
                  icon: Image.asset(Images.menu_icon,width: Dimensions.ICON_SIZE_LARGE,color: AppColors.black,),
                  onPressed: () {
                    AnalyticsConstants.sendAnalyticsEvent(AnalyticsConstants.sideBarClick);
                    Scaffold.of(context).openDrawer();});
            }),
            title: InkWell(
              onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                        //LandingChooseCategory()
                        ChooseCategoryScreen(allCategoriesList)
                    )).then((value) {
                  callProvider();
                });
              },
              child: Container(
                width: 120,
                child: Row(children: [
                  Flexible(child: Text(selectedCategoryName.length == 0 ? '' :selectedCategoryName[selectedCategoryName.length-1].toString(),overflow: TextOverflow.fade,style: TextStyle(color: AppColors.black,fontSize: 15),)),
                  Icon(Icons.arrow_drop_down)
                ],),
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
                          margin: EdgeInsets.fromLTRB(0,50,0,20),
                          child: Image.asset(Images.exampur_logo,
                            width: Dimensions.ICON_SIZE_Logo,
                            height: Dimensions.ICON_SIZE_Logo,
                          )
                      ),
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
                                    text: getTranslated(context, 'app_tutorial') //'Select Class: ',
                                ),
                              ),
                            ]),
                        onTap: () async{
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
                                    text:  getTranslated(context, 'choose_category')),
                              ),
                            ]),
                        onTap: () {
                          _scaffoldKey.currentState?.openEndDrawer();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                  //LandingChooseCategory()
                                  ChooseCategoryScreen(allCategoriesList)
                              )).then((value) {
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
                                    text:getTranslated(context, 'settings')),
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
                          AppConstants.shareData(message: AppConstants.shareAppContent);
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
                          LaunchReview.launch(androidAppId: AppConstants.androidId, iOSAppId: AppConstants.iosId);
                        },
                      ),
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
                                    text: getTranslated(context, 'log_out')
                                ),
                              ),
                            ]),
                        onTap: () {
                          AnalyticsConstants.sendAnalyticsEvent(AnalyticsConstants.logoutClick);
                          SharedPref.clearSharedPref(SharedPrefConstants.TOKEN);
                          SharedPref.clearSharedPref(SharedPrefConstants.USER_DATA);
                          Navigator.of(context).pushNamedAndRemoveUntil('/landingPage', (Route<dynamic> route) => false);
                        },
                      ),
                    ],
                  ),
                )
            ),
          ),
          body: Navigator(key: _navigatorKey, onGenerateRoute: generateRoute),
          bottomNavigationBar: _bottomNavigationBar(),
        )
    );
  }

  Widget _bottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
          icon: _currentTabIndex==0 ? Image.asset(Images.home,height: 30,width: 25,color: AppColors.amber):Image.asset(Images.home,height: 30,width: 25),
          title: Text(getTranslated(context, 'home')!),
        ),
        BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.graduationCap),
            title: Text(getTranslated(context, 'demo')!)
        ),
        BottomNavigationBarItem(
            icon: _currentTabIndex==2 ? Image.asset(Images.mycourse2,height: 30,width: 25):Image.asset(Images.mycourse,height: 30,width: 25,),
            title: Text(getTranslated(context, 'my_courses')!)
        ),
        BottomNavigationBarItem(
            icon: _currentTabIndex==3 ? Image.asset(Images.download,height: 30,width: 25,color: AppColors.amber):Image.asset(Images.download,height: 30,width: 25),
            title: Text(getTranslated(context, StringConstant.downloads)!)
        ),
        BottomNavigationBarItem(
          icon: _currentTabIndex==4 ? Image.asset(Images.help,height: 30,width: 25,color: AppColors.amber): Image.asset(Images.help,height: 30,width: 25),
          title: Text(getTranslated(context, StringConstant.help)!),
        )
      ],
      onTap: _onTap,
      selectedItemColor: AppColors.amber,
      unselectedFontSize: 12,
      selectedFontSize: 12,
      currentIndex: _currentTabIndex,
    );
  }

  _onTap(int tabIndex) {
    switch (tabIndex) {
      case 0:
        _navigatorKey.currentState!.pushReplacement(MaterialPageRoute(builder: (_) => Home()));
        break;
      case 1:
        AnalyticsConstants.sendAnalyticsEvent(AnalyticsConstants.demoClick);
        _navigatorKey.currentState!.pushReplacement(MaterialPageRoute(builder: (_) => Demo()));
        break;
      case 2:
        AnalyticsConstants.sendAnalyticsEvent(AnalyticsConstants.myCoursesClick);
        if(PHONE_VERIFY=='false') {
          AppConstants.showAlertDialogWithButton(context, getTranslated(context, StringConstant.Pleaseverifyyourphoneno)!, route);
          return;
        } else {
          _navigatorKey.currentState!.pushReplacement(MaterialPageRoute(builder: (_) => MyCourses()));
        }
        break;
      case 3:
        AnalyticsConstants.sendAnalyticsEvent(AnalyticsConstants.downloadsClick);
        _navigatorKey.currentState!.pushReplacement(MaterialPageRoute(builder: (_) => Downloads(0)));
        break;
      case 4:
        _navigatorKey.currentState!.pushReplacement(MaterialPageRoute(builder: (_) => Help()));
        break;
    }
    setState(() {
      _currentTabIndex = tabIndex;
    });
  }

  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "Demo":
        return MaterialPageRoute(builder: (context) => Demo());
      case "My Courses":
        return MaterialPageRoute(builder: (context) => MyCourses());
      case "Downloads":
        return MaterialPageRoute(builder: (context) => Downloads(0));
      case "Help":
        return MaterialPageRoute(builder: (context) => Help());
      default:
        return MaterialPageRoute(builder: (context) => Home());
    }
  }

  route() {
    Navigator.of(context, rootNavigator: true).pushReplacement(MaterialPageRoute(builder: (context) =>OtpScreen(false)));
  }
}