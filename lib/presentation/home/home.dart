import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:exampur_mobile/presentation/notifications/notification_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:exampur_mobile/presentation/paid_courses/paid_courses.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
            child: SingleChildScrollView(
              child: Column(
                children: const [
                  Text(
                    'App Logo Here',
                  ),
                  /*Row(
                  children: const [
                    Icon(Icons.touch_app,color: Colors.grey,),
                  ],
                ),*/
                ],
              ),
            )
        ),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(65.0),
          child: AppBar(
            iconTheme: const IconThemeData(color: Colors.black),
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            elevation: 0,
            actions:  [
              InkWell(
                  onTap: () {},
                  child: const Icon(Icons.search_outlined, color: Colors.black, size: 30.0,)),
              const SizedBox(
                width: 20.0,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const Notifications()));
                    },
                    child: const Icon(Icons.notifications, color: Colors.black, size: 30.0,)),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 250.0,
                child: const Text('Images Here'),
              ),
              Row(
                children: [
                  Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const PaidCourses()));
                          },
                          child: Container(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: Row(
                                children: [
                                  const Icon(Icons.movie_filter_outlined,size: 45.0,color: Colors.white,),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 25.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: const [
                                        Text(
                                          'Paid',
                                          style: TextStyle(fontSize: 18.0, color: Colors.white,),),
                                        SizedBox(height: 5.0,),
                                        Text(
                                          'Courses',
                                          style: TextStyle(fontSize: 18.0, color: Colors.white,),),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            height: 80.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.purple,
                            ),
                          ),
                        ),
                      )
                  ),
                  Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8.0,top: 8.0,bottom: 8.0),
                        child: InkWell(
                          onTap: () {},
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(Icons.book,size: 45.0,color: Colors.white,),
                                SizedBox(width: 20.0,),
                                Text(
                                  'Books',
                                  style: TextStyle(fontSize: 18.0, color: Colors.white,),),
                              ],
                            ),
                            height: 80.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.green[700],
                            ),
                          ),
                        ),
                      )
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0,right: 8.0,bottom: 8.0),
                        child: InkWell(
                          onTap: () {},
                          child: Container(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: Row(
                                children: [
                                  const Icon(Icons.movie_rounded,size: 45.0,color: Colors.white,),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 25.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: const [
                                        Text(
                                          'Free',
                                          style: TextStyle(fontSize: 18.0, color: Colors.white,),),
                                        SizedBox(height: 5.0,),
                                        Text(
                                          'Courses',
                                          style: TextStyle(fontSize: 18.0, color: Colors.white,),),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            height: 80.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.deepOrange,
                            ),
                          ),
                        ),
                      )
                  ),
                  Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8.0,bottom: 8.0),
                        child: InkWell(
                          onTap: () {},
                          child: Container(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 30.0),
                              child: Row(
                                children: [
                                  const Icon(Icons.fact_check,size: 45.0,color: Colors.white,),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: const [
                                        Text(
                                          'Test',
                                          style: TextStyle(fontSize: 18.0, color: Colors.white,),),
                                        SizedBox(height: 5.0,),
                                        Text(
                                          'Series',
                                          style: TextStyle(fontSize: 18.0, color: Colors.white,),),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            height: 80.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.red,
                            ),
                          ),
                        ),
                      )
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0,right: 8.0,bottom: 8.0),
                        child: InkWell(
                          onTap: () {},
                          child: Container(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: Row(
                                children: [
                                  const Icon(Icons.account_balance,size: 45.0,color: Colors.white,),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 25.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: const [
                                        Text(
                                          'Exampur',
                                          style: TextStyle(fontSize: 18.0, color: Colors.white,),),
                                        SizedBox(height: 5.0,),
                                        Text(
                                          'One2One',
                                          style: TextStyle(fontSize: 18.0, color: Colors.white,),),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            height: 80.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.green,
                            ),
                          ),
                        ),
                      )
                  ),
                  Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8.0,bottom: 8.0),
                        child: InkWell(
                          onTap: () {},
                          child: Container(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 30.0),
                              child: Row(
                                children: [
                                  const Icon(Icons.room_preferences,size: 45.0,color: Colors.white,),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: const [
                                        Text(
                                          'Offline',
                                          style: TextStyle(fontSize: 18.0, color: Colors.white,),),
                                        SizedBox(height: 5.0,),
                                        Text(
                                          'Batches',
                                          style: TextStyle(fontSize: 18.0, color: Colors.white,),),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            height: 80.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.brown,
                            ),
                          ),
                        ),
                      )
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0,right: 8.0,bottom: 8.0),
                        child: InkWell(
                          onTap: () {},
                          child: Container(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: Row(
                                children: [
                                  const Icon(Icons.next_week_sharp,size: 45.0,color: Colors.white,),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 25.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: const [
                                        Text(
                                          'Current',
                                          style: TextStyle(fontSize: 18.0, color: Colors.white,),),
                                        SizedBox(height: 5.0,),
                                        Text(
                                          'Affairs',
                                          style: TextStyle(fontSize: 18.0, color: Colors.white,),),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            height: 80.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      )
                  ),
                  Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8.0,bottom: 8.0),
                        child: InkWell(
                          onTap: () {},
                          child: Container(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 30.0),
                              child: Row(
                                children: [
                                  const Icon(Icons.quiz,size: 45.0,color: Colors.white,),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 30.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: const [
                                        Text(
                                          'Daily',
                                          style: TextStyle(fontSize: 18.0, color: Colors.white,),),
                                        SizedBox(height: 5.0,),
                                        Text(
                                          'Quiz',
                                          style: TextStyle(fontSize: 18.0, color: Colors.white,),),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            height: 80.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      )
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0,right: 8.0,bottom: 8.0),
                        child: InkWell(
                          onTap: () {},
                          child: Container(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: Row(
                                children: [
                                  const Icon(Icons.library_add_check_rounded,size: 45.0,color: Colors.white,),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 25.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: const [
                                        Text(
                                          'Job',
                                          style: TextStyle(fontSize: 18.0, color: Colors.white,),),
                                        SizedBox(height: 5.0,),
                                        Text(
                                          'Alerts',
                                          style: TextStyle(fontSize: 18.0, color: Colors.white,),),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            height: 80.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.green[900],
                            ),
                          ),
                        ),
                      )
                  ),
                  Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8.0,bottom: 8.0),
                        child: InkWell(
                          onTap: () {},
                          child: Container(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 30.0),
                              child: Row(
                                children: [
                                  const Icon(Icons.shop_two ,size: 45.0,color: Colors.white,),
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
                                        SizedBox(height: 5.0,),
                                        Text(
                                          'Materials',
                                          style: TextStyle(fontSize: 18.0, color: Colors.white,),),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            height: 80.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.orangeAccent,
                            ),
                          ),
                        ),
                      )
                  ),
                ],
              ),
            ],
          ),
        )
    );
  }
}