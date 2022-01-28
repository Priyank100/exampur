import 'dart:convert';
import 'dart:io' show Platform;

import 'package:exampur_mobile/Localization/language_constrants.dart';
import 'package:exampur_mobile/SharePref/shared_pref.dart';
import 'package:exampur_mobile/data/Pushnotification/pushnotification.dart';
import 'package:exampur_mobile/data/model/response/home_banner_model.dart';
import 'package:exampur_mobile/data/model/response/languagemodel.dart';
import 'package:exampur_mobile/presentation/PaymentRecieptpage/Receiptpage.dart';

import 'package:exampur_mobile/presentation/home/books/books_ebooks.dart';
import 'package:exampur_mobile/presentation/home/current_affairs/current_affairs.dart';
import 'package:exampur_mobile/presentation/home/home_banner.dart';
import 'package:exampur_mobile/presentation/home/job_alerts/job_alerts.dart';
import 'package:exampur_mobile/presentation/home/study_material/study_material.dart';

import 'package:exampur_mobile/presentation/theme/custom_text_style.dart';

import 'package:exampur_mobile/provider/Authprovider.dart';
import 'package:exampur_mobile/provider/HomeBannerProvider.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:exampur_mobile/utils/dimensions.dart';
import 'package:exampur_mobile/utils/images.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:exampur_mobile/presentation/home/paid_courses/paid_courses.dart';

import '../../main.dart';
import 'TestSeries/testseries.dart';

import 'dummytest.dart';
import 'dummytesting.dart';
import 'exampurone2one/exampurone2oneview.dart';
import 'offlinebatches/offline_course.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String userName = '';
  List<BannerData> bannerList = [];

  @override
  void initState() {
    super.initState();
    callProvider();
    LocalNotificationService.initialize(context);

    ///gives you the message on which user taps
    ///and it opened the app from terminated state
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if(message != null){
        final routeFromMessage = message.data["route"];

        Navigator.of(context).pushNamed(routeFromMessage);
      }
    });

    ///forground work
    FirebaseMessaging.onMessage.listen((message) {
      if(message.notification != null){
        print(message.notification!.body);
        print(message.notification!.title);
      }

      LocalNotificationService.display(message);
    });

    ///When the app is in background but opened and user taps
    ///on the notification
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      final routeFromMessage = message.data["route"];

      Navigator.of(context).pushNamed(routeFromMessage);
    });
    // getSharedPrefData();
  }

  Future<void> callProvider() async {
    userName = await Provider.of<AuthProvider>(context, listen: false)
        .informationModel
        .data!
        .firstName
        .toString();
    bannerList = (await Provider.of<HomeBannerProvider>(context, listen: false)
        .getHomeBannner(context))!;
    setState(() {});
  }

  Future<void> getSharedPrefData() async {
    var jsonValue = jsonDecode(
        await SharedPref.getSharedPref(SharedPrefConstants.USER_DATA));
    // AppConstants.printLog('priyank>> ${jsonValue.toString()}');
    userName = jsonValue[0]['data']['first_name'].toString();
    setState(() {});
  }

  void _changeLanguage(Language language) async {
    Locale _locale = await setLocale(language.languageCode);
    MyApp.setLocale(context, _locale);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  getTranslated(context, 'hello')! + ', ' + '${userName} !',
                  style: CustomTextStyle.headingMediumBold(context),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButton<Language>(
                    underline: SizedBox(),
                    icon: Icon(
                      Icons.language,
                      color: AppColors.black,
                      size: 30,
                    ),
                    onChanged: (Language? language) {
                      _changeLanguage(language!);
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
                  ),
                ),
              ],
            ),
            // SizedBox(height: 5),
            bannerList.length != 0
                ? LargeBanner(bannerList: bannerList)
                // : Container(
                //     child: ClipRRect(
                //       child: FadeInImage(
                //         fit: BoxFit.cover,
                //         image: NetworkImage(Images.noimage),
                //         placeholder: AssetImage(Images.noimage),
                //         imageErrorBuilder: (context, error, stackTrace) {
                //           return Image.asset(
                //             Images.noimage,
                //           );
                //         },
                //       ),
                //     ),
                //   ),
                : SizedBox(),
            SizedBox(height: Dimensions.FONT_SIZE_OVER_LARGE),
            Row(
              children: [
                SquareButton(
                    image: Images.paidcourse,
                    title: getTranslated(context, 'paid_course')!,
                    color: AppColors.paidCourses,
                    navigateTo: PaidCourses(1)),
                SquareButton(
                    image: Images.book,
                    title: getTranslated(context, 'free_courses')!,
                    color: AppColors.freeCourses,
                    navigateTo:PaidCourses(0)),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                SquareButton(
                    image: Images.free_course,
                    title: getTranslated(context, 'daily_quiz')!,
                    color: AppColors.quiz,
                    navigateTo: UploadImage()),

                SquareButton(
                    image: Images.testseries,
                    title: getTranslated(context, 'test_courses')!,
                    color: AppColors.series,
                    navigateTo: UploadImage()
                    //TestSeriesview()
                    ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                SquareButton(
                    image: Images.one2one,
                    title: getTranslated(context, 'job_alerts')!,
                    color: AppColors.jobAlert,
                    navigateTo:JobAlerts()),
                SquareButton(
                    image: Images.current_affair,
                    title: getTranslated(context, 'current_affairs')!,
                    color: AppColors.affairs,
                    navigateTo: CurrentAffairs()),
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
                    title: getTranslated(context, 'books')!,
                    color: AppColors.book,
                    navigateTo: BooksEbook()),

                SquareButton(
                    image: Images.studymaterial,
                    title: getTranslated(context, 'exampur_one2one')!,
                    color: AppColors.one2one,
                    navigateTo:  Exampuron2oneView()),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                // SquareButton(
                //     image: Images.current_affair,
                //     title: getTranslated(context, 'current_affairs')!,
                //     color: AppColors.affairs,
                //     navigateTo: CurrentAffairs()),

                SquareButton(
                    image: Images.dailyquiz,
                    title: getTranslated(context, 'study_materials')!,
                    color: AppColors.quiz,
                    navigateTo:
                        //SettingsScreen()
                        StudyMaterial()),
                // SquareButton(
                //     image: Images.jobalert,
                //     title: getTranslated(context, 'job_alerts')!,
                //     color: AppColors.jobAlert,
                //     navigateTo: JobAlerts()),
              ],
            ),
            SizedBox(
              height: 10,
            ),

          ],
        ),
      ),
    );
  }
}

class SquareButton extends StatelessWidget {
  final String? image;
  final String? title;
  final Widget? navigateTo;
  final Color? color;

  SquareButton(
      {@required this.image,
      @required this.title,
      @required this.navigateTo,
      this.color});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width - 40;
    return InkWell(
      onTap: () => Navigator.push(
          context, MaterialPageRoute(builder: (_) => navigateTo!)),
      child: Container(
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
                child: new Text(
              title!,
              style: TextStyle(color: AppColors.white, fontSize: 15),
            ))
          ],
        ),
      ),
    );
  }
}

class FrontStyleModel {
  late String name;
  String image;
  final color;

  FrontStyleModel(this.name, this.color, this.image);
}
