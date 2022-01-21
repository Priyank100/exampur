import 'package:exampur_mobile/presentation/authentication/sign_in.dart';
import 'package:exampur_mobile/presentation/authentication/sign_up.dart';
import 'package:exampur_mobile/presentation/widgets/custom_outlined_button.dart';
import 'package:exampur_mobile/presentation/widgets/custom_text_button.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:exampur_mobile/utils/dimensions.dart';
import 'package:exampur_mobile/utils/images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatefulWidget {
  @override
  LandingPageState createState() => LandingPageState();
}

class LandingPageState extends State<LandingPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(Images.login,
                  height: Dimensions.ICON_SIZE_BigsLogo ,
                  width: Dimensions.ICON_SIZE_BigsLogo ,
                  alignment: Alignment.center,
                ),
                SizedBox(height: 20),
                CustomOutlinedButton(onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignUp()));
                }, text: "Let's Register"),
                SizedBox(height: 10),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Theme.of(context).primaryColor),
                  ),
                  onPressed: () {

                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SignIn()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 60),
                    child: Container(
                      height: Dimensions.PADDING_SIZE_EXTRA_LARGES,
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: Text(
                          "Log In",
                          style: TextStyle(fontSize: 18, color: AppColors.white),
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
                      AppConstants.makePhoneCall('tel:'+AppConstants.Mobile_number);
                    }, text: "Call us")
                  ],
                )
              ],
            )));
  }
}
