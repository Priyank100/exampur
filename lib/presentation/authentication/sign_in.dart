import 'package:exampur_mobile/data/model/loginmodel.dart';
import 'package:exampur_mobile/presentation/authentication/otp_screen.dart';
import 'package:exampur_mobile/presentation/home/bottom_navigation.dart';
import 'package:exampur_mobile/presentation/theme/custom_text_style.dart';
import 'package:exampur_mobile/presentation/widgets/custom_text_field.dart';
import 'package:exampur_mobile/presentation/widgets/custom_text_button.dart';
import 'package:exampur_mobile/provider/Authprovider.dart';
import 'package:exampur_mobile/utils/analytics_constants.dart';
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

class SignIn extends StatefulWidget {
  @override
  SignInState createState() => SignInState();
}
class SignInState extends State<SignIn> {
  late TextEditingController _phoneEmailController;
  late TextEditingController _passwordController;
  late GlobalKey<FormState> _formKeyLogin;

  FocusNode _phoneNode = FocusNode();
  FocusNode _passNode = FocusNode();

  @override
  void initState() {
    super.initState();
    var map = {
      'Page_Name':'App_Login',
      'Language':'en',

    };
    AnalyticsConstants.trackEventMoEngage(AnalyticsConstants.Login_page,map);
    _phoneNode.addListener(onFocusChange1);
    _passNode.addListener(onFocusChange2);

    _formKeyLogin = GlobalKey<FormState>();
    _phoneEmailController = TextEditingController();
    _passwordController = TextEditingController();

  }

  void onFocusChange1() {
    if(!_phoneNode.hasFocus) {
      if(_phoneEmailController.text.toString().contains('@')){
        var map = {
          'Page_Name':'App_Login',
          'Email_id':_phoneEmailController.text.toString(),
          'Language':'en',
          'User_ID':_phoneEmailController.text.toString()
        };
        AnalyticsConstants.trackEventMoEngage(AnalyticsConstants.Enter_Email_Login,map);

      } else{
        var map = {
          'Page_Name':'App_Login',
          'Mobile_Number':_phoneEmailController.text.toString(),
          'Language':'en',
          'User_ID':_phoneEmailController.text.toString()
        };

        AnalyticsConstants.trackEventMoEngage(AnalyticsConstants.Enter_Mobile_Login,map);
        }
      }

    }


  void onFocusChange2() {
    if(!_passNode.hasFocus) {
      String loginIdType =  _phoneEmailController.text.contains('@') ?'Email_Id':'Mobile_Number';
      var map = {
        'Page_Name':'App_Login',
        loginIdType:_phoneEmailController.text.toString(),
        'Language':'en',
        'User_ID':_phoneEmailController.text.toString()
      };
      AnalyticsConstants.trackEventMoEngage(AnalyticsConstants.Enter_Password_Login,map);
    }}


  @override
  void dispose() {
    _phoneEmailController.dispose();
    _passwordController.dispose();
    _phoneNode.removeListener(onFocusChange1);
    _passNode.removeListener(onFocusChange2);
    super.dispose();
  }

  LoginModel loginBody = LoginModel();

