import 'package:exampur_mobile/SharePref/shared_pref.dart';
import 'package:exampur_mobile/data/model/createUserModel.dart';
import 'package:exampur_mobile/data/model/state_json.dart';
import 'package:exampur_mobile/presentation/authentication/terms_condition.dart';
import 'package:exampur_mobile/presentation/drawer/choose_category.dart';
import 'package:exampur_mobile/presentation/home/LandingChooseCategory.dart';
import 'package:exampur_mobile/presentation/theme/custom_text_style.dart';
import 'package:exampur_mobile/presentation/widgets/custom_text_field.dart';
import 'package:exampur_mobile/presentation/widgets/custom_text_button.dart';
import 'package:exampur_mobile/provider/Authprovider.dart';
import 'package:exampur_mobile/utils/analytics_constants.dart';
import 'package:exampur_mobile/utils/api.dart';
import 'package:exampur_mobile/utils/lang_string.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:exampur_mobile/utils/app_colors.dart';
import 'package:exampur_mobile/utils/custompassword_textfield.dart';
import 'package:exampur_mobile/utils/dimensions.dart';
import 'package:exampur_mobile/utils/images.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'otp_screen.dart';

class SignUp extends StatefulWidget {
  @override
  SignUpState createState() => SignUpState();
}

class SignUpState extends State<SignUp> {
  late TextEditingController _nameController;
  // late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _userNameController;
  late TextEditingController _phoneController;
  // late TextEditingController _cityController;
  // late TextEditingController _dobController;
  late GlobalKey<FormState> _formKeySignUp;
  bool _isCheckTerms = true;

  // String selectedState='';
  // List<States> stateList = [];

  // String selectedDate = 'D.O.B';

  Future<String> loadJsonFromAssets() async {
    return await rootBundle.loadString('assets/LocalJson/State.json');
  }

  // void getStateList() async {
  //   String jsonString = await loadJsonFromAssets();
  //   final StateResponse = stateJsonFromJson(jsonString);
  //   stateList = StateResponse.states!;
  //   selectedState = stateList[0].name.toString();
  //   setState(() {});
  // }
  FocusNode _nameNode = FocusNode();
  FocusNode _emailNode = FocusNode();
  FocusNode _passwordNode = FocusNode();
  FocusNode _phoneNode = FocusNode();
//  FocusNode _cityNode = FocusNode();
  @override
  void initState() {
    super.initState();
    var map = {
      'Page_Name':'Sign_Up',
      'Language':'en',
    };
    AnalyticsConstants.trackEventMoEngage(AnalyticsConstants.Sign_Up,map);
    _formKeySignUp = GlobalKey<FormState>();
    _nameController = TextEditingController();
    // _emailController = TextEditingController();
    _phoneController = TextEditingController();
    _passwordController = TextEditingController();
    _userNameController = TextEditingController();
   // _cityController = TextEditingController();
   //  _dobController = TextEditingController();

    _nameNode.addListener(onFocusChange1);
    _emailNode.addListener(onFocusChange2);
    _passwordNode.addListener(onFocusChange3);
    _phoneNode.addListener(onFocusChange4);
  //  _cityNode.addListener(onFocusChange5);


   // getStateList();
  }


  void onFocusChange1() {
    if(!_nameNode.hasFocus) {
      var map = {
        'Page_Name':'Sign_Up',
        'Mobile_Number':_phoneController.text.toString(),
        'Language':'en',
        'User_ID':_phoneController.text.toString()
      };

      AnalyticsConstants.trackEventMoEngage(AnalyticsConstants.Enter_Name,map);
    }}
  void onFocusChange2() {
    if(!_emailNode.hasFocus) {
      var map = {
        'Page_Name':'Sign_Up',
        'Mobile_Number':_phoneController.text.toString(),
        'Language':'en',
        'User_ID':_phoneController.text.toString()
      };

      AnalyticsConstants.trackEventMoEngage(AnalyticsConstants.Enter_Email_ID,map);
    }}
  void onFocusChange3() {
    if(!_passwordNode.hasFocus) {
      var map = {
        'Page_Name':'Sign_Up',
        'Mobile_Number':_phoneController.text.toString(),
        'Language':'en',
        'User_ID':_phoneController.text.toString()
      };

      AnalyticsConstants.trackEventMoEngage(AnalyticsConstants.Enter_Password,map);
    }}void onFocusChange4() {
    if(!_phoneNode.hasFocus) {
      var map = {
        'Page_Name':'Sign_Up',
        'Mobile_Number':_phoneController.text.toString(),
        'Language':'en',
        'User_ID':_phoneController.text.toString()
      };

      AnalyticsConstants.trackEventMoEngage(AnalyticsConstants.Enter_Mobile_Number,map);
    }}
  // void onFocusChange5() {
  //   if(!_cityNode.hasFocus) {
  //     var map = {
  //       'Page_Name':'Sign_Up',
  //       'Mobile_Number':_phoneController.text.toString(),
  //       'Language':'en',
  //       'User_ID':_phoneController.text.toString()
  //     };
  //
  //     AnalyticsConstants.trackEventMoEngage(AnalyticsConstants.Enter_City,map);
  //   }}

