import 'package:exampur_mobile/presentation/widgets/custom_button.dart';
import 'package:exampur_mobile/presentation/widgets/custom_smaller_button.dart';
import 'package:exampur_mobile/presentation/widgets/dropdown_selector.dart';
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
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 20,top: 20),
                child: Text('Language Preferences',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 15)),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 2.0, bottom: 0, left: 40, right: 25),
                    child: DropDownSelector(items: ["select issue", "Hindi", "English"], setValue: (val) {}),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: CustomSmallerElevatedButton(
                  color: Colors.amber,
                  onPressed: () {},
                  text: "Save",
                ),
              ),
            ],
          ),
        ));
  }
}

