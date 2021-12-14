import 'package:exampur_mobile/shared/video_card_ca.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GeneralSettings extends StatefulWidget {
  @override
  _GeneralSettingsState createState() => _GeneralSettingsState();
}

class _GeneralSettingsState extends State<GeneralSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Text("General settings")
            ],
          ),
        ));
  }
}

