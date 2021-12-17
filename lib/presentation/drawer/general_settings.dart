import 'package:exampur_mobile/presentation/widgets/custom_text_field.dart';
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

            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,

            children: [
              const Padding(
                padding: EdgeInsets.only(left: 30,top: 10),
                child: Text('Name',style: TextStyle(color: Colors.black,)),
              ),
              CustomTextField(hintText: "E-mail", value: (value) {}),
              const Padding(
                padding: EdgeInsets.only(left: 30,top: 10),
                child: Text('Mobile Number',style: TextStyle(color: Colors.black,)),
              ),
              CustomTextField(hintText: "Mobile Number", value: (value) {}),
              const Padding(
                padding: EdgeInsets.only(left: 30,top: 10),
                child: Text('E-mail',style: TextStyle(color: Colors.black,)),
              ),
              CustomTextField(hintText: "E-mail", value: (value) {}),
              const Padding(
                padding: EdgeInsets.only(left: 30,top: 10),
                child: Text('UserName',style: TextStyle(color: Colors.black)),
              ),
              CustomTextField(hintText: "UserName", value: (value) {}),

            ],
          ),

        ),

        ///save profile button
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          height: 50,
          width: 200,
          decoration: BoxDecoration(
            color: Colors.amber,
            //border: Border.all( color: Colors.amber,),
            borderRadius: BorderRadius.all(
                Radius.circular(5.0) //
            ),
          ),

          child: Center(child: Text('Save Profile',style: TextStyle(color: Colors.white,fontSize: 20),)),
        ),
      ),
    );
  }
}

