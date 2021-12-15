import 'package:dropdown_search/dropdown_search.dart';
import 'package:exampur_mobile/presentation/theme/custom_text_style.dart';
import 'package:exampur_mobile/presentation/widgets/custom_text_field.dart';
import 'package:exampur_mobile/widgets/custom_text_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  @override
  SignUpState createState() => SignUpState();
}

class SignUpState extends State<SignUp> {
  @override
  void initState() {
    super.initState();
  }

  String dropdownValue = "fe";
  List<String> categories = [
    "fe",
    'fw',
    "fs",
    'efw',
    'wfee',
    'wefwef',
    'wefwe',
    'fewfs',
    'gwgg',
    'xcx',
    's',
    'g',
    'nhyn',
    'nyr',
    'ht4e'
  ];

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
                    "Let's Register",
                    style: CustomTextStyle.headingBold(context),
                  ),
                  SizedBox(height: 20),
                  CustomTextField(hintText: "Name", value: (value) {}),
                  CustomTextField(hintText: "E-mail", value: (value) {}),
                  CustomTextField(hintText: "Password", value: (value) {}),
                  CustomTextField(hintText: "Username", value: (value) {}),
                  CustomTextField(hintText: "Phone number", value: (value) {}),
                  CustomTextField(hintText: "Password", value: (value) {}),
                  CustomTextField(hintText: "City", value: (value) {}),
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
                              "Register",
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
