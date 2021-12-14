import 'package:exampur_mobile/shared/video_card_ca.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SecuritySettings extends StatefulWidget {
  @override
  _SecuritySettingsState createState() => _SecuritySettingsState();
}

class _SecuritySettingsState extends State<SecuritySettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Text("Securitysettings")
            ],
          ),
        ));
  }
}

