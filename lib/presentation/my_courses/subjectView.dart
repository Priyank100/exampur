import 'package:exampur_mobile/shared/scrolling%20text.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:exampur_mobile/utils/images.dart';
import 'package:flutter/material.dart';

class SubjectView extends StatefulWidget {
  const SubjectView({Key? key}) : super(key: key);

  @override
  _SubjectViewState createState() => _SubjectViewState();
}

class _SubjectViewState extends State<SubjectView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Text('Select Subject',style: TextStyle(fontSize: 25),),
        Expanded(
          child: CustomScrollView(slivers: [
            SliverGrid(
              delegate: SliverChildBuilderDelegate(
                    (context, index) {

                  return Container(
                    padding: EdgeInsets.all(9),
                    color: AppColors.transparent,
                    child: Column(children: [
                      CircleAvatar(
                        backgroundColor:
                        Colors.transparent,
                        backgroundImage:AssetImage(Images.jobalert),
                        radius: 40.0,
                      ),
                      // ScrollingText(
                      //   text:'Teacher name sie',
                      //   textStyle: TextStyle(fontSize: 12),
                      // )
Flexible(child: Text('Teacher name sir'))
                    ],),
                  );
                },
                childCount:20,
              ),
              gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 1,
                crossAxisSpacing: 1,
                childAspectRatio: 1.0,
              ),
            ),
          ]),
        ),
      ],),
    );
  }
}
