import 'dart:io';
import 'package:exampur_mobile/data/model/daily_monthly_ca_model.dart';
import 'package:exampur_mobile/data/model/video_ca_model.dart';
import 'package:exampur_mobile/presentation/home/current_affairs/bytes_ca.dart';
import 'package:exampur_mobile/presentation/home/current_affairs/daily_monthly_ca.dart';
import 'package:exampur_mobile/presentation/home/current_affairs/quiz_ca.dart';
import 'package:exampur_mobile/presentation/home/current_affairs/videos_ca.dart';
import 'package:exampur_mobile/presentation/widgets/custom_tab_bar.dart';
import 'package:exampur_mobile/utils/images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CurrentAffairs extends StatefulWidget {
  @override
  CurrentAffairsState createState() => CurrentAffairsState();
}

class CurrentAffairsState extends State<CurrentAffairs> {
  List<VideoCaModel> videoList = [];
  List<DailyMonthlyCaModel> dailyCaList = [];
  List<DailyMonthlyCaModel> monthlyCaList = [];

  @override
  void initState() {
    super.initState();
    videoList.add(VideoCaModel(
        videoPath: 'https://www.youtube.com/watch?v=ZoOwI3P5POo',
        imagePath: Images.no_image,
        title: '15 Days Free Foundation Batch Class'));
    videoList.add(VideoCaModel(
        videoPath: 'https://www.youtube.com/watch?v=ZoOwI3P5POo',
        imagePath: Images.no_image,
        title: '15 Days Free Foundation Batch Class'));
    videoList.add(VideoCaModel(
        videoPath: 'https://www.youtube.com/watch?v=ZoOwI3P5POo',
        imagePath: Images.no_image,
        title: '15 Days Free Foundation Batch Class'));
    videoList.add(VideoCaModel(
        videoPath: 'https://www.youtube.com/watch?v=ZoOwI3P5POo',
        imagePath: Images.no_image,
        title: '15 Days Free Foundation Batch Class'));
    videoList.add(VideoCaModel(
        videoPath: 'https://www.youtube.com/watch?v=ZoOwI3P5POo',
        imagePath: Images.no_image,
        title: '15 Days Free Foundation Batch Class'));
    videoList.add(VideoCaModel(
        videoPath: 'https://www.youtube.com/watch?v=ZoOwI3P5POo',
        imagePath: Images.no_image,
        title: '15 Days Free Foundation Batch Class'));
    videoList.add(VideoCaModel(
        videoPath: 'https://www.youtube.com/watch?v=ZoOwI3P5POo',
        imagePath: Images.no_image,
        title: '15 Days Free Foundation Batch Class'));
    videoList.add(VideoCaModel(
        videoPath: 'https://www.youtube.com/watch?v=ZoOwI3P5POo',
        imagePath: Images.no_image,
        title: '15 Days Free Foundation Batch Class'));

    dailyCaList.add(DailyMonthlyCaModel(
      imagePath: Images.exampur_logo,
      title: '15 Days Free Foundation Batch Class',
      viewId: '123',
      viewCount: '100,000+',
      shareText: 'Current affairs daily'
    ));
    dailyCaList.add(DailyMonthlyCaModel(
        imagePath: Images.exampur_logo,
        title: '15 Days Free Foundation Batch Class',
        viewId: '123',
        viewCount: '100,000+',
        shareText: 'Current affairs daily'
    ));
    dailyCaList.add(DailyMonthlyCaModel(
        imagePath: Images.exampur_logo,
        title: '15 Days Free Foundation Batch Class',
        viewId: '123',
        viewCount: '100,000+',
        shareText: 'Current affairs daily'
    ));
    dailyCaList.add(DailyMonthlyCaModel(
        imagePath: Images.exampur_logo,
        title: '15 Days Free Foundation Batch Class',
        viewId: '123',
        viewCount: '100,000+',
        shareText: 'Current affairs daily'
    ));
    dailyCaList.add(DailyMonthlyCaModel(
        imagePath: Images.exampur_logo,
        title: '15 Days Free Foundation Batch Class',
        viewId: '123',
        viewCount: '100,000+',
        shareText: 'Current affairs daily'
    ));
    dailyCaList.add(DailyMonthlyCaModel(
        imagePath: Images.exampur_logo,
        title: '15 Days Free Foundation Batch Class',
        viewId: '123',
        viewCount: '100,000+',
        shareText: 'Current affairs daily'
    ));
    dailyCaList.add(DailyMonthlyCaModel(
        imagePath: Images.exampur_logo,
        title: '15 Days Free Foundation Batch Class',
        viewId: '123',
        viewCount: '100,000+',
        shareText: 'Current affairs daily'
    ));

    monthlyCaList.add(DailyMonthlyCaModel(
        imagePath: Images.exampur_logo,
        title: '15 Days Free Foundation Batch Class',
        viewId: '123',
        viewCount: '100,000+',
        shareText: 'Current affairs daily'
    ));
    monthlyCaList.add(DailyMonthlyCaModel(
        imagePath: Images.exampur_logo,
        title: '15 Days Free Foundation Batch Class',
        viewId: '123',
        viewCount: '100,000+',
        shareText: 'Current affairs daily'
    ));
    monthlyCaList.add(DailyMonthlyCaModel(
        imagePath: Images.exampur_logo,
        title: '15 Days Free Foundation Batch Class',
        viewId: '123',
        viewCount: '100,000+',
        shareText: 'Current affairs daily'
    ));
    monthlyCaList.add(DailyMonthlyCaModel(
        imagePath: Images.exampur_logo,
        title: '15 Days Free Foundation Batch Class',
        viewId: '123',
        viewCount: '100,000+',
        shareText: 'Current affairs daily'
    ));
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomTabBar(
            length: 5,
            names: ["Videos", "Daily", "Monthly", "Quiz", "Bytes"],
            routes: [
              VideosCA(videoList),
              DailyMonthlyCA(dailyCaList),
              DailyMonthlyCA(monthlyCaList),
              QuizCA(),
              BytesCA(),
            ],
            title: "Current Affairs")
    );
  }
}