  void loginUser() async {
    if (_formKeyLogin.currentState!.validate()) {
      _formKeyLogin.currentState!.save();

      String _phoneEmail = _phoneEmailController.text.trim();
      String _password = _passwordController.text.trim();

      if (_phoneEmail.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          //elevation: 6.0,
          margin: EdgeInsets.all(20),
          behavior: SnackBarBehavior.floating,
          content: Text('Please enter Phone or Email'),
          backgroundColor: AppColors.black,
        ));
      } else if (_password.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          margin: EdgeInsets.all(20),
          behavior: SnackBarBehavior.floating,
          content: Text('Enter password'),
          backgroundColor: AppColors.black,
        ));
      } else {

        // if (Provider.of<AuthProvider>(context, listen: false).isRemember) {
        //   Provider.of<AuthProvider>(context, listen: false).saveUserEmail(_phone, _password);
        // } else {
        //   Provider.of<AuthProvider>(context, listen: false).clearUserEmailAndPassword();
        // }

        if(RegExp('[a-zA-Z]').hasMatch(_phoneEmail)) {
          loginBody.phone = '';
          loginBody.email = _phoneEmail;
        } else {
          loginBody.phone = _phoneEmail;
          loginBody.email = '';
        }

        loginBody.phoneExt = '91';
        // loginBody.phone = _phoneEmail;
        loginBody.password = _password;
      String loginIdType =  _phoneEmail.contains('@') ?'Email_Id':'Mobile_Number';
        var map = {
          'Page_Name':'App_Login',
          loginIdType:_phoneEmail,
          'Language':'en',
          'User_ID':_phoneEmail
        };
        AnalyticsConstants.trackEventMoEngage(AnalyticsConstants.Click_Submit,map);
        await Provider.of<AuthProvider>(context, listen: false).login(context, loginBody, route);
      }
    }
  }

  route(bool isRoute, String errorMessage) {
    if (isRoute) {
      AnalyticsConstants.sendAnalyticsEvent(AnalyticsConstants.loginScreen);
      // Map<String, Object> stuff = {};
      // AnalyticsConstants.logEvent(AnalyticsConstants.loginScreen,stuff);
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => BottomNavigation()), (route) => false);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(errorMessage), backgroundColor: AppColors.grey,));
    }
  }
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
        body:Form(
          key: _formKeyLogin,
          child: SingleChildScrollView(
            child:
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                        Center(
                          child:
                          Image.asset(Images.exampur_title,
                     // height: Dimensions.ICON_SIZE_Title,
                          width: Dimensions.ICON_SIZE_BigLogo ,

                           //alignment: Alignment.center,
                       ),
                        ),

                      SizedBox(height: 20),
                       Text(
                          "Let's Login",
                          style: CustomTextStyle.headingBigBold(context),
                        ),
                      SizedBox(height: 20),
                      CustomTextField(hintText: "Phone No / Email Id",
                          focusNode: _phoneNode,
                          // textInputType: TextInputType.number,
                          controller: _phoneEmailController,
                          // maxLength: 10,
                          // textInputFormatter: <TextInputFormatter>[
                          //   FilteringTextInputFormatter.digitsOnly
                          // ],
                          value: (value) {}),
                      SizedBox(height: 20,),
                      CustomPasswordTextField(
                        hintTxt: 'Password',
                        controller: _passwordController,
                         focusNode:  _passNode,
                        //  nextNode: _confirmPasswordFocus,
                        textInputAction: TextInputAction.next,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [

                          Text("Forgot Password?",style: TextStyle(color: AppColors.grey600),),
                          CustomTextButton(onPressed: () {
                            var map = {
                              'Page_Name':'App_Login',
                              'Mobile_Number':_phoneEmailController.text.trim(),
                              'Language':'en',
                              'User_ID':_phoneEmailController.text.trim()
                            };
                            AnalyticsConstants.trackEventMoEngage(AnalyticsConstants.Click_Forgot_Password_Login,map);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => OtpScreen(true)));
                          }, text: "Reset")
                        ],
                      ),

                     Container(
                            margin: EdgeInsets.only( bottom: 20, top: 30),
                            child: Provider.of<AuthProvider>(context).isLoading
                                ? Center(
                              child: CircularProgressIndicator(
                                valueColor: new AlwaysStoppedAnimation<Color>(
                                  Theme.of(context).primaryColor,
                                ),
                              ),
                            )
                                :
                           ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Theme.of(context).primaryColor),
                            ),
                            onPressed: () {
                              FocusScope.of(context).unfocus();
                             loginUser();
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12.0, horizontal: 60),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                child: Center(
                                  child: Text(
                                    "Log In",
                                    style:
                                        TextStyle(fontSize: 18, color: AppColors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Facing problem in signing in?",style: TextStyle(color: AppColors.grey600)),
                          CustomTextButton(onPressed: () {
                            var map = {
                              'Page_Name':'App_Login',
                              'Mobile_Number':_phoneEmailController.text.trim(),
                              'Language':'en',
                              'User_ID':_phoneEmailController.text.trim()
                            };
                            AnalyticsConstants.trackEventMoEngage(AnalyticsConstants.Click_Call_Us_Login,map);
                            AppConstants.makeCallEmail('tel:'+AppConstants.Mobile_number);}, text: "Call us")
                        ],
                      )
                    ],
                  ),
              )),
          ),
    );
  }
}
