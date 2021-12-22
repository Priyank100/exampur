import 'package:exampur_mobile/data/model/loginmodel.dart';
import 'package:exampur_mobile/presentation/home/bottom_navigation.dart';
import 'package:exampur_mobile/presentation/theme/custom_text_style.dart';
import 'package:exampur_mobile/presentation/widgets/custom_text_field.dart';
import 'package:exampur_mobile/presentation/widgets/custom_text_button.dart';
import 'package:exampur_mobile/provider/Authprovider.dart';
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
          content: Text('EMAIL_MUST_BE_REQUIRED',),
          backgroundColor: Colors.red,
        ));
      } else if (_password.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('PASSWORD_MUST_BE_REQUIRED'),
          backgroundColor: Colors.red,
        ));
      } else {

        // if (Provider.of<AuthProvider>(context, listen: false).isRemember) {
        //   Provider.of<AuthProvider>(context, listen: false).saveUserEmail(_phone, _password);
        // } else {
        //   Provider.of<AuthProvider>(context, listen: false).clearUserEmailAndPassword();
        // }

        loginBody.phone = _phone;
        loginBody.password = _password;
        await Provider.of<AuthProvider>(context, listen: false).login(loginBody, route);
      }
    }
  }

  route(bool isRoute, String errorMessage) async {
    if (isRoute) {
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => BottomNavigation()), (route) => false);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(errorMessage), backgroundColor: Colors.red));
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
        body:Form(
          key: _formKeyLogin,
          child: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Logo"),
                    SizedBox(height: 20),
                    Text(
                      "Let's login",
                      style: CustomTextStyle.headingBold(context),
                    ),
                    SizedBox(height: 20),
                    CustomTextField(hintText: "Phone No.",  focusNode: _phoneNode,

                      controller: _phoneController,
                      value: (value) {},),
                    CustomTextField(hintText: "Password",
                        focusNode: _passNode,
                        controller: _passwordController,
                        value: (value) {}),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        Text("Forgot Password?"),
                        CustomTextButton(onPressed: () {}, text: "Reset")
                      ],
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Container(
                          margin: EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 30),
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
                          onPressed: () {loginUser;
                          print('anchal');
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
                                      TextStyle(fontSize: 18, color: Colors.white),
                                ),
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
                        Text("Facing problem in signing in?"),
                        CustomTextButton(onPressed: () {}, text: "Call us")
                      ],
                    )
                  ],
                )),
          ),
        ));
  }
}
