import 'package:exampur_mobile/presentation/home/current_affairs/bytes_ca.dart';
import 'package:exampur_mobile/presentation/home/current_affairs/daily_ca.dart';
import 'package:exampur_mobile/presentation/home/current_affairs/monthly_ca.dart';
import 'package:exampur_mobile/presentation/home/current_affairs/quiz_ca.dart';
import 'package:exampur_mobile/presentation/home/current_affairs/videos_ca.dart';
import 'package:exampur_mobile/presentation/widgets/custom_tab_bar.dart';
import 'package:flutter/material.dart';

class PaidCourses extends StatefulWidget {
  const PaidCourses({Key? key}) : super(key: key);

  @override
  _PaidCoursesState createState() => _PaidCoursesState();
}

class _PaidCoursesState extends State<PaidCourses> {
  Set<String> selected = new Set<String>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomTabBar(
          length:14 ,
          names: ["Home", "AllCourse", "Teaching", "Defence", "Civil Services","Banking","UPSSSC","Rajasthan","Railways","All Competetive Exam","ENGINEERING","OFFLINE","State Police","IT"],
          routes: [
            VideosCA(),
            DailyCA(),
            MonthlyCA(),
            QuizCA(),
            BytesCA(),
            VideosCA(),
            VideosCA(),
            VideosCA(),
            VideosCA(),
            VideosCA(),
            VideosCA(),
            VideosCA(),
            VideosCA(),
            VideosCA(),
          ],
          title: "Paid Courses"),
      // body: Center(
      //   child: ListView(
      //     children: [
      //       // todo:just pass the objects of the models (which are yet to be created)
      //       // CourseCard(subject: "English", name: "IAS PCS 2022-23 BATCH"),
      //       // BigCourseCard(subject: "English", name: "IAS PCS 2022-23 BATCH"),
      //       // BooksCard(subject: "English", name: "IAS PCS 2022-23 BATCH"),
      //       // EBooksCard(subject: "English", name: "April Magzine"),
      //       // FreeCourseCard(subject: "subject", name: "UPHES / General Studies"),
      //       // One2OneCard(subject: "subject", name: "BPSC TARGET BATCH 01"),
      //       // OnlineBatchesCard(subject: "subject", name: "AGRA"),
      //       // DropDownSelector(items: ["name", "address", "age", "class", "aadhar no.", "etc"], setValue: (value) {}),
      //       MultiSelect(
      //         function: (value) {
      //           setState(() {
      //             selected = value;
      //           });
      //         },
      //         options: [
      //           "subject1",
      //           "subject2",
      //           "subject3",
      //           "subject4",
      //           "subject5",
      //           "subject6",
      //           "subject7",
      //           "subject8"
      //         ],
      //         selected: selected,
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
