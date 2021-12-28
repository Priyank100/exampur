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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 30,top: 15),
                child: Text('Current Paasword',style: TextStyle(color: Colors.black,)),
              ),
              CustomTextField(hintText: "", value: (value) {}),
              const Padding(
                padding: EdgeInsets.only(left: 30,top: 10),
                child: Text('New Password',style: TextStyle(color: Colors.black,)),
              ),
              CustomTextField(hintText: "", value: (value) {}),
              const Padding(
                padding: EdgeInsets.only(left: 30,top: 10),
                child: Text('Confirm Password',style: TextStyle(color: Colors.black,)),
              ),
              CustomTextField(hintText: "", value: (value) {}),
             const SizedBox(height: 15,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
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
        ));
  }
}

