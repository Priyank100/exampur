import 'package:flutter/material.dart';

class CustomTextButton extends StatefulWidget {
  final VoidCallback onPressed;
  final String text;
  const CustomTextButton(
      {Key? key, required this.onPressed, required this.text})
      : super(key: key);

  @override
  _CustomTextButtonState createState() => _CustomTextButtonState();
}

class _CustomTextButtonState extends State<CustomTextButton> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        widget.onPressed();
      },
      child: Text(
        widget.text,
        style: TextStyle(
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
