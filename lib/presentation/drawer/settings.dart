import 'dart:io';
import 'package:exampur_mobile/presentation/drawer/preferences_settings.dart';
import 'package:exampur_mobile/presentation/drawer/security_settings.dart';
import 'package:exampur_mobile/presentation/theme/custom_text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'general_settings.dart';

class Settings extends StatefulWidget {
  @override
  SettingsState createState() => SettingsState();
}

class SettingsState extends State<Settings> {
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        initialIndex: 0,
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: true,
            backgroundColor: Colors.transparent,
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
            elevation: 0,
            centerTitle: true,
            title: Text(
              'Logo',
              style: TextStyle(color: Colors.black),
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(65.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      "Settings",
                      style: CustomTextStyle.headingBold(context),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TabBar(
                      isScrollable: true,
                      unselectedLabelColor: Colors.grey,
                      indicatorColor: Theme.of(context).primaryColor,
                      labelColor: Theme.of(context).primaryColor,
                      tabs: <Widget>[
                        Tab(
                          text: "General",
                          //'My Courses',
                        ),
                        Tab(
                          text: "Security",
                        ),
                        Tab(
                          text: "Preference",
                        ),

                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              GeneralSettings(),
              SecuritySettings(),
              PreferencesSettings(),
             

            ],
          ),
        ),
      ),
    );
  }
}
