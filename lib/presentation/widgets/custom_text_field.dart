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
        cursorColor: Colors.amber,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: const BorderSide(
              color: Colors.transparent,
            ),
          ),
          hintText: widget.initialText,
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
    );
  }
}