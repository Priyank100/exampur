import 'dart:ui';

import 'package:flutter/material.dart';

import 'custom_round_button.dart';

showAlertDialogPopup(
    BuildContext context, String alertText, String buttonText, Function() fun, ) {
  // Create button
  Widget okButton = CustomRoundButton(
    text: buttonText ,
    onPressed: () {
      fun();

    },
  );


  // Create AlertDialog
  AlertDialog alert = AlertDialog(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15)),
    backgroundColor: Color.fromRGBO(	78, 78, 78, 0.85),
    elevation: 0,
    title: Text('Alert'),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          alertText,
          style: TextStyle(fontSize: 17),
        ),
      ],
    ),
    actions: [
      okButton,

    ],
  );

  showGeneralDialog(
    barrierDismissible: true,
    barrierLabel: '',
    //barrierColor: Colors.black38,
    transitionDuration: Duration(milliseconds: 200),
    pageBuilder: (context, anim1, anim2) => alert,
    transitionBuilder: (context, anim1, anim2, child) => BackdropFilter(
      filter:
      ImageFilter.blur(sigmaX: 4 * anim1.value, sigmaY: 4 * anim1.value),
      child: FadeTransition(
        child: child,
        opacity: anim1,
      ),
    ),
    context: context,
  );
}
