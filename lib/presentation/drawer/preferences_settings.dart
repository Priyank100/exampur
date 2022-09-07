import 'package:exampur_mobile/Localization/language_constrants.dart';
import 'package:exampur_mobile/data/model/response/languagemodel.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:exampur_mobile/utils/app_colors.dart';
import 'package:exampur_mobile/utils/lang_string.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../main.dart';

class PreferencesSettings extends StatefulWidget {
  @override
  _PreferencesSettingsState createState() => _PreferencesSettingsState();
}

class _PreferencesSettingsState extends State<PreferencesSettings> {
  @override
  void _changeLanguage(Language language) async {
    Locale _locale = await setLocale(language.languageCode);
    MyApp.setLocale(context, _locale);
  }
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 20,top: 20),
                child: Text(getTranslated(context, LangString.languagePreferences)!,style: TextStyle(color: AppColors.black,fontWeight: FontWeight.bold,fontSize: 20)),
              ),

             Container(
                  padding: const EdgeInsets.all(12.0),
                  margin:  const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.white
                  ),
                  child: DropdownButton<Language>(
hint: Text(getTranslated(context, LangString.selectLanguage)!),
                    isExpanded: true,
                    underline: SizedBox(),
                    icon: Icon(
                      Icons.arrow_downward_sharp,
                      color: AppColors.black,size: 20,
                    ),
                    onChanged: (Language? language) {
                      _changeLanguage(language!);
                    },
                    items: Language.languageList()
                        .map<DropdownMenuItem<Language>>(
                          (e) => DropdownMenuItem<Language>(
                        value: e,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Text(
                              e.flag,
                              style: TextStyle(fontSize: 30),
                            ),
                            Text(e.name)
                          ],
                        ),
                      ),
                    )
                        .toList(),
                  ),
                ),


            ],
          ),
        ));
  }
}

