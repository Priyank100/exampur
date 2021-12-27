import 'package:exampur_mobile/presentation/widgets/custom_text_field.dart';
import 'package:exampur_mobile/shared/video_card_ca.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SecuritySettings extends StatefulWidget {
  @override
  _SecuritySettingsState createState() => _SecuritySettingsState();
}

class _SecuritySettingsState extends State<SecuritySettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(19.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [

                Text('Current Paasword',style: TextStyle(color: Colors.black,)),
                const SizedBox(height: 15,),
                CustomTextField(hintText: "", value: (value) {}),
                const SizedBox(height: 15,),
               Text('New Password',style: TextStyle(color: Colors.black,)),
                const SizedBox(height: 15,),
                CustomTextField(hintText: "", value: (value) {}),
                const SizedBox(height: 15,),
                 Text('Confirm Password',style: TextStyle(color: Colors.black,)),
                const SizedBox(height: 15,),
                CustomTextField(hintText: "", value: (value) {}),
               const SizedBox(height: 15,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 20),
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
                            "Change Password",
                            style:
                            TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

