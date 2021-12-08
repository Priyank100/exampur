import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:exampur_mobile/presentation/notifications/notification_screen.dart';

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
                children: [
                  const Text(
                    'App Logo Here',
                  ),
                  Row(
                    children: const [
                      Icon(Icons.touch_app,color: Colors.grey,),

                    ],
                  ),
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
            children: const [

            ],
          ),
        )
    );
  }
}
