import 'dart:io' show Platform;
import 'package:exampur_mobile/logic/bloc/user_bloc.dart';
import 'package:exampur_mobile/logic/bloc/user_events.dart';
import 'package:exampur_mobile/logic/bloc/user_state.dart';
import 'package:exampur_mobile/presentation/TestSeries/testseries.dart';
import 'package:exampur_mobile/presentation/home/books/books.dart';
import 'package:exampur_mobile/presentation/home/current_affairs/current_affairs.dart';
import 'package:exampur_mobile/presentation/home/job_alerts/job_alerts.dart';
import 'package:exampur_mobile/presentation/home/study_material/study_material.dart';
import 'package:exampur_mobile/presentation/home/quiz/test_series.dart';
import 'package:exampur_mobile/presentation/theme/custom_text_style.dart';
import 'package:exampur_mobile/presentation/widgets/large_carousel.dart';
import 'package:exampur_mobile/presentation/widgets/loading_indicator.dart';
import 'package:exampur_mobile/utils/dimensions.dart';
import 'package:exampur_mobile/utils/images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:exampur_mobile/presentation/notifications/notification_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:exampur_mobile/presentation/home/paid_courses/paid_courses.dart';

import '../oofline_course.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                if (state is UserEmpty) {
                  BlocProvider.of<UserBloc>(context).add(FetchUser());
                }
                if (state is UserError) {
                  return Text("Error no");
                }
                if (state is UserLoaded) {
                  return Text(
                    "Hello, ${state.user.firstName}!",
                    style: CustomTextStyle.headingBold(context),
                  );
                }
                return LoadingIndicator(context);
              },
            ),
            SizedBox(height: 10),
            LargeCarousel(image: [
              "https://www.w3.org/TR/wai-aria-practices/examples/carousel/images/lands-endslide__800x600.jpg"
            ]),
            SizedBox(height: Dimensions.FONT_SIZE_DEFAULT),
            Row(
              children: [
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const PaidCourses()));
                    },
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Row(
                          children: [
                            Image.asset(

                              Images.paidcourse,
                              height: 45.0,

                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 25.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text(
                                    'Paid',
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Text(
                                    'Courses',
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      height: 80.0,
                      decoration: BoxDecoration(

                          gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [Colors.purple, Colors.purpleAccent]),
                        borderRadius: BorderRadius.circular(12),
                       // color: Colors.purple,

                      ),
                    ),
                  ),
                )),
                Expanded(
                    child: Padding(
                  padding:
                      const EdgeInsets.only(right: 8.0, top: 8.0, bottom: 8.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Books()));
                    },
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:  [
                          Image.asset(

                            Images.book,
                            height: 45.0,

                          ),
                          SizedBox(
                            width: 20.0,
                          ),
                          Text(
                            'Books',
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      height: 80.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [Colors.green, Colors.green.shade300]),
                        //color: Colors.green[700],
                      ),
                    ),
                  ),
                )),
              ],
            ),
            Row(
              children: [
                Expanded(
                    child: Padding(
                  padding:
                      const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Row(
                          children: [
                            Image.asset(

                              Images.free_course,
                              height: 45.0,

                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 25.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text(
                                    'Free',
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Text(
                                    'Courses',
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      height: 80.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [ Colors.deepOrange,Colors.deepOrange.shade200]),
                        //color: Colors.deepOrange,
                      ),
                    ),
                  ),
                )),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.only(right: 8.0, bottom: 8.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TestSeriesview()));
                    },
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 30.0),
                        child: Row(
                          children: [
                            Image.asset(

                              Images.testseries,
                              height: 45.0,

                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text(
                                    'Test',
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Text(
                                    'Series',
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      height: 80.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [ Colors.red.shade700,Colors.redAccent.shade100]),
                        // color: Colors.red,
                      ),
                    ),
                  ),
                )),
              ],
            ),
            Row(
              children: [
                Expanded(
                    child: Padding(
                  padding:
                      const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Row(
                          children: [
                            Image.asset(

                              Images.one2one,
                              height: 45.0,

                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 25.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text(
                                    'Exampur',
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Text(
                                    'One2One',
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      height: 80.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [ Colors.green,Colors.green.shade300]),
                       // color: Colors.green,
                      ),
                    ),
                  ),
                )),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.only(right: 8.0, bottom: 8.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) =>OfflineCourse()));

                    },
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 30.0),
                        child: Row(
                          children: [
                            Image.asset(

                              Images.offlinebatch,
                              height: 45.0,

                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text(
                                    'Offline',
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Text(
                                    'Batches',
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      height: 80.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [ Colors.brown,Colors.brown.shade300]),
                        //color: Colors.brown,
                      ),
                    ),
                  ),
                )),
              ],
            ),
            Row(
              children: [
                Expanded(
                    child: Padding(
                  padding:
                      const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CurrentAffairs()));
                    },
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Row(
                          children: [
                            Image.asset(

                              Images.current_affair,
                              height: 45.0,

                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 25.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text(
                                    'Current',
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Text(
                                    'Affairs',
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      height: 80.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [ Colors.grey,Colors.grey.shade300]),
                       // color: Colors.grey,
                      ),
                    ),
                  ),
                )),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.only(right: 8.0, bottom: 8.0),
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 30.0),
                        child: Row(
                          children: [
                            Image.asset(

                              Images.dailyquiz,
                              height: 45.0,

                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 30.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text(
                                    'Daily',
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Text(
                                    'Quiz',
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      height: 80.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [ Colors.blue,Colors.blue.shade300]),
                        //color: Colors.blue,
                      ),
                    ),
                  ),
                )),
              ],
            ),
            Row(
              children: [
                Expanded(
                    child: Padding(
                  padding:
                      const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => JobAlerts()));
                    },
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Row(
                          children: [
                          Image.asset(

                             Images.jobalert,
                              height: 45.0,

                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 25.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text(
                                    'Job',
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Text(
                                    'Alerts',
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      height: 80.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [ Colors.green,Colors.green.shade200]),
                       // color: Colors.green[900],
                      ),
                    ),
                  ),
                )),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.only(right: 8.0, bottom: 8.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => StudyMaterial()));
                    },
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 30.0),
                        child: Row(
                          children: [
                            Image.asset(

                              Images.studymaterial,
                              height: 45.0,

                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text(
                                    'Study',
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Text(
                                    'Materials',
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      height: 80.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [ Colors.orangeAccent,Colors.orangeAccent.shade100]),
                        //color: Colors.orangeAccent,
                      ),
                    ),
                  ),
                )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
