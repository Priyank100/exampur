import 'dart:convert';

import 'package:exampur_mobile/SharePref/shared_pref.dart';
import 'package:exampur_mobile/data/model/createUserModel.dart';
import 'package:exampur_mobile/presentation/widgets/custom_text_field.dart';
import 'package:exampur_mobile/provider/Authprovider.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:exampur_mobile/utils/dimensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
  late GlobalKey<FormState> _formKeyLogin;
  CreateUserModel registerModel=CreateUserModel ();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  bool isLoading = false;

  Future<void> getSharedPrefData() async {
    var jsonValue =  jsonDecode(await SharedPref.getSharedPref(AppConstants.USER_DATA));
    AppConstants.printLog('priyank>> ${jsonValue.toString()}');
    userName = jsonValue[0]['data']['first_name'].toString();
    Mobile = jsonValue[0]['data']['phone'].toString();
    Email = jsonValue[0]['data']['email_id'].toString();
    Name = jsonValue[0]['data']['first_name'].toString();
    _emailController.text = Email;
    setState(() {
    });
  }
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey<ScaffoldMessengerState>();
  @override
  void initState()  {
    super.initState();
    _formKeyLogin =GlobalKey<FormState>();
    getSharedPrefData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
        restorationId: _nameController.text = userName,
        body:
         SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(19.0),
              child: Column(

                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,

                children: [
                  Text('Name',style: TextStyle(color: Colors.black,)),
SizedBox(height: 10,),
                  CustomTextField(hintText:'${Name}', value: (value) {},controller: _nameController,),
                  SizedBox(height: 10,),
                 Text('Mobile Number',style: TextStyle(color: Colors.black,)),
                  SizedBox(height: 10,),
                  CustomTextField(hintText: '${Mobile}', value: (value) {},readOnly: true,),
                  SizedBox(height: 10,),
                   Text('E-mail',style: TextStyle(color: Colors.black,)),
                  SizedBox(height: 10,),
                  CustomTextField(hintText: '${Email}', value: (value) {},controller: _emailController,),
                  SizedBox(height: 10,),
                  Text('UserName',style: TextStyle(color: Colors.black)),
                  SizedBox(height: 10,),
                  CustomTextField(hintText: '${userName}', value: (value) {},readOnly: true,),
                  SizedBox(height: 90,),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      //margin: EdgeInsets.symmetric(horizontal: Dimensions.MARGIN_SIZE_LARGE, vertical: Dimensions.MARGIN_SIZE_SMALL),
                      child: !isLoading
                          ?  InkWell(onTap:(){

                        setState(() {
                          isLoading = true;
                        });
                        _updateUserAccount();
                      },
                          child: Container(height: 50, width: 300,color: Colors.amber,child: Center(child: Text('Save Profile',style: TextStyle(color: Colors.white),)),))
                          :
                      Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.amber))),
                    ),
                  ),
                ],
              ),
            ),
          ),
    );
  }


//
//   void UserProfile() async {
//     if (_formKeyLogin.currentState!.validate()) {
//       _formKeyLogin.currentState!.save();
//
//       String _phone = _nameController.text.trim();
//       String _password = _emailController.text.trim();
//
//       if (_phone.isEmpty) {
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//           //elevation: 6.0,
//           margin: EdgeInsets.all(20),
//           behavior: SnackBarBehavior.floating,
//           content: Text('Please enter complete Email Id'),
//           backgroundColor: Colors.black,
//         ));
//       } else if (_password.isEmpty) {
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//           margin: EdgeInsets.all(20),
//           behavior: SnackBarBehavior.floating,
//           content: Text('Invalid Login Credentail'),
//           backgroundColor: Colors.black,
//         ));
//       } else {
//
//         // if (Provider.of<AuthProvider>(context, listen: false).isRemember) {
//         //   Provider.of<AuthProvider>(context, listen: false).saveUserEmail(_phone, _password);
//         // } else {
//         //   Provider.of<AuthProvider>(context, listen: false).clearUserEmailAndPassword();
//         // }
//
//
//         // loginBody.phone = _phone;
//         // loginBody.password = _password;
// registerModel.lastName='hindi';
// registerModel.state='up';
// registerModel.country='india';
// registerModel.language='hindi';
// registerModel.emailId=_emailController.text;
// registerModel.firstName=_nameController.text;
// registerModel.phone='dfvgrbr';
//
//         await Provider.of<AuthProvider>(context, listen: false).updateUserProfile(registerModel, route);
//       }
//     }
//   }
//
//   route(bool isRoute, String errorMessage) async {
//     if (isRoute) {
//       AppConstants.printLog('ok');
//       //Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => BottomNavigation()), (route) => false);
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(errorMessage), backgroundColor: Colors.red));
//     }
//    }
  _updateUserAccount() async {
    String _firstName = _nameController.text.trim();

    String _email = _emailController.text.trim();


    if (_firstName.isEmpty || _email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('NAME_FIELD_MUST_BE_REQUIRED',), backgroundColor: Colors.black));
    }else if (_email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('EMAIL_MUST_BE_REQUIRED'), backgroundColor:Colors.black));
    }else {
      CreateUserModel updateUserInfoModel = Provider.of<AuthProvider>(context, listen: false).uerupdate;
      updateUserInfoModel.firstName = _nameController.text ;
      updateUserInfoModel.emailId = _emailController.text ;
       updateUserInfoModel.language = 'Hindi' ;
      updateUserInfoModel.country = 'Hindi' ;
      updateUserInfoModel.city = 'Hindi' ;
      updateUserInfoModel.state = 'Hindi' ;
      updateUserInfoModel.lastName = 'Hindi' ;



      await Provider.of<AuthProvider>(context, listen: false).updateUserProfile(updateUserInfoModel)
          .then((response) {
        isLoading = false;
        if(response) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Updated Successfully'), backgroundColor: Colors.green));
        }else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(response.message), backgroundColor: Colors.red));
        }
        setState(() {});
     }
   );
    }
  }

}

