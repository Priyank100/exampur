import 'package:exampur_mobile/Localization/language_constrants.dart';
import 'package:exampur_mobile/SharePref/shared_pref.dart';
import 'package:exampur_mobile/presentation/AppTutorial/app_tutorial.dart';
import 'package:exampur_mobile/presentation/Search/searchview.dart';
import 'package:exampur_mobile/presentation/authentication/landing_page.dart';
import 'package:exampur_mobile/presentation/demo/demo.dart';
import 'package:exampur_mobile/presentation/downloads/downloads.dart';
import 'package:exampur_mobile/presentation/drawer/choose_category.dart';
import 'package:exampur_mobile/presentation/drawer/eligibility_calculator.dart';
import 'package:exampur_mobile/presentation/drawer/my_purchases.dart';
import 'package:exampur_mobile/presentation/drawer/settings.dart';
import 'package:exampur_mobile/presentation/drawer/time_table.dart';
import 'package:exampur_mobile/presentation/help/help.dart';
import 'package:exampur_mobile/presentation/home/study_material/study_material.dart';
import 'package:exampur_mobile/presentation/my_courses/my_courses.dart';
import 'package:exampur_mobile/presentation/notifications/notification_screen.dart';
import 'package:exampur_mobile/presentation/theme/custom_text_style.dart';
import 'package:exampur_mobile/provider/Authprovider.dart';
import 'package:exampur_mobile/utils/app_constants.dart';

import 'package:exampur_mobile/utils/dimensions.dart';
import 'package:exampur_mobile/utils/images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:exampur_mobile/presentation/home/home.dart';
import 'package:launch_review/launch_review.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

import 'LandingChooseCategory.dart';

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

class _BottomNavigationState extends State<BottomNavigation>
    with TickerProviderStateMixin {
  int _currIndex = 0;
  late AnimationController _hide;
  late List<AnimationController> _faders;
  late List<Key> _destinationKeys;

  @override
  void initState() {
    super.initState();

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
  }

  @override
  void dispose() {
    for (AnimationController controller in _faders) controller.dispose();
    _hide.dispose();
    super.dispose();
  }

  final List<Widget> widgetList = [
    Home(),
    Demo(),
    MyCourses(),
    // Downloads(),
    // Help()
  ];
  // final List<String> widgetNames = [
  //   ,
  //   "Demo",
  //   "My Courses",
  //   // "Downloads",
  //   // "Help"
  // ];

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
         _currIndex==0? Image.asset(Images.home,height: 30,width: 25,color: Colors.amber):Image.asset(Images.home,height: 30,width: 25,)
      ),
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
        FaIcon(FontAwesomeIcons.camera),
      ),
      // ItemClass(
      //   3,
      //   "Downloads",
      //     _currIndex==3?   Image.asset(Images.download,height: 30,width: 25,color: Colors.amber,):Image.asset(Images.download,height: 30,width: 25,)
      // ),
      // ItemClass(
      //   4,
      //   "Help",
      //     _currIndex==4?  Image.asset(Images.help,height: 30,width: 25,color: Colors.amber): Image.asset(Images.help,height: 30,width: 25,)
      // ),
    ];

    return WillPopScope(
      onWillPop: () async {
        //Use this code if you just want to go back to 0th index
        if (_currIndex == 0) return true;
        setState(() {
          _currIndex = 0;
        });
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: Builder(builder: (BuildContext context) {
            return IconButton(
                icon: Image.asset(Images.menu_icon,width: Dimensions.ICON_SIZE_LARGE,color: Colors.black,),
                onPressed: () => Scaffold.of(context).openDrawer());
          }),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SearchView()));
                },
                icon: const Icon(
                  Icons.search_outlined,
                  color: Colors.black,
                  size: 30.0,
                )),
            // const SizedBox(
            //   width: 20.0,
            // ),
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Notifications()));
                  },
                  icon: const Icon(
                    Icons.notifications,
                    color: Colors.black,
                    size: 30.0,
                  )),
            ),
          ],
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
                              color: Colors.amber,
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
                      onTap: () {
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
                              color: Colors.amber,
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    //LandingChooseCategory()
                                    ChooseCategory()
                            ));
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
                              color: Colors.amber,
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Downloads()));
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
                              color: Colors.amber,
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
                              color: Colors.amber,
                            ),
                            SizedBox(
                              width: Dimensions.PADDING_SIZE_SMALL,
                            ),
                            RichText(
                              text: TextSpan(
                                  style: CustomTextStyle.drawerText(context),
                                  text: getTranslated(context, 'my_timetable')),
                            ),
                          ]),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyTimeTable()));
                      },
                    ),
                    ListTile(
                      dense: true,
                      title: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.settings,
                              color: Colors.amber,
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
                            Image.asset(
                              Images.calculator,
                              width: 30,
                              height: 20,
                              color: Colors.amber,
                            ),
                            SizedBox(
                              width: Dimensions.PADDING_SIZE_SMALL,
                            ),
                            RichText(
                              text: TextSpan(
                                  style: CustomTextStyle.drawerText(context),
                                  text: getTranslated(context, 'eligibility_calculator')),
                            ),
                          ]),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EligibilityCalculator()));
                      },
                    ),
                    ListTile(
                      dense: true,
                      title: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.share,
                              color: Colors.amber,
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
                              color: Colors.amber,
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
                        LaunchReview.launch(androidAppId: AppConstants.androidId, iOSAppId: AppConstants.iosId);
                      },
                    ),
                    ListTile(
                      dense: true,
                      title: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.feedback_outlined,
                              color: Colors.amber,
                            ),
                            SizedBox(
                              width: Dimensions.PADDING_SIZE_SMALL,
                            ),
                            RichText(
                              text: TextSpan(
                                  style: CustomTextStyle.drawerText(context),
                                  text: getTranslated(context, 'help_and_feedback')),
                            ),
                          ]),
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Help()));
                      },
                    ),
                    ListTile(
                      dense: true,
                      title: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.login,
                              color: Colors.amber,
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
                        SharedPref.clearSharedPref(SharedPrefConstants.TOKEN);
                        Navigator.of(context)
                            .pushNamedAndRemoveUntil('/landingPage', (Route<dynamic> route) => false);
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

        // bottomNavigationBar: SizeTransition(
        //   sizeFactor: _hide,
        //   axisAlignment: -1.0,
        //   child: BottomNavigationBar(
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _currIndex,
          showUnselectedLabels: true,
        //  fixedColor: Theme.of(context).primaryColor,
        //  unselectedItemColor: Colors.black,
          onTap: (index) {
            setState(() {
              _currIndex = index;
            });
          },
          iconSize: 20,
selectedItemColor: Colors.amber,

          unselectedFontSize: 12,
          selectedFontSize: 12,
          //unselectedLabelStyle: TextStyle(color: Colors.amber),
          items: allItems.map((item) {
            return BottomNavigationBarItem(
              icon: item.icon,
              label: item.label,

            );
          }).toList(),
        ),
        // ),
        // ),
      ),
    );
  }
}
