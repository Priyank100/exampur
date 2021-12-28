import 'dart:convert';

import 'package:exampur_mobile/SharePref/shared_pref.dart';
import 'package:exampur_mobile/presentation/widgets/custom_text_field.dart';
import 'package:exampur_mobile/shared/video_card_ca.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GeneralSettings extends StatefulWidget {
  @override
  _GeneralSettingsState createState() => _GeneralSettingsState();
}

class _GeneralSettingsState extends State<GeneralSettings> {
  String userName = '';
  String Name ='';
  String Email='';
  String Mobile='';
  final FocusNode _nameFocus = FocusNode();
  final FocusNode _mobileFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _usernamePasswordFocus = FocusNode();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  Future<void> getSharedPrefData() async {
    var jsonValue =  jsonDecode(await SharedPref.getSharedPref(AppConstants.USER_DATA));
    AppConstants.printLog('priyank>> ${jsonValue.toString()}');
    userName = jsonValue[0]['data']['first_name'].toString();
    Mobile = jsonValue[0]['data']['phone'].toString();
    Email = jsonValue[0]['data']['email_id'].toString();
    Name = jsonValue[0]['data']['lastName'].toString();
    setState(() {
    });
  }
  @override
  void initState()  {
    super.initState();
    getSharedPrefData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        restorationId: _nameController.text = userName,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(19.0),
            child: Column(

              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,

              children: [
                Text('Name',style: TextStyle(color: Colors.black,)),
SizedBox(height: 10,),
                CustomTextField(hintText:'${Name}', value: (value) {}),
                SizedBox(height: 10,),
               Text('Mobile Number',style: TextStyle(color: Colors.black,)),
                SizedBox(height: 10,),
                CustomTextField(hintText: '${Mobile}', value: (value) {}),
                SizedBox(height: 10,),
                 Text('E-mail',style: TextStyle(color: Colors.black,)),
                SizedBox(height: 10,),
                CustomTextField(hintText: '${Email}', value: (value) {}),
                SizedBox(height: 10,),
                Text('UserName',style: TextStyle(color: Colors.black)),
                SizedBox(height: 10,),
                CustomTextField(hintText: '${userName}', value: (value) {}),

              ],
            ),
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

