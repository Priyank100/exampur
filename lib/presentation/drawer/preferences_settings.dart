import 'package:exampur_mobile/shared/video_card_ca.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PreferencesSettings extends StatefulWidget {
  @override
  _PreferencesSettingsState createState() => _PreferencesSettingsState();
}

class _PreferencesSettingsState extends State<PreferencesSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Text("Preferences settings")
            ],
          ),
        ));
  }
}

