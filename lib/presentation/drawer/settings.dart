import 'dart:io';
import 'package:exampur_mobile/Localization/language_constrants.dart';
import 'package:exampur_mobile/presentation/drawer/preferences_settings.dart';
import 'package:exampur_mobile/presentation/drawer/security_settings.dart';
import 'package:exampur_mobile/presentation/theme/custom_text_style.dart';
import 'package:exampur_mobile/presentation/widgets/custom_tab_bar.dart';
import 'package:exampur_mobile/utils/appBar.dart';
import 'package:exampur_mobile/utils/images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'general_settings.dart';

class Settings extends StatefulWidget {

  @override
  SettingsState createState() => SettingsState();
}

class SettingsState extends State<Settings> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomTabBar(
               length: 3,
               names: [getTranslated(context, 'general')!, getTranslated(context, 'security')!, getTranslated(context, 'preference')!],
               routes: [

              GeneralSettings(),
              SecuritySettings(),
              PreferencesSettings(),
             

            ], title: getTranslated(context, 'settings')!,
          ),

    );
  }
}
