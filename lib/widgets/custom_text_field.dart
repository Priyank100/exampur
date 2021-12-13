import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String initialText;
  final String labelText;
  final Function(String) value;
  final bool? obscureText;
  final bool? autofocus;

  const CustomTextField({
    Key? key,
    required this.initialText,
    required this.labelText,
    required this.value,
    this.obscureText,
    this.autofocus,
  }) : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  FocusNode _focusNode = FocusNode();
  TextEditingController fieldController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fieldController = new TextEditingController(text: widget.initialText);
    _focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
      child: TextField(
        autofocus: widget.autofocus == null ? false:true,
        obscureText: widget.obscureText == null ? false : true,
        focusNode: _focusNode,
        autocorrect: false,
        controller: fieldController,
        onChanged: (s) {
          widget.value(s);
        },
        onEditingComplete: () {
          FocusScope.of(context).nextFocus();
        },
        decoration: InputDecoration(
          filled: true,
          fillColor: Theme.of(context).backgroundColor,
          labelStyle: TextStyle(
            color: _focusNode.hasFocus
                ? Theme.of(context).primaryColor
                : Colors.grey,
          ),
          border: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey,
            ),
          ),
          labelText: widget.labelText,
        ),
      ),
    );
  }
}
