import 'dart:io';

// import 'package:exampur_mobile/presentation/help/dropdown_menu.dart';
import 'package:exampur_mobile/presentation/widgets/custom_text_field.dart';
import 'package:exampur_mobile/presentation/widgets/dropdown_selector.dart';
import 'package:exampur_mobile/utils/appBar.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Help extends StatefulWidget {
  const Help({Key? key}) : super(key: key);

  @override
  HelpState createState() => HelpState();
}

class HelpState extends State<Help> {
  @override
  void initState() {
    super.initState();
  }

  late String issue_id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 20.0, top: 20.0),
              child: Text(
                'Help',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30.0,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
              child: TextField(
                cursorColor: Colors.amber,
                decoration: InputDecoration(

                  // focusedBorder: OutlineInputBorder(
                  //   borderRadius: BorderRadius.circular(10.0),
                  //   borderSide: const BorderSide(
                  //     color: Colors.transparent,
                  //   ),
                  // ),
                  hintText: 'Name',
                  hintStyle: TextStyle(
                    color: Colors.grey[600],
                  ),
                  filled: true,
                  fillColor:Colors.grey.shade300,
                  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
              child: TextField(
                cursorColor: Colors.amber,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: const BorderSide(
                      color: Colors.transparent,
                    ),
                  ),
                  border: InputBorder.none,
                  hintText: 'E-mail',
                  hintStyle: TextStyle(
                    color: Colors.grey[600],
                  ),
                  filled: true,
                  fillColor:Colors.grey.shade300,
                  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
              child: TextField(
                cursorColor: Colors.amber,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: const BorderSide(
                      color: Colors.transparent,
                    ),
                  ),
                  border: InputBorder.none,
                  hintText: 'Phone Number',
                  hintStyle: TextStyle(
                    color: Colors.grey[600],
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade300,
                  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
                keyboardType: TextInputType.phone,
              ),
            ),

              Padding(
                padding:  const EdgeInsets.only(left: 10.0, right: 10.0, top: 15.0),

                    child: DropDownSelector(isExpanded:true,items: ["select issue", "App Crashing", "Exam Guidance", "Study Help", "Purchase help", "Other"], setValue: (val) {})),



            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 15.0),
              child: TextField(
                cursorColor: Colors.amber,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: const BorderSide(
                      color: Colors.transparent,
                    ),
                  ),
                  border: InputBorder.none,
                  hintText: 'Write about the problem',
                  hintStyle: TextStyle(
                    color: Colors.grey[600],
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade300,
                  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),

                ),
                maxLines: 5,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 30.0),
              child: SizedBox(
                height: 55.0,
                width: MediaQuery.of(context).size.width * 1,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: AppConstants.Dark,
                      elevation: 5.0,
                    ),
                    onPressed: () {},
                    child: const Text(
                      'Submit Issue',
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 30.0,bottom: 10),
              child: SizedBox(
                height: 55.0,
                width: MediaQuery.of(context).size.width * 1,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary:  AppConstants.Dark,
                      elevation: 5.0,
                    ),
                    onPressed: () {},
                    child: const Text(
                      'Watch App Tutorials',
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
