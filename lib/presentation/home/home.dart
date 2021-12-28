import 'dart:convert';
import 'dart:io' show Platform;

import 'package:exampur_mobile/Localization/language_constrants.dart';
import 'package:exampur_mobile/SharePref/shared_pref.dart';
import 'package:exampur_mobile/data/model/UserInformationModel.dart';
import 'package:exampur_mobile/data/model/response/HomeBannerModel.dart';
import 'package:exampur_mobile/presentation/home/books/books.dart';
import 'package:exampur_mobile/presentation/home/current_affairs/current_affairs.dart';
import 'package:exampur_mobile/presentation/home/dummyBanner.dart';
import 'package:exampur_mobile/presentation/home/job_alerts/job_alerts.dart';
import 'package:exampur_mobile/presentation/home/study_material/study_material.dart';
import 'package:exampur_mobile/presentation/home/quiz/test_series.dart';
import 'package:exampur_mobile/presentation/theme/custom_text_style.dart';
import 'package:exampur_mobile/presentation/widgets/large_carousel.dart';
import 'package:exampur_mobile/presentation/widgets/loading_indicator.dart';
import 'package:exampur_mobile/provider/Authprovider.dart';
import 'package:exampur_mobile/provider/HomeBannerProvider.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:exampur_mobile/utils/dimensions.dart';
import 'package:exampur_mobile/utils/images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:exampur_mobile/presentation/notifications/notification_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:exampur_mobile/presentation/home/paid_courses/paid_courses.dart';

import 'TestSeries/testseries.dart';
import 'dummytest.dart';
import 'exampurone2one/exampurone2oneview.dart';
import 'offlinebatches/oofline_course.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String userName = '';

  @override
  void initState()  {
    super.initState();
    callProvider();
    getSharedPrefData();
  }

  Future<void> callProvider() async {
    await Provider.of<HomeBannerProvider>(context, listen: false).getHomeBannner(context);
  // await Provider.of<AuthProvider>(context,listen: false).login();
  }

  Future<void> getSharedPrefData() async {
    var jsonValue =  jsonDecode(await SharedPref.getSharedPref(AppConstants.USER_DATA));
    AppConstants.printLog('priyank>> ${jsonValue.toString()}');
    userName = jsonValue[0]['data']['first_name'].toString();
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
        // Consumer<UserInformationModel>(
        // builder: (context, userInformationProvider, child) {
        //   return Text(userInformationProvider.data!.firstName.toString());
        // }),
            Text('Hello, ${userName} !', style:CustomTextStyle.headingMediumBold(context),),
            SizedBox(height: 15),

            // LargeCarousel(image: ["https://www.w3.org/TR/wai-aria-practices/examples/carousel/images/lands-endslide__800x600.jpg"]),

            // Consumer<HomeBannerProvider>(
            //     builder: (context, bannerProvider, child) {
            //   return  bannerProvider.homeBannerModel.length!= 0 ?
            //   LargeBanner(bannerModel: bannerProvider.homeBannerModel):Container( child: ClipRRect(
            //     child: FadeInImage(
            //       fit: BoxFit.cover,
            //       image: NetworkImage('assets/images/no_image.jpg'),
            //       placeholder: AssetImage("assets/images/no_image.jpg"),
            //       imageErrorBuilder: (context, error, stackTrace) {
            //         return Image.asset(
            //           'assets/images/no_image.jpg',
            //         );
            //       },
            //     ),
            //   ),);
            // }),

            SizedBox(height: Dimensions.FONT_SIZE_DEFAULT),



            Row(
              children: [
                SquareButton(image: Images.paidcourse, title: 'Paid Courses',color: Colors.purple, navigateTo:Dummytest()),
                SizedBox(width: 10,),
                SquareButton(image: Images.book, title: 'Books',color: Colors.green, navigateTo:Books()),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              children: [
                SquareButton(image: Images.free_course, title: 'Free courses',color: Colors.deepOrange, navigateTo:StudyMaterial()),
                SizedBox(width: 10,),
                SquareButton(image: Images.testseries, title: 'Test Series',color: Colors.red, navigateTo:TestSeriesview()),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              children: [
                SquareButton(image: Images.one2one, title: 'Exampur one2one',color: Colors.green, navigateTo:Exampuron2oneView()),
                SizedBox(width: 10,),
                SquareButton(image: Images.offlinebatch, title: 'offline Batches',color: Colors.brown, navigateTo:OfflineCourse()),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              children: [
                SquareButton(image: Images.current_affair, title: 'Current Affairs',color: Colors.grey, navigateTo:CurrentAffairs()),
                SizedBox(width: 10,),
                SquareButton(image: Images.dailyquiz, title: 'Daily Quiz',color: Colors.blue, navigateTo:StudyMaterial()),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              children: [
                SquareButton(image: Images.jobalert, title: 'Job Alerts',color: Colors.green, navigateTo:JobAlerts()),
                SizedBox(width: 10,),
                SquareButton(image: Images.studymaterial, title: 'Studu Materials',color: Colors.orangeAccent, navigateTo:StudyMaterial()),
              ],
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

  SquareButton({@required this.image, @required this.title, @required this.navigateTo,this.color});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width - 40;
    return InkWell(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => navigateTo!)),
      child: Container(
          width: width / 2,
          height: 80,
          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
              color: color!
          ),
          child: Row(
            children: [
              Image.asset(image!, ),
              SizedBox(width: 15,),
              Flexible(
                  child: new Text(title!,style: TextStyle(color: Colors.white),))
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