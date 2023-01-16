import 'dart:async';
import 'dart:convert';
import 'package:exampur_mobile/Localization/language_constrants.dart';
import 'package:exampur_mobile/SharePref/shared_pref.dart';
import 'package:exampur_mobile/data/Pushnotification/pushnotification.dart';
import 'package:exampur_mobile/data/model/response/home_banner_model.dart';
import 'package:exampur_mobile/data/model/response/languagemodel.dart';
import 'package:exampur_mobile/presentation/DeliveryDetail/delivery_detail_screen.dart';
import 'package:exampur_mobile/presentation/home/books/books_ebooks.dart';
import 'package:exampur_mobile/presentation/home/ca_bytes/ca_bytes.dart';
import 'package:exampur_mobile/presentation/home/current_affairs/current_affairs.dart';
import 'package:exampur_mobile/presentation/home/daily_quiz/daily_quiz.dart';
import 'package:exampur_mobile/presentation/home/home_banner.dart';
import 'package:exampur_mobile/presentation/home/job_alert_new/job_notifications.dart';
import 'package:exampur_mobile/presentation/home/job_alerts/job_alerts.dart';
import 'package:exampur_mobile/presentation/home/paid_courses/offline_courses.dart';
import 'package:exampur_mobile/presentation/home/paid_courses/recorded_course_vod.dart';
import 'package:exampur_mobile/presentation/home/practice_question/practice_question_category.dart';
import 'package:exampur_mobile/presentation/home/study_material_new/study_material_new.dart';
import 'package:exampur_mobile/presentation/home/study_notes/study_notes_list.dart';
import 'package:exampur_mobile/presentation/home/test_series_new/test_series_new.dart';
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
import 'package:exampur_mobile/utils/refreshwidget.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:exampur_mobile/presentation/home/paid_courses/paid_courses.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:moengage_flutter/moengage_flutter.dart';
import '../../main.dart';
import '../../provider/ConfigProvider.dart';
import 'BannerBookDetailPage.dart';
import 'FreeVideos/freeVideo.dart';
import 'TestSeries/test_series_tab.dart';
import 'package:provider/provider.dart';

import 'banner_link_detail_page.dart';
import 'current_affairs_new/current_affairs_tab.dart';


class Home extends StatefulWidget {
  final List<BannerData> bannerList;
  const Home(this.bannerList, {Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String userName = '';
  // List<BannerData> bannerList = [];
  final keyRefresh = GlobalKey<RefreshIndicatorState>();
  String TOKEN = '';
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  MoEngageFlutter moengagePlugin = MoEngageFlutter();
  @override
  void initState() {
    super.initState();
    callProvider();
    getConfig();

    LocalNotificationService.initialize(context);

    ///gives you the message on which user taps and it opened the app from terminated state
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        List<String> actiondata = message.data['action'].split("/");

        if(actiondata[0] == "Course"){
          Navigator.of(context)
              .push(MaterialPageRoute(settings: RouteSettings(name: 'Direct'),
              builder: (_) => BannerLinkDetailPage('Course', actiondata[1],)));
          // AppConstants.goTo(context,
          //     BannerLinkDetailPage('Course', actiondata[1],
          //     ));

        } else if(actiondata[0] == "Combo Course"){
          Navigator.of(context)
              .push(MaterialPageRoute(
              settings: RouteSettings(name: 'Direct'),
              builder: (_) => BannerLinkDetailPage('Combo Course', actiondata[1],)));
          // AppConstants.goTo(context,
          //     BannerLinkDetailPage('Combo Course',actiondata[1],
          //     ));

        } else if(actiondata[0] == "Book"){

          AppConstants.goTo(context,   BannerLinkBookDetailPage('Book', actiondata[1],
          ));

        } else if (actiondata[0] == "youtube"){
          AppConstants.makeCallEmail("${actiondata[1]}");

        } else if(actiondata[0] == "https:"){
          AppConstants.makeCallEmail(message.data['action']);
        }
      }
    });

