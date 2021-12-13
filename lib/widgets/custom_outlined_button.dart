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
    return Padding(
      padding: EdgeInsets.all(5),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          border: Border.all(color: Theme.of(context).primaryColor),
        ),
        width: 100,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Center(
                      child: Text(
                    widget.text,
                    style: TextStyle(fontSize: 15),
                  ))),
              onTap: () {
                print("tapped");
                widget.onPressed();
              }),
        ),
      ),
    );
  }
}
