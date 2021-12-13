import 'package:flutter/material.dart';

class CustomErrorTextField extends StatefulWidget {
  final String initialText;
  final String labelText;
  final Function(String) value;
  final Function(bool) hasError;
  bool? obscureText;
  final bool? autofocus;
  final String? validator;
  final TextInputType? keyboardType;
  String? hintText;

  CustomErrorTextField({
    Key? key,
    required this.initialText,
    required this.labelText,
    required this.value,
    required this.hasError,
    this.obscureText,
    this.autofocus,
    this.validator,
    this.keyboardType,
    this.hintText,
  }) : super(key: key);

  @override
  _CustomErrorTextFieldState createState() => _CustomErrorTextFieldState();
}

class _CustomErrorTextFieldState extends State<CustomErrorTextField> {
  FocusNode _focusNode = FocusNode();
  TextEditingController _fieldController = TextEditingController();
  bool _error = false;
  String _errorText = '';

  //RegExp regExp = new RegExp(r'(^(?:[+0]9)?[0-9]{10}$)');
  RegExp regExp = new RegExp(r'(^((\+91)?|91)?[123456789][0-9]{9}$)');

  RegExp regEmail = new RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  bool isNumeric(String str) {
    try {
      double.parse(str);
    } on FormatException {
      return false;
    }
    return true;
  }

  determineError() {
    if (widget.validator != null) {
      switch (widget.validator) {
        case 'email':
          {
            if (!regEmail.hasMatch(_fieldController.text)) {
              setState(() {
                _errorText = 'Not a valid email address';
                _error = true;
              });
            } else {
              setState(() {
                _errorText = '';
                _error = false;
              });
            }
          }
          break;
        case 'phone':
          {
            if (!regExp.hasMatch(_fieldController.text)) {
              setState(() {
                _errorText = 'Enter a valid phone number';
                _error = true;
              });
            } else {
              setState(() {
                _errorText = '';
                _error = false;
              });
            }
          }
          break;
        case 'password':
          {
            if (_fieldController.text.length < 8) {
              setState(() {
                _errorText = 'Password must be atleast 8 characters';
                _error = true;
              });
            } else {
              setState(() {
                _errorText = '';
                _error = false;
              });
            }
          }
          break;
        case 'number':
          {
            if (!isNumeric(_fieldController.text)) {
              setState(() {
                _errorText = 'value must be an integer';
                _error = true;
              });
            } else {
              if (double.parse(_fieldController.text) <= 0) {
                setState(() {
                  _errorText = 'value must be positive';
                  _error = true;
                });
              } else {
                setState(() {
                  _errorText = '';
                  _error = false;
                });
              }
            }
          }
          break;
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _fieldController = new TextEditingController(text: widget.initialText);
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
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: TextField(
        autofocus: widget.autofocus == null ? false : true,
        obscureText: widget.obscureText == null ? false : (widget.obscureText!),
        keyboardType: widget.keyboardType == null ? null : widget.keyboardType,
        focusNode: _focusNode,
        autocorrect: false,
        controller: _fieldController,
        onChanged: (s) {
          determineError();
          widget.value(s);
          widget.hasError(_error);
        },
        onEditingComplete: () {
          FocusScope.of(context).nextFocus();
        },
        decoration: InputDecoration(
          hintText: widget.hintText == null ? null : widget.hintText,
          hintStyle: TextStyle(color: Colors.grey, fontStyle: FontStyle.italic),
          errorText: widget.validator != null
              ? _error
                  ? _errorText
                  : null
              : null,
          filled: true,
          fillColor: Theme.of(context).backgroundColor,
          labelStyle: TextStyle(
            color: _focusNode.hasFocus
                ? _error
                    ? Theme.of(context).errorColor
                    : Theme.of(context).primaryColor
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
// onChanged: (s) {
// determineError();
// widget.value(s);
// widget.hasError(_error);
// },