    ///foreground work
    FirebaseMessaging.onMessage.listen((message) {
      if (message.notification != null) {
        AppConstants.printLog(message.notification!.body);
        AppConstants.printLog(message.data['action']);
        AppConstants.printLog(message.notification!.title);
      }
      LocalNotificationService.display(message);
    });

    ///When the app is in background but opened and user taps on the notification
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      if (message != null) {
        List<String> actiondata =message.data['action'].split("/");

        if(actiondata[0] == "Course"){
          Navigator.of(context)
              .push(MaterialPageRoute(settings: RouteSettings(name: 'Direct'),
              builder: (_) => BannerLinkDetailPage('Course', actiondata[1],)));
          // AppConstants.goTo(context,
          //     BannerLinkDetailPage('Course', actiondata[1],
          //     ));

        }else if(actiondata[0] == "Combo Course"){
          Navigator.of(context)
              .push(MaterialPageRoute(settings: RouteSettings(name: 'Direct'),
              builder: (_) => BannerLinkDetailPage('Combo Course', actiondata[1],)));
          // AppConstants.goTo(context,
          //     BannerLinkDetailPage('Combo Course',actiondata[1],
          //     ));
        }
        else if(actiondata[0] == "Book"){
          AppConstants.goTo(context,   BannerLinkBookDetailPage('Book', actiondata[1],

          ));
        }
        else if (actiondata[0] == "youtube"){
          AppConstants.makeCallEmail("${actiondata[1]}");
        }else if(actiondata[0] == "https:"){
          AppConstants.makeCallEmail(message.data['action']);
        }
      }
    });
    // getSharedPrefData();

    moengagePlugin.setUpPushCallbacks((pushCampaign) {
      // print(pushCampaign.clickedAction.toString()+ '>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>.');

    });


  }

  clickNotification(RemoteMessage? message) {
    if (message != null) {
      List<String> actiondata =message.data['action'].split("/");
      // List<String> actiontype =message.data['actiontype'].split("/");

      if(actiondata[0] == "Course"){
        Navigator.of(context)
            .push(MaterialPageRoute(settings: RouteSettings(name: 'Direct'),
            builder: (_) => BannerLinkDetailPage('Course', actiondata[1],)));
        // AppConstants.goTo(context,
        //     BannerLinkDetailPage('Course', actiondata[1],
        //     ));

      }else if(actiondata[0] == "Combo Course"){
        Navigator.of(context)
            .push(MaterialPageRoute(settings: RouteSettings(name: 'Direct'),
            builder: (_) => BannerLinkDetailPage('Combo Course', actiondata[1],)));
        // AppConstants.goTo(context,
        //     BannerLinkDetailPage('Combo Course',actiondata[1],
        //     ));
      }
      else if(actiondata[0] == "Book"){
        AppConstants.goTo(context,   BannerLinkBookDetailPage('Book', actiondata[1],

        ));
      }
      else if (actiondata[0] == "youtube"){
        AppConstants.makeCallEmail("${actiondata[1]}");
      }else if(actiondata[0] == "https:"){
        AppConstants.makeCallEmail(message.data['action']);
      }
    }
  }

  Future<void> callProvider() async {
    userName = await Provider.of<AuthProvider>(context, listen: false)
        .informationModel
        .data!
        .firstName
        .toString();
    // String token = await Provider.of<AuthProvider>(context, listen: false).informationModel.data!.authToken.toString();
    await SharedPref.getSharedPref(SharedPref.TOKEN).then((token) async {
      TOKEN = token;
      AppConstants.selectedCategoryList = (await Provider.of<ChooseCategoryProvider>(context, listen: false).getSelectchooseCategoryList(context, token))!;
      // AppConstants.printLog(">>>>>>>>>>>"+ AppConstants.encodeCategory());
      // bannerList = (await Provider.of<HomeBannerProvider>(context, listen: false).getHomeBannner(context, AppConstants.encodeCategory()))!;
    });
    setState(() {});
  }

  Future<void> getConfig() async {
    await Provider.of<ConfigProvider>(context, listen: false)
        .getContentLog(context);
    await Provider.of<ConfigProvider>(
        context, listen: false).getDoubtCourseId(context);
    await Provider.of<ConfigProvider>(
        context, listen: false).getOfflineCourseId(context);
    setState(() {});
  }

  void _changeLanguage(Language language) async {
    Locale _locale = await setLocale(language.languageCode);
    MyApp.setLocale(context, _locale);
    var map = {
      'Page_Name':'Home_Page',
      'Mobile_Number':AppConstants.userMobile,
      'Language':language.languageCode,
      'Course_Category':AppConstants.selectedCategoryNameList.toString(),
      'User_ID':AppConstants.userMobile
    };
    if(language.languageCode == 'hi'){
      AnalyticsConstants.trackEventMoEngage(AnalyticsConstants.Click_Translate_Hindi,map);
    }
    else{
      AnalyticsConstants.trackEventMoEngage(AnalyticsConstants.Click_Translate_English,map);
    }

  }

  /*Future<void>_refreshScreen() async{
    bannerList.clear();
    return callProvider();
  }*/

  @override
  Widget build(BuildContext context) {
    // return RefreshWidget(
    //   keyRefresh: keyRefresh,
      // onRefresh:_refreshScreen,
      // child:
      return SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      getTranslated(context, LangString.hello)! +
                          ', ' +
                          '${userName} !',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(fontFamily: AppConstants.langCode == 'hi' ?'Noto Sans':'Poppins',fontSize: 20,fontWeight: FontWeight.bold),
                    ),
                  ),
                  DropdownButton<Language>(
                    underline: SizedBox(),
                    icon: Image.asset(
                      Images.language,
                      height: 35,
                      width: 30,
                    ),
                    onChanged: (Language? language) {
                      _changeLanguage(language!);
                      AppConstants.langCode = language.languageCode;
                    },
                    items: Language.languageList()
                        .map<DropdownMenuItem<Language>>(
                          (e) => DropdownMenuItem<Language>(
                            value: e,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Text(
                                  e.flag,
                                  style: TextStyle(fontSize: 30),
                                ),
                                Text(e.name)
                              ],
                            ),
                          ),
                        )
                        .toList(),
                  )
                ],
              ),
              // SizedBox(height: 5),
              widget.bannerList.length != 0
                  ? LargeBanner(bannerList: widget.bannerList)
                  : SizedBox(),
              SizedBox(height: Dimensions.FONT_SIZE_OVER_LARGE),
              Row(
                children: [
                  SquareButton(
                    image: Images.paidcourse,
                    title: getTranslated(context, LangString.paidCourse)!,
                    color: AppColors.paidCourses,
                    onPressed: () {
                      AnalyticsConstants.sendAnalyticsEvent(
                          AnalyticsConstants.paidCourseClick);
                      Map<String, Object> stuff = {};
                      AnalyticsConstants.logEvent(AnalyticsConstants.paidCourseClick,stuff);
                      Navigator.of(context, rootNavigator: true).push(
                          MaterialPageRoute(builder: (_) => PaidCourses(1,)));
                    },
                    // navigateTo: PaidCourses(1)
                  ),
                  SquareButton(
                    image: Images.vodImg,
                    title: 'Recorded Course (VOD)',
                    tagImage: Images.newImg,
                    color: AppColors.grey,
                    onPressed: () {
                      var map = {
                        'Page_Name':'Home_Page',
                        'Mobile_Number':AppConstants.userMobile,
                        'Language':AppConstants.langCode,
                        'Course_Category':AppConstants.selectedCategoryNameList.toString(),
                        'User_ID':AppConstants.userMobile
                      };
                     // AnalyticsConstants.trackEventMoEngage(AnalyticsConstants.Click_offline_Courses,map);
                      Navigator.of(context, rootNavigator: true).push(
                          MaterialPageRoute(builder: (_) => RecordedCourseVod()));
                    },
                    // navigateTo: PaidCourses(1)
                  ),

                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  SquareButton(
                    image: Images.offlinebatch,
                    title: getTranslated(context, LangString.offileCourse)!,
                    tagImage: Images.newImg,
                    color: AppColors.orange,
                    onPressed: () {
                      var map = {
                        'Page_Name':'Home_Page',
                        'Mobile_Number':AppConstants.userMobile,
                        'Language':AppConstants.langCode,
                        'Course_Category':AppConstants.selectedCategoryNameList.toString(),
                        'User_ID':AppConstants.userMobile
                      };
                      AnalyticsConstants.trackEventMoEngage(AnalyticsConstants.Click_offline_Courses,map);
                      Navigator.of(context, rootNavigator: true).push(
                          MaterialPageRoute(builder: (_) => OfflineCourse()));
                    },
                    // navigateTo: PaidCourses(1)
                  ),
                  SquareButton(
                    image: Images.free_course,
                    title: getTranslated(context, LangString.freeCourses)!,
                    color: AppColors.freeCourses,
                    onPressed: () {
                      var map = {
                        'Page_Name':'Home_Page',
                        'Mobile_Number':AppConstants.userMobile,
                        'Language':AppConstants.langCode,
                        'Course_Category':AppConstants.selectedCategoryNameList.toString(),
                        'User_ID':AppConstants.userMobile
                      };
                      AnalyticsConstants.trackEventMoEngage(AnalyticsConstants.Click_Free_Courses,map);
                      AnalyticsConstants.sendAnalyticsEvent(
                          AnalyticsConstants.freeCourseClick);
                      Map<String, Object> stuff = {};
                      AnalyticsConstants.logEvent(AnalyticsConstants.freeCourseClick,stuff);
                      Navigator.of(context, rootNavigator: true).push(
                          MaterialPageRoute(builder: (_) => PaidCourses(0)));
                    },
                  ),


                  // SquareButton(
                  //     image: Images.one2one,
                  //     title: getTranslated(context, 'exampur_one2one')!,
                  //     color: AppColors.one2one,
                  //     navigateTo:
                  //     Exampuron2oneView()
                  // ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  SquareButton(
                    image: Images.book,
                    tagImage:Images.offerImg ,
                    title: getTranslated(context, 'books')!,
                    color: AppColors.book,
                    onPressed: () {
                      AnalyticsConstants.sendAnalyticsEvent(
                          AnalyticsConstants.booksClick);
                      Map<String, Object> stuff = {};
                      AnalyticsConstants.logEvent(AnalyticsConstants.booksClick,stuff);
                      Navigator.of(context, rootNavigator: true)
                          .push(MaterialPageRoute(builder: (_) => BooksEbook()));
                    },
                  ),
                  SquareButton(
                    image: Images.testseries,
                    title: getTranslated(context, 'test_courses')!,
                    color: AppColors.series,
                    onPressed: () async {
                      var map = {
                        'Page_Name':'Home_Page',
                        'Mobile_Number':AppConstants.userMobile,
                        'Language':AppConstants.langCode,
                        'Course_Category':AppConstants.selectedCategoryNameList.toString(),
                        'User_ID':AppConstants.userMobile
                      };
                      AnalyticsConstants.trackEventMoEngage(AnalyticsConstants.Click_Test_Series,map);
                      AnalyticsConstants.sendAnalyticsEvent(
                          AnalyticsConstants.testSeriesClick);
                      Navigator.of(context, rootNavigator: true)
                          .push(MaterialPageRoute(
                          builder: (_) =>
                          //   TestSeriesTab()
                          TestSeriesNew(API.testSeriesWebUrl, TOKEN))).then((value) {
                        AppConstants.checkRatingCondition(context, false);
                      });
                    },
                  ),

                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  SquareButton(
                    image: Images.dailyquiz,
                    title: getTranslated(context, LangString.Quizz),
                    color: AppColors.quiz,
                    onPressed: () async {
                      var map = {
                        'Page_Name':'Home_Page',
                        'Mobile_Number':AppConstants.userMobile,
                        'Language':AppConstants.langCode,
                        'Course_Category':AppConstants.selectedCategoryNameList.toString(),
                        'User_ID':AppConstants.userMobile
                      };
                      AnalyticsConstants.trackEventMoEngage(AnalyticsConstants.Click_Quiz,map);
                      Navigator.of(context, rootNavigator: true).push(
                          MaterialPageRoute(
                              builder: (_) =>
                                  TestSeriesNew(API.quizzesWebUrl, TOKEN)));
                    },
                  ),

                  SquareButton(
                    image: Images.studymaterial,
                    title: getTranslated(context, 'study_materials')!,
                    color: AppColors.one2one,
                    onPressed: () {
                      var map = {
                        'Page_Name':'Home_Page',
                        'Mobile_Number':AppConstants.userMobile,
                        'Language':AppConstants.langCode,
                        'Course_Category':AppConstants.selectedCategoryNameList.toString(),
                        'User_ID':AppConstants.userMobile
                      };
                      AnalyticsConstants.trackEventMoEngage(AnalyticsConstants.Click_Study_Material,map);
                      Navigator.of(context, rootNavigator: true)
                          .push(MaterialPageRoute(
                          builder: (_) =>
                          // CurrentAffairs(getTranslated(context, 'study_materials')!, AppConstants.studyMaterialsId)
                          StudyMaterialNew(0)));
                    },
                  ),

                  // SquareButton(
                  //     image: Images.offlinebatch,
                  //     title: getTranslated(context, 'offline_batches')!,
                  //     color: AppColors.brown400,
                  //     navigateTo: OfflineCourse()),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  SquareButton(
                    image: Images.jobalert,
                    title: getTranslated(context, 'job_alerts')!,
                    color: AppColors.jobAlert,
                    onPressed: () {
                      var map = {
                        'Page_Name':'Home_Page',
                        'Mobile_Number':AppConstants.userMobile,
                        'Language':AppConstants.langCode,
                        'Course_Category':AppConstants.selectedCategoryNameList.toString(),
                        'User_ID':AppConstants.userMobile
                      };
                      AnalyticsConstants.trackEventMoEngage(AnalyticsConstants.Click_Job_Alerts,map);
                      Navigator.of(context, rootNavigator: true)
                          .push(MaterialPageRoute(builder: (_) =>
                      // JobAlerts()
                      JobNotifications()
                      ));
                    },
                  ),

                  SquareButton(
                    image: Images.current_affair,
                    title: getTranslated(context, 'current_affairs')!,
                    color: AppColors.affairs,
                    onPressed: () {
                      var map = {
                        'Page_Name':'Home_Page',
                        'Mobile_Number':AppConstants.userMobile,
                        'Language':AppConstants.langCode,
                        'Course_Category':AppConstants.selectedCategoryNameList.toString(),
                        'User_ID':AppConstants.userMobile
                      };
                      AnalyticsConstants.trackEventMoEngage(AnalyticsConstants.Click_Current_Affairs,map);
                      AnalyticsConstants.sendAnalyticsEvent(
                          AnalyticsConstants.currentAffairsClick);
                      Map<String, Object> stuff = {};
                      AnalyticsConstants.logEvent(AnalyticsConstants.currentAffairsClick,stuff);

                      // Navigator.of(context, rootNavigator: true).push(
                      //     MaterialPageRoute(
                      //         builder: (_) => CurrentAffairs(
                      //             getTranslated(context, 'current_affairs')!,
                      //             AppConstants.currentAffairesId)));

                      Navigator.of(context, rootNavigator: true).push(
                          MaterialPageRoute(
                              settings: RouteSettings(name: "CAN"),
                              builder: (_) => CurrentAffairsTab()));
                    },
                  ),
                  // SquareButton(
                  //   image: Images.caBytes,
                  //   title: getTranslated(context, LangString.CaBytes)!,
                  //   color: AppColors.jobAlert,
                  //   onPressed: () {
                  //     Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(builder: (_) => CaBytes()));
                  //
                  //     // own player testing
                  //     /*Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(builder: (_) =>
                  //         PriyankPlayer('Priyank Video Player',
                  //             'https://downloadexampur.appx.co.in/paid_course/0.46657945645736841649068141070.mp4')));*/
                  //   },
                  // ),


                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  SquareButton(
                    image: Images.studymaterial,
                    title: getTranslated(context, LangString.PreviousYearPdf),
                    color: AppColors.paidCourses,
                    onPressed: () {
                      var map = {
                        'Page_Name':'Home_Page',
                        'Mobile_Number':AppConstants.userMobile,
                        'Language':AppConstants.langCode,
                        'Course_Category':AppConstants.selectedCategoryNameList.toString(),
                        'User_ID':AppConstants.userMobile
                      };
                      AnalyticsConstants.trackEventMoEngage(AnalyticsConstants.Click_Previous_Year_PDF,map);
                      Navigator.of(context, rootNavigator: true).push(
                          MaterialPageRoute(
                              builder: (_) =>
                                  StudyMaterialNew(1)));
                    },
                  ),
                  SquareButton(
                    image: Images.practice,
                    title: getTranslated(context, LangString.PracticeQuestion)!,
                    color: AppColors.brown400,
                    onPressed: () {
                      var map = {
                        'Page_Name':'Home_Page',
                        'Mobile_Number':AppConstants.userMobile,
                        'Language':AppConstants.langCode,
                        'Course_Category':AppConstants.selectedCategoryNameList.toString(),
                        'User_ID':AppConstants.userMobile
                      };
                      AnalyticsConstants.trackEventMoEngage(AnalyticsConstants.Click_Practice_Questions,map);
                      Navigator.of(context, rootNavigator: true).push(
                          MaterialPageRoute(
                              builder: (_) => PracticeQuestionCategory()));
                    },
                  ),

                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  SquareButton(
                    image: Images.live_test,
                    title: getTranslated(context, LangString.liveTest),
                    color: AppColors.orange,
                    onPressed: () async {
                      var map = {
                        'Page_Name':'Home_Page',
                        'Mobile_Number':AppConstants.userMobile,
                        'Language':AppConstants.langCode,
                        'Course_Category':AppConstants.selectedCategoryNameList.toString(),
                        'User_ID':AppConstants.userMobile
                      };
                      AnalyticsConstants.trackEventMoEngage(AnalyticsConstants.Click_Live_Test,map);
                      Navigator.of(context, rootNavigator: true).push(
                          MaterialPageRoute(
                              builder: (_) =>
                                  TestSeriesNew(API.liveTestWebUrl, TOKEN))).then((value) {
                        AppConstants.checkRatingCondition(context, false);
                      });
                    },
                  ),
                  // SquareButton(
                  //   image: Images.current_affair,
                  //   title: 'Study Notes',
                  //   color: AppColors.paidCourses,
                  //   onPressed: () {
                  //     Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(builder: (_) => StudyNotesList(API.studynotesUrl)));
                  //   },
                  // ),
                  // SquareButton(
                  //   image: Images.current_affair,
                  //   title: 'Free Videos',
                  //   color: AppColors.paidCourses,
                  //   onPressed: () {
                  //     Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(builder: (_) => FreeVideos(API.freeVideoUrl)));
                  //   },
                  // ),
                ],
              ),
            ],
          ),
        // ),
      ),
    );
  }
}