  @override
  void dispose() {
    _nameController.dispose();
    // _emailController.dispose();
    //_cityController.dispose();
    _userNameController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    // _dobController.dispose();

    _nameNode.removeListener(onFocusChange1);
    _emailNode.removeListener(onFocusChange2);
    _passwordNode.removeListener(onFocusChange3);
    _phoneNode.removeListener(onFocusChange4);
   // _cityNode.removeListener(onFocusChange5);



    super.dispose();
  }

  CreateUserModel CreateUserbody = CreateUserModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(
            color: AppColors.black,
          ),
        ),
        body: Form(
          key: _formKeySignUp,
          child: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(child: Image.asset(Images.exampur_title, width: 200,)
                    ),
                    Text(
                      "Let's Register",
                      style: CustomTextStyle.headingBigBold(context),
                    ),
                    SizedBox(height: 20),
                    CustomTextField(
                        hintText: "Name",
                        controller: _nameController,
                        focusNode: _nameNode,
                        value: (value) {}),
                    // SizedBox(
                    //   height: 15,
                    // ),
                    //
                    // InkWell(
                    //   onTap: () async {
                    //     String date = await AppConstants.selectDate(context, 'dd/MM/yyyy');
                    //     if(date.isNotEmpty) {
                    //       setState(() {
                    //         selectedDate = date;
                    //       });
                    //     }
                    //   },
                    //   child: Container(
                    //       width: double.infinity,
                    //       padding: EdgeInsets.all(10),
                    //       decoration: BoxDecoration(
                    //         color: AppColors.grey300,
                    //         borderRadius:  BorderRadius.all(const Radius.circular(8)),
                    //         boxShadow: [
                    //           BoxShadow(color: AppColors.grey.withOpacity(0.1), spreadRadius: 1, blurRadius: 3, offset: Offset(0, 1)) // changes position of shadow
                    //         ],
                    //       ),
                    //       child: Text(selectedDate)
                    //   ),
                    // ),


                    // SizedBox(
                    //   height: 15,
                    // ),
                    // CustomTextField(
                    //     hintText: "E-mail",
                    //     controller: _emailController,
                    //     focusNode: _emailNode,
                    //     textInputType: TextInputType.emailAddress,
                    //     value: (value) {}),
                    SizedBox(
                      height: 15,
                    ),

                    CustomTextField(
                        hintText: "Phone number",
                        controller: _phoneController,
                        focusNode: _phoneNode,
                        textInputType: TextInputType.number,
                        maxLength: 10,
                        textInputFormatter: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        value: (value) {}),

                    SizedBox(
                      height: 15,
                    ),
                    // CustomTextField(
                    //     hintText: "Username",
                    //     controller: _userNameController,
                    //     value: (value) {}),
                    // SizedBox(
                    //   height: 15,
                    // ),

                    CustomPasswordTextField(
                      hintTxt: 'Password',
                      controller: _passwordController,
                      focusNode: _passwordNode,
                      textInputAction: TextInputAction.next,
                    ),

                    // SizedBox(
                    //   height: 15,
                    // ),
                    // Container(
                    //   width: double.infinity,
                    //   height: 50,
                    //   decoration: BoxDecoration(
                    //     color: AppColors.grey300,
                    //     borderRadius:  BorderRadius.all(const Radius.circular(8)),
                    //     boxShadow: [
                    //       BoxShadow(color: AppColors.grey.withOpacity(0.1), spreadRadius: 1, blurRadius: 3, offset: Offset(0, 1))
                    //     ],
                    //   ),
                    //   padding: EdgeInsets.only(left: 10),
                    //   child: DropdownButton(
                    //     underline: SizedBox(),
                    //     isExpanded: true,
                    //     value: selectedState,
                    //     items: stateList.map((value) {
                    //       return DropdownMenuItem(
                    //         value: value.name,
                    //         child: Text(value.name.toString()),
                    //       );
                    //     }).toList(),
                    //     onChanged: (selected) {
                    //       if(selected != null){
                    //         var map = {
                    //           'Page_Name':'Sign_Up',
                    //           'Language':'en',
                    //
                    //         };
                    //        AnalyticsConstants.trackEventMoEngage(AnalyticsConstants.Click_State,map);
                    //       }
                    //       setState(() {
                    //         selectedState = selected.toString();
                    //       });
                    //     },
                    //   ),
                    // ),

                    // SizedBox(
                    //   height: 15,
                    // ),
                    //
                    // CustomTextField(
                    //     hintText: "City",
                    //     controller: _cityController,
                    //     focusNode: _cityNode,
                    //     value: (value) {}),

                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Checkbox(
                            value: _isCheckTerms,
                            checkColor: AppColors.white,
                            activeColor: AppColors.amber,
                            onChanged: (newValue) {
                              if(newValue!){
                                var map = {
                                  'Page_Name':'Sign_Up',
                                  'Mobile_Number':_phoneController.text.toString(),
                                  'Language':'en',
                                  'User_ID':_phoneController.text.toString()
                                };
                                AnalyticsConstants.trackEventMoEngage(AnalyticsConstants.Click_Agree_TnC,map);
                              }

                              setState(() {
                                _isCheckTerms = newValue;
                              });
                            }),
                        Text(
                          'I agree with ',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                          ),
                        ),
                        InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (_) =>TermsAndConditions(API.TermsConditions_URL)));},
                            child: Text(
                              'Terms and Conditions',
                              style: TextStyle(
                                  color: AppColors.amber,
                                  decoration: TextDecoration.underline,
                                  fontFamily: 'Poppins'),
                            ))
                      ],
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Theme.of(context).primaryColor),
                        ),
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          // print(_dobController.text.toString());
                          registerUser();
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 12.0, horizontal: 60),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            child: Center(
                              child: Text(
                                "Register",
                                style: TextStyle(
                                    fontSize: 18, color: AppColors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Facing problem in signing in?",style: TextStyle(color: AppColors.grey600),),
                        CustomTextButton(onPressed: () {

                          var fMap = {
                            'Page_Name':'Sign_Up',
                            'Language':'en',
                          };
                          AnalyticsConstants.firebaseEvent(AnalyticsConstants.callSignUpClick, fMap);

                          AppConstants.makeCallEmail('tel:'+AppConstants.Mobile_number);
                        }, text: "Call us")
                      ],
                    )
                  ],
                )),
          ),
        ));
  }

  void registerUser() async {
    if (_formKeySignUp.currentState!.validate()) {
      _formKeySignUp.currentState!.save();

      String _name = _nameController.text.trim();
      // String _email = _emailController.text.trim();
      String _password = _passwordController.text.trim();
      String _userName = _userNameController.text.trim();
      String _phone = _phoneController.text.trim();
     // String _city = _cityController.text.trim();
     //  String _dob = _dobController.text.trim();

      if (_name.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            'Please enter your Name',
          ),
          backgroundColor: AppColors.black,
          margin: EdgeInsets.all(20),
          behavior: SnackBarBehavior.floating,
        ));
      }
      // else if (selectedDate == 'D.O.B') {
      //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //     content: Text('Please enter your Date of Birth'),
      //     backgroundColor: AppColors.black,
      //     margin: EdgeInsets.all(20),
      //     behavior: SnackBarBehavior.floating,
      //   ));
      // }
      // else if (_email.isEmpty) {
      //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //     content: Text('Please enter your Email Id'),
      //     backgroundColor: AppColors.black,
      //     margin: EdgeInsets.all(20),
      //     behavior: SnackBarBehavior.floating,
      //   ));
      // }
      // else if (!AppConstants.isEmailValid(_email)) {
      //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //     content: Text('Please enter valid Email Id'),
      //     backgroundColor: AppColors.black,
      //     margin: EdgeInsets.all(20),
      //     behavior: SnackBarBehavior.floating,
      //   ));
      // }
      else if (_password.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Please enter your Password'),
          backgroundColor: AppColors.black,
          margin: EdgeInsets.all(20),
          behavior: SnackBarBehavior.floating,
        ));
      } else if (_password.length < 8) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Please enter atleast 8 letter Password'),
          backgroundColor: AppColors.black,
          margin: EdgeInsets.all(20),
          behavior: SnackBarBehavior.floating,
        ));
      }
      // else if (_userName.isEmpty) {
      //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //     content: Text('Please enter your Username'),
      //     backgroundColor: AppColors.black,
      //     margin: EdgeInsets.all(20),
      //     behavior: SnackBarBehavior.floating,
      //   ));
      // }
      else if (_phone.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Please enter your Phone Number'),
          backgroundColor: AppColors.black,
          margin: EdgeInsets.all(20),
          behavior: SnackBarBehavior.floating,
        ));
      } else if (_phone.length < 10) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Please enter valid Phone Number'),
          backgroundColor: AppColors.black,
          margin: EdgeInsets.all(20),
          behavior: SnackBarBehavior.floating,
        ));
      }
      // else if (selectedState=='Select States') {
      //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //     content: Text('Please select State'),
      //     backgroundColor: AppColors.black,
      //     margin: EdgeInsets.all(20),
      //     behavior: SnackBarBehavior.floating,
      //   ));
      // } else if (_city.isEmpty) {
      //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //     content: Text('Please enter City'),
      //     backgroundColor: AppColors.black,
      //     margin: EdgeInsets.all(20),
      //     behavior: SnackBarBehavior.floating,
      //   ));
      // }
      else if (!_isCheckTerms) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Agree the Terms and Conditions to proceed.'),
          backgroundColor: AppColors.black,
          margin: EdgeInsets.all(20),
          behavior: SnackBarBehavior.floating,
        ));
      } else {
        var fName = '';
        var lName = 'null';
        if(_name.contains(" ")) {
          fName = _name.split(" ")[0];
          lName = _name.split(" ").sublist(1).join(" ");
        } else {
          fName = _name;
        }
        CreateUserbody.phoneExt = '91';
        CreateUserbody.firstName = fName;
        CreateUserbody.lastName = lName;
        CreateUserbody.emailId = _phone + '@nill.com';
        // CreateUserbody.dob = selectedDate;
        CreateUserbody.password = _password;
        CreateUserbody.phone = _phone;
        CreateUserbody.state =  AppConstants.defaultState;
        CreateUserbody.city =  AppConstants.defaultCity;
        CreateUserbody.country = AppConstants.defaultCountry;
        CreateUserbody.language = 'English';


        await Provider.of<AuthProvider>(context, listen: false)
            .userResgister(context, CreateUserbody, route);
      }
    }
  }

  route(bool isRoute, String errorMessage) async {
    if (isRoute) {
      await FirebaseAnalytics.instance.logEvent(name: 'USER_SIGNUP',parameters: {
        'Name':_nameController.text.toString(),
         // 'Email':_emailController.text.toString(),
         'Email':_phoneController.text.toString() + '@nill.com',
        // 'Phone':_phoneController.text.toString(),

      });
      Map<String, Object> stuff = {
        'Name':_nameController.text.toString(),
        // 'Email':_emailController.text.toString(),
        'Email':_phoneController.text.toString() + '@nill.com',
      };
      AnalyticsConstants.logEvent('USER_SIGNUP',stuff);
      // SharedPref.saveSharedPref(SharedPref.CATEGORY_LENGTH, '0');

      var fMap = {
        'Page_Name':'Sign_Up',
        'Mobile_Number':_phoneController.text.toString(),
        'Language':'en',
        'User_ID':_phoneController.text.toString(),
      };
      AnalyticsConstants.firebaseEvent(AnalyticsConstants.registerClick, fMap);

      var map = {
        'Page_Name':'Sign_Up',
        'Mobile_Number':_phoneController.text.toString(),
        'Language':'en',
        'User_ID':_phoneController.text.toString(),
      };
     AnalyticsConstants.trackEventMoEngage(AnalyticsConstants.Click_Register,map);

     await SharedPref.saveSharedPref(SharedPref.SIGNUP_TIME, AppConstants.timeRound());
     await SharedPref.saveSharedPref(SharedPref.TEACHER_INCENTIVE_DATETIME, AppConstants.timeRound());
     await SharedPref.saveSharedPref(SharedPref.TEACHER_INCENTIVE_FIRST, 'TRUE');
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => OtpScreen(false)));

    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage), backgroundColor: AppColors.red));
    }
  }



}
