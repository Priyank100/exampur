import 'package:exampur_mobile/utils/images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(),
      body:Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Text('Notification',style: TextStyle(fontSize: 27,fontWeight:FontWeight.bold),),
              ListView.separated(
                itemCount: 10,
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Image.asset(Images.exampur_logo,height: 70,width: 70,),
                    title:Column (
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      Text('ytfrd'),
                        Text('ytfrd'),
                        Row(
                          children: [
                            Container(height: 10,width: 10,decoration: BoxDecoration(borderRadius:BorderRadius.circular(2) ),),
                            Text('ytfrd'),
                          ],
                        ),
                    ],)
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider();
                },
              )
          ],),
        ),
      )
    );
  }
}
