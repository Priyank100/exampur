import 'package:exampur_mobile/utils/app_constants.dart';


import 'package:flutter/material.dart';

class CustomRoundButton extends StatefulWidget {
  final VoidCallback onPressed;
  final String text;
  const CustomRoundButton({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  _CustomRoundButtonState createState() => _CustomRoundButtonState();
}

class _CustomRoundButtonState extends State<CustomRoundButton> {
  @override
  Widget build(BuildContext context) {

    return  InkWell(onTap: () {widget.onPressed();},
      child: Container(height: 30,
          constraints: BoxConstraints(minWidth: 120),
          padding: EdgeInsets.only(left: 8,right: 8),
          decoration: BoxDecoration( color: Color(0xFF060929),
          borderRadius: BorderRadius.all(Radius.circular(8))),child: Center(child: Text(widget.text,style: TextStyle(color: Colors.white,fontSize: 11)))),
    );
  }
}