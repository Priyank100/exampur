import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}
class CustomTextField extends StatefulWidget {
  final String hintText;
  final Function(String) value;
  final bool? obscureText;
  final bool? autofocus;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextInputType? textInputType;
 final bool? readOnly;
 final int? maxLength;
 final List<String>? autofillHints;
 final List<TextInputFormatter>? textInputFormatter;
 //inputFormatters: <TextInputFormatter>[
  //     FilteringTextInputFormatter.digitsOnly
  // ], // Only numbers can

  const CustomTextField({
    Key? key,
    required this.hintText,
    required this.value,
    this.obscureText,
    this.autofocus,
    this.controller,
    this.focusNode,
    this.textInputType,
    this.readOnly,
    this.maxLength,
    this.autofillHints,
    this.textInputFormatter
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
    return  Container(
        width: double.infinity,

        decoration: BoxDecoration(
          color: AppColors.grey300,

          borderRadius:  BorderRadius.all(const Radius.circular(8)),
    //       border: Border(
    //   left: BorderSide(10)
    // ),
          boxShadow: [
            BoxShadow(color: AppColors.grey.withOpacity(0.1), spreadRadius: 1, blurRadius: 3, offset: Offset(0, 1)) // changes position of shadow
          ],
        ),
        child: TextField(
          autofocus: widget.autofocus == null ? false : true,
          obscureText: widget.obscureText == null ? false : true,
          readOnly: widget.readOnly==null?false:true,
          focusNode: widget.focusNode,
          autocorrect: false,
          keyboardType: widget.textInputType,
          controller: widget.controller,
          maxLength: widget.maxLength,
          autofillHints: widget.autofillHints,
          onChanged: (s) {
            widget.value(s);
          },
          onEditingComplete: () {
            FocusScope.of(context).nextFocus();

          },
          inputFormatters: widget.textInputFormatter,
          cursorColor: Colors.amber,
          // decoration: InputDecoration(
          //   focusedBorder: OutlineInputBorder(
          //     borderRadius: BorderRadius.circular(10.0),
          //     borderSide: const BorderSide(
          //       color: Colors.transparent,
          //     ),
          //   ),
          //   hintText: widget.hintText,
          //   hintStyle: TextStyle(
          //     color: AppColors.grey600,
          //   ),
          //   filled: true,
          //   fillColor: AppColors.grey300,
          //   enabledBorder:  UnderlineInputBorder(
          //     borderSide: BorderSide(color: AppColors.white),
          //     borderRadius: BorderRadius.circular(10.0),
          //
          //   ),
          //   errorStyle: TextStyle(height: 1.5),
          //   border: InputBorder.none,
          // ),

          decoration: InputDecoration(
            hintText: widget.hintText,
    // focusedBorder: OutlineInputBorder(
    //     borderRadius: BorderRadius.circular(10.0),
    //     borderSide: const BorderSide(
    //       color: Colors.transparent,
    //     ),
    //   ),
    hintStyle: TextStyle(
        color: AppColors.grey600,
      ),
            // filled: true,
            // fillColor: AppColors.grey300,
            contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
            isDense: true,
            counterText: '',
            // focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).primaryColor)),
            //hintStyle: titilliumRegular.copyWith(color: Theme.of(context).hintColor),
            errorStyle: TextStyle(height: 1.5),
            border: InputBorder.none,
          ),
        ),

    );
  }
}
