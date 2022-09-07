import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:exampur_mobile/utils/lang_string.dart';

import 'package:exampur_mobile/utils/dimensions.dart';
import 'package:flutter/material.dart';

class CustomOutlinedButton extends StatefulWidget {
  final VoidCallback onPressed;
  final String text;

  const CustomOutlinedButton({
    Key? key,
    required this.onPressed,
    required this.text,
  }) : super(key: key);

  @override
  _CustomOutlinedButtonState createState() => _CustomOutlinedButtonState();
}

class _CustomOutlinedButtonState extends State<CustomOutlinedButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Dimensions.Login_Button_height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: Colors.blue, width: 2),
      ),
      width: MediaQuery.of(context).size.width,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Center(
                    child: Text(
                  widget.text,
                  style: TextStyle(color: Colors.blue, fontSize: 20),
                ))),
            onTap: () {
              AppConstants.printLog("tapped");
              widget.onPressed();
            }),
      ),
    );
  }
}
