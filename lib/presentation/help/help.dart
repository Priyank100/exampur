import 'dart:io';

// import 'package:exampur_mobile/presentation/help/dropdown_menu.dart';
import 'package:exampur_mobile/presentation/widgets/custom_text_field.dart';
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
    return SingleChildScrollView(
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
          CustomTextField(initialText: "help", labelText: "ik", value: (value) {}),
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
                hintText: 'Name',
                hintStyle: TextStyle(
                  color: Colors.grey[600],
                ),
                filled: true,
                fillColor: Colors.grey[300],
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
                fillColor: Colors.grey[300],
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
                fillColor: Colors.grey[300],
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
              keyboardType: TextInputType.phone,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
            /*child: TextField(
                cursorColor: Colors.amber,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: const BorderSide(
                      color: Colors.transparent,
                    ),
                  ),
                  border: InputBorder.none,
                  hintText: 'Select Issue',
                  hintStyle: TextStyle(
                    color: Colors.grey[600],
                  ),
                  filled: true,
                  fillColor: Colors.grey[300],
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),*/
            child: Text("test"),
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
                hintText: 'Write about the problem',
                hintStyle: TextStyle(
                  color: Colors.grey[600],
                ),
                filled: true,
                fillColor: Colors.grey[300],
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
              maxLines: 5,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 30.0),
            child: SizedBox(
              height: 45.0,
              width: MediaQuery.of(context).size.width * 1,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.amber,
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
            padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 30.0),
            child: SizedBox(
              height: 45.0,
              width: MediaQuery.of(context).size.width * 1,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.amber,
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
    );
  }
}
