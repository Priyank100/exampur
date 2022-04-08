import 'package:exampur_mobile/Localization/language_constrants.dart';
import 'package:exampur_mobile/SharePref/shared_pref.dart';
import 'package:exampur_mobile/dynamicLink/firebase_dynamic_link.dart';
import 'package:exampur_mobile/presentation/AppTutorial/app_tutorial.dart';
import 'package:exampur_mobile/presentation/demo/demo.dart';
import 'package:exampur_mobile/presentation/downloads/downloads.dart';
import 'package:exampur_mobile/presentation/drawer/choose_category.dart';
import 'package:exampur_mobile/presentation/drawer/Parchase_course/my_purchases.dart';
import 'package:exampur_mobile/presentation/drawer/settings.dart';
import 'package:exampur_mobile/presentation/help/help.dart';
import 'package:exampur_mobile/presentation/my_courses/my_courses.dart';
import 'package:exampur_mobile/presentation/theme/custom_text_style.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:exampur_mobile/utils/dimensions.dart';
import 'package:exampur_mobile/utils/images.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:exampur_mobile/presentation/home/home.dart';
import 'package:launch_review/launch_review.dart';


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
  int _counter = 0;
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

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
  final List<Widget> widgetList = [
    Home(),
    Demo(),
    MyCourses(),
    Downloads(0),
    Help()
  ];

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
         _currIndex==0? Image.asset(Images.home,height: 30,width: 25,color: AppColors.amber):Image.asset(Images.home,height: 30,width: 25,)
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
       // FaIcon(FontAwesomeIcons.camera),
          _currIndex==2?   Image.asset(Images.mycourse2,height: 30,width: 25,):Image.asset(Images.mycourse,height: 30,width: 25,)
      ),
      ItemClass(
        3,
       getTranslated(context, StringConstant.downloads)!,
          _currIndex==3?   Image.asset(Images.download,height: 30,width: 25,color: AppColors.amber,):Image.asset(Images.download,height: 30,width: 25,)
      ),
      ItemClass(
        4,
          getTranslated(context, StringConstant.help)!,
          _currIndex==4?  Image.asset(Images.help,height: 30,width: 25,color: AppColors.amber): Image.asset(Images.help,height: 30,width: 25,)
      ),
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
                  AppConstants.sendAnalyticsEvent('SIDE_BAR_CLICKED');
                  Scaffold.of(context).openDrawer();});
          }),
          // title: InkWell(
          //   onTap: (){
          //     Navigator.push(
          //                     context,
          //                     MaterialPageRoute(
          //                         builder: (context) => const ChooseCategory()));
          //   },
          //   child: Row(children: [
          //     Text('UP Exam',style: TextStyle(color: AppColors.black),),
          //     Icon(Icons.arrow_drop_down)
          //   ],),
          // ),
          actions: [
            // IconButton(
            //     onPressed: () {
            //       Navigator.push(context,
            //           MaterialPageRoute(builder: (context) => SearchView()));
            //     },
            //     icon: const Icon(
            //       Icons.search_outlined,
            //       color: AppColors.black,
            //       size: 30.0,
            //     )),
            // const SizedBox(
            //   width: 20.0,
            // ),
// InkWell(
//   onTap: (){
//     Navigator.push(context,
//                   MaterialPageRoute(builder: (context) => SearchView()));
//   },
//   child:   Icon( Icons.search_outlined,
//
//                   color: AppColors.black,
//
//                   size: 30.0,),
// ),
//             InkWell(
//               onTap:() {
//             Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => const Notifications()));
//               },
//               child: Container(
//                // padding: EdgeInsets.all(8),
//                 margin:EdgeInsets.all(8) ,
//                 width: 30,
//                 height: 30,
//                 //color: Colors.amber,
//                 child: Stack(
//                   children: [
//                     Icon(
//                       Icons.notifications,
//                       color: Colors.black,
//                       size: 30,
//                     ),
//                     Container(
//                       width: 30,
//                       height: 30,
//                       alignment: Alignment.topRight,
//                       margin: EdgeInsets.only(top: 5),
//                       child: Container(
//                         width: 15,
//                         height: 15,
//                         decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                             color: Color(0xffc32c37),
//                             border: Border.all(color: Colors.white, width: 1)),
//                         child: Padding(
//                           padding: const EdgeInsets.all(0.0),
//                           child: Center(
//                             child: Text(
//                               _counter.toString(),
//                               style: TextStyle(fontSize: 10),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             )

            // Padding(
            //   padding: const EdgeInsets.only(right: 10.0),
            //   child: IconButton(
            //       onPressed: () {
            //         Navigator.push(
            //             context,
            //             MaterialPageRoute(
            //                 builder: (context) => const Notifications()));
            //       },
            //       icon: const Icon(
            //         Icons.notifications,
            //         color: AppColors.black,
            //         size: 30.0,
            //       )),
            // ),
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
                       // await  FirebaseAnalytics.instance.logEvent(name: 'COURSE',parameters: {
                       //    'id':'123456'
                       //  });

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
                    // ListTile(
                    //   dense: true,
                    //   title: Row(
                    //       mainAxisAlignment: MainAxisAlignment.start,
                    //       children: [
                    //         Image.asset(
                    //           Images.timetable,
                    //           width: 30,
                    //           height: 20,
                    //           color: AppColors.amber,
                    //         ),
                    //         SizedBox(
                    //           width: Dimensions.PADDING_SIZE_SMALL,
                    //         ),
                    //         RichText(
                    //           text: TextSpan(
                    //               style: CustomTextStyle.drawerText(context),
                    //               text: getTranslated(context, 'my_timetable')),
                    //         ),
                    //       ]),
                    //   onTap: () {
                    //     Navigator.push(
                    //         context,
                    //         MaterialPageRoute(
                    //             builder: (context) => MyTimeTable()));
                    //   },
                    // ),
                    // ListTile(
                    //   dense: true,
                    //   title: Row(
                    //       mainAxisAlignment: MainAxisAlignment.start,
                    //       children: [
                    //         Image.asset(
                    //           Images.calculator,
                    //           width: 30,
                    //           height: 20,
                    //           color: AppColors.amber,
                    //         ),
                    //         SizedBox(
                    //           width: Dimensions.PADDING_SIZE_SMALL,
                    //         ),
                    //         RichText(
                    //           text: TextSpan(
                    //               style: CustomTextStyle.drawerText(context),
                    //               text: getTranslated(context, 'eligibility_calculator')),
                    //         ),
                    //       ]),
                    //   onTap: () {
                    //     _scaffoldKey.currentState?.openEndDrawer();
                    //     Navigator.push(
                    //         context,
                    //         MaterialPageRoute(
                    //             builder: (context) => EligibilityCalculator()));
                    //   },
                    // ),
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
                                  text: getTranslated(context, 'log_out')
                              ),
                            ),
                          ]),
                      onTap: () {
                        AppConstants.sendAnalyticsEvent('LOGOUT_CLICKED');
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
        //  unselectedItemColor: AppColors.black,
          onTap: (index) {
            setState(() {
              _currIndex = index;
            });
          print('Anchal>>>>>>>>>>>>>>>>>>>>>>> $_currIndex');
          if(_currIndex == 1 || _currIndex == 2 || _currIndex == 3) {
            AppConstants.sendAnalyticsEvent(
                _currIndex == 1 ? 'DEMO_CLICKED' :
                _currIndex == 2 ? 'MY_COURSES_CLICKED' :
                'DOWNLOADS_CLICKED'
            );
          }
          },
          iconSize: 20,
selectedItemColor: AppColors.amber,

          unselectedFontSize: 12,
          selectedFontSize: 12,
          //unselectedLabelStyle: TextStyle(color: AppColors.amber),
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
