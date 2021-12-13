import 'package:flutter/material.dart';

class CustomSmallerElevatedButton extends StatefulWidget {
  final VoidCallback onPressed;
  final String text;
  const CustomSmallerElevatedButton({
    Key? key,
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
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor:
            MaterialStateProperty.all<Color>(Theme.of(context).primaryColor),
      ),
      onPressed: () {
        widget.onPressed();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 5),
        child: Text(
          widget.text,
          style: TextStyle(
            fontSize: 18,
            color: Colors.black
          ),
        ),
      ),
    );
  }
}
