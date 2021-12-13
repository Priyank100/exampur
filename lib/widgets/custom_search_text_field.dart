import 'package:flutter/material.dart';

class CustomSearchTextField extends StatefulWidget {
  final Function(String) value;
  const CustomSearchTextField({
    Key? key,
    required this.value,
  }) : super(key: key);

  @override
  _CustomSearchTextFieldState createState() => _CustomSearchTextFieldState();
}

class _CustomSearchTextFieldState extends State<CustomSearchTextField> {
  FocusNode _focusNode = FocusNode();
  TextEditingController fieldController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
      child: TextField(
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
          prefixIcon: Icon(
            Icons.search,
            color: _focusNode.hasFocus
                ? Theme.of(context).primaryColor
                : Colors.grey,
          ),
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
          labelText: 'Search',
        ),
      ),
    );
  }
}