class SquareButton extends StatelessWidget {
  final String? image;
  final String? tagImage;
  final String? title;
  final VoidCallback onPressed;
  final Color? color;

  SquareButton(
      {@required this.image,
        this.tagImage,
      @required this.title,
      required this.onPressed,
      this.color});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width - 40;
    return InkWell(
      onTap: () {
        onPressed();
      },
      child: Stack(
        children:[
          Container(
        width: width / 2,
        height: 80,
        padding: EdgeInsets.all(8),
        margin: EdgeInsets.only(left: 5, right: 5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: color!),
        child: Row(
          children: [
            Image.asset(
              image!,
              fit: BoxFit.fill,
              height: 40,
              width: 40,
            ),
            SizedBox(
              width: 15,
            ),
            Flexible(
                child: Text(
              title!,
              style: TextStyle(color: AppColors.white, fontSize: 15,fontFamily: AppConstants.langCode == 'hi' ?'Noto Sans':'Poppins'),
            )),
         SizedBox(width: 10,),
          ],
        ),
      ),
          tagImage == null ? SizedBox() : Positioned(
            right: 0,
              child: Container(
                  margin: EdgeInsets.only(right: 5),
                  child: Image.asset(tagImage!, scale: 2.5,))
          )
      ],
      ) );
  }
}
