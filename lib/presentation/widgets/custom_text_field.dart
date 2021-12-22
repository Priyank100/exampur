import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final Function(String) value;
  final bool? obscureText;
  final bool? autofocus;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextInputType? textInputType;


  const CustomTextField({
    Key? key,
    required this.hintText,
    required this.value,
    this.obscureText,
    this.autofocus,
    this.controller,
    this.focusNode,
    this.textInputType
  }) : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  FocusNode _focusNode = FocusNode();
 // TextEditingController fieldController = TextEditingController();

  @override
  void initState() {
    super.initState();
    //fieldController = new TextEditingController(text: "");
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
        autofocus: widget.autofocus == null ? false : true,
        obscureText: widget.obscureText == null ? false : true,
        focusNode: widget.focusNode,
        autocorrect: false,
        keyboardType: widget.textInputType,
        controller: widget.controller,
        onChanged: (s) {
          widget.value(s);
        },
        onEditingComplete: () {
          FocusScope.of(context).nextFocus();
        },
        cursorColor: Colors.amber,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(
              color: Colors.transparent,
            ),
          ),
          hintText: widget.hintText,
          hintStyle: TextStyle(
            color: Colors.grey[600],
          ),
          filled: true,
          fillColor: Colors.grey[300],
          enabledBorder:  UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }
}
