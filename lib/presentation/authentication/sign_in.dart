import 'package:exampur_mobile/data/model/loginmodel.dart';
import 'package:exampur_mobile/presentation/authentication/otp_screen.dart';
import 'package:exampur_mobile/presentation/home/bottom_navigation.dart';
import 'package:exampur_mobile/presentation/theme/custom_text_style.dart';
import 'package:exampur_mobile/presentation/widgets/custom_text_field.dart';
import 'package:exampur_mobile/presentation/widgets/custom_text_button.dart';
import 'package:exampur_mobile/provider/Authprovider.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:exampur_mobile/utils/custompassword_textfield.dart';
import 'package:exampur_mobile/utils/dimensions.dart';
import 'package:exampur_mobile/utils/images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignIn extends StatefulWidget {
  @override
  SignInState createState() => SignInState();
}

class SignInState extends State<SignIn> {
  late TextEditingController _phoneController;
  late TextEditingController _passwordController;
  late GlobalKey<FormState> _formKeyLogin;

  @override
  void initState() {
    super.initState();
    _formKeyLogin = GlobalKey<FormState>();

    _phoneController = TextEditingController();
    _passwordController = TextEditingController();
  //  _phoneController.text = (Provider.of<AuthProvider>(context, listen: false).getUserPhone() )!;
  //  _passwordController.text = (Provider.of<AuthProvider>(context, listen: false).getUserPassword() )!;

  }
  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  FocusNode _phoneNode = FocusNode();
  FocusNode _passNode = FocusNode();
  LoginModel loginBody = LoginModel();

  void loginUser() async {
    if (_formKeyLogin.currentState!.validate()) {
      _formKeyLogin.currentState!.save();

      String _phone = _phoneController.text.trim();
      String _password = _passwordController.text.trim();

      if (_phone.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          //elevation: 6.0,
          margin: EdgeInsets.all(20),
          behavior: SnackBarBehavior.floating,
          content: Text('Please enter complete PHONE No.'),
          backgroundColor: AppColors.black,
        ));
      } else if (_password.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          margin: EdgeInsets.all(20),
          behavior: SnackBarBehavior.floating,
          content: Text('Invalid Login Credentail'),
          backgroundColor: AppColors.black,
        ));
      } else {

        // if (Provider.of<AuthProvider>(context, listen: false).isRemember) {
        //   Provider.of<AuthProvider>(context, listen: false).saveUserEmail(_phone, _password);
        // } else {
        //   Provider.of<AuthProvider>(context, listen: false).clearUserEmailAndPassword();
        // }

        loginBody.phoneExt = '91';
        loginBody.phone = _phone;
        loginBody.password = _password;

        // loginBody.phone = '9099998988';
        // loginBody.password = '@Zakir123';
        await Provider.of<AuthProvider>(context, listen: false).login(loginBody, route);
      }
    }
  }

  route(bool isRoute, String errorMessage) async {
    if (isRoute) {
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

                      CustomTextField(hintText: "Phone No.",  focusNode: _phoneNode,
textInputType: TextInputType.number,
                        controller: _phoneController,
                        maxLength: 10,
                        value: (value) {},),
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
                          CustomTextButton(onPressed: () { AppConstants.makePhoneCall('tel:'+AppConstants.Mobile_number);}, text: "Call us")
                        ],
                      )
                    ],
                  ),
              )),
          ),
    );
  }
}
