import 'package:flutter/material.dart';

import 'app_constants.dart';

class CustomPasswordTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String? hintTxt;
  final FocusNode? focusNode;
  final FocusNode? nextNode;
  final TextInputAction? textInputAction;

  CustomPasswordTextField({this.controller, this.hintTxt, this.focusNode, this.nextNode, this.textInputAction});

  @override
  _CustomPasswordTextFieldState createState() => _CustomPasswordTextFieldState();
}

class _CustomPasswordTextFieldState extends State<CustomPasswordTextField> {
  bool _obscureText = true;

  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,

      decoration: BoxDecoration(
        color: AppColors.grey300,

        borderRadius:  BorderRadius.all(const Radius.circular(12)),
        //       border: Border(
        //   left: BorderSide(10)
        // ),
        boxShadow: [
          BoxShadow(color: AppColors.grey.withOpacity(0.1), spreadRadius: 1, blurRadius: 3, offset: Offset(0, 1)) // changes position of shadow
        ],
      ),
      child: TextFormField(
        cursorColor:AppColors.amber,
        controller: widget.controller,
        obscureText: _obscureText,
        focusNode: widget.focusNode,
        textInputAction: widget.textInputAction ?? TextInputAction.next,
        onFieldSubmitted: (v) {
          setState(() {
            widget.textInputAction == TextInputAction.done
                ? FocusScope.of(context).consumeKeyboardToken()
                : FocusScope.of(context).requestFocus(widget.nextNode);
          });
        },
        validator: (value) {
          return null;
        },
        decoration: InputDecoration(
            suffixIcon: IconButton(icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility,color: AppColors.amber,), onPressed: _toggle),
            hintText: widget.hintTxt ?? '',
            contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
            isDense: true,
            //filled: true,
            hintStyle: TextStyle(
              color: AppColors.grey600,
            ),
            fillColor: AppColors.grey.withOpacity(0.1),
            errorStyle: TextStyle(height: 1.5),
          // focusedBorder: OutlineInputBorder(borderSide: BorderRadius.all( Radius.circular(12)),),
           // hintStyle: titilliumRegular.copyWith(color: Theme.of(context).hintColor),
            border: InputBorder.none),
      ),
    );
  }
}