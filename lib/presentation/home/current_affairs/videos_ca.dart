import 'package:exampur_mobile/presentation/theme/custom_text_style.dart';
import 'package:exampur_mobile/utils/images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VideosCA extends StatefulWidget {
  @override
  _VideosCAState createState() => _VideosCAState();
}

class _VideosCAState extends State<VideosCA> {
  List<String> videoList = [
    'https://www.youtube.com/watch?v=ZoOwI3P5POo',
    'https://www.youtube.com/watch?v=ZoOwI3P5POo',
    'https://www.youtube.com/watch?v=ZoOwI3P5POo'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Current Affairs',  style: CustomTextStyle.headingBold(context),),
          ),
          ListView.builder(
              itemCount: videoList.length,
              itemBuilder: (context, index) {
                return myCard(index);
              }
          ),
        ],
      ),
    ));
  }

  Widget myCard(index) {
    return Container(
      height: MediaQuery.of(context).size.width/1.1,
      margin: EdgeInsets.all(10),
      child: Card(
        child: Column(
          children: [
            Align(
              alignment: FractionalOffset.topCenter,
              child: InkWell(
                  onTap: () {},
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.width/2.2,
                    child: Image.asset(Images.exampur_logo),
                  )
              ),
            ),
            Expanded(
              child: Container(
                  padding: EdgeInsets.all(10),
                  child: Text(
                      "Abcd efghij klmn opqrs tuvwx yz.")
              ),
            ),
            Align(
              alignment: FractionalOffset.bottomCenter,
              child: InkWell(
                onTap: () {},
                child: Container(
                  height: 50,
                  color: Colors.amber,
                  alignment: Alignment.center,
                  child: Text('Watch Now', style: TextStyle(color: Colors.white),),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

