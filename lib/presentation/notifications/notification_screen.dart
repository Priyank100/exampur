import 'package:exampur_mobile/utils/appBar.dart';
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
      appBar: CustomAppBar(),
      body:Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Text('Notification',style: TextStyle(fontSize: 27,fontWeight:FontWeight.bold),),
              ListView.separated(
                itemCount: 10,
                padding: EdgeInsets.all(8),

                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Image.asset(Images.exampur_logo,height: 70,width: 70,),
                    title:Column (
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      Text('SSC CGL Tier-1 Parcham',style: TextStyle(fontSize: 19,fontWeight: FontWeight.bold)),
                        SizedBox(height:5,),
                      Text('Rajastan Police enroll now on paecham',style: TextStyle(fontSize: 13)),
                        SizedBox(height: 5,),
                        Row(
                          children: [
                            Container(height: 10,width: 10,decoration: BoxDecoration(borderRadius:BorderRadius.circular(10),color: Colors.amber ),),
                            SizedBox(width: 5,),
                            Text('12-01-2022 02:33 PM',style: TextStyle(fontSize: 12,fontWeight: FontWeight.normal),),
                          ],
                        ),
                    ],)
                  );
                },
                separatorBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 10.0,right: 10,),
                    child: Divider(thickness: 1,),
                  );
                },
              )
          ],),
        ),
      )
    );
  }
}
