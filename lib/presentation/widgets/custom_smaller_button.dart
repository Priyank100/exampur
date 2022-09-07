import 'package:exampur_mobile/utils/app_colors.dart';
import 'package:flutter/material.dart';

class CustomSmallerElevatedButton extends StatefulWidget {
  final VoidCallback onPressed;
  final String text;
  final Color color;
  const CustomSmallerElevatedButton({
    Key? key,
    required this.color,
    required this.onPressed,
    required this.text,
  }) : super(key: key);

  @override
  _CustomSmallerElevatedButtonState createState() =>
      _CustomSmallerElevatedButtonState();
}

class _CustomSmallerElevatedButtonState
    extends State<CustomSmallerElevatedButton> {
  bool isPressed = false;
  @override
  Widget build(BuildContext context) {
    // return ElevatedButton(
    //   style: ButtonStyle(
    //     backgroundColor:
    //         MaterialStateProperty.all<Color>(widget.color),
    //   ),
    //   onPressed: () {
    //     widget.onPressed();
    //   },
    //   child: Padding(
    //     padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
    //     child: Text(
    //       widget.text,
    //       style: TextStyle(
    //         fontSize: 18,
    //         color: Colors.white
    //       ),
    //     ),
    //   ),
    // );
    return InkWell(onTap: () {widget.onPressed();},
      child: Container(height: 30,width: 100,decoration: BoxDecoration( color: AppColors.green,
          borderRadius: BorderRadius.all(Radius.circular(8))),child: Center(child: Text(widget.text,style: TextStyle(color: Colors.white,fontSize: 11)))),
    );
  }
}
