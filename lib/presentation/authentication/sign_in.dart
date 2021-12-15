import 'package:exampur_mobile/presentation/theme/custom_text_style.dart';
import 'package:exampur_mobile/presentation/widgets/custom_text_field.dart';
import 'package:exampur_mobile/widgets/custom_outlined_button.dart';
import 'package:exampur_mobile/widgets/custom_text_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  @override
  SignInState createState() => SignInState();
}

class SignInState extends State<SignIn> {
  @override
  void initState() {
    super.initState();
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
        body: SingleChildScrollView(
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
                  CustomTextField(hintText: "E-mail", value: (value) {}),
                  CustomTextField(hintText: "Password", value: (value) {}),
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
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Theme.of(context).primaryColor),
                      ),
                      onPressed: () {},
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
        ));
  }
}
