import 'package:exampur_mobile/Localization/language_constrants.dart';
import 'package:exampur_mobile/presentation/drawer/preferences_settings.dart';
import 'package:exampur_mobile/presentation/drawer/security_settings.dart';
import 'package:exampur_mobile/presentation/widgets/custom_tab_bar.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:exampur_mobile/utils/lang_string.dart';
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
               names: [getTranslated(context, LangString.general)!, getTranslated(context,LangString.security)!, getTranslated(context, LangString.preference)!],
               routes: [

              GeneralSettings(),
              SecuritySettings(),
              PreferencesSettings(),
             

            ], title: getTranslated(context, LangString.settings)!,
          ),

    );
  }
}
