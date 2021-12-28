import 'package:flutter/material.dart';

class DropDownSelector extends StatefulWidget {
  final List<String> items;
  final Function(String) setValue;

  const DropDownSelector(
      {Key? key, required this.items, required this.setValue})
      : super(key: key);

  @override
  _DropDownSelectorState createState() => _DropDownSelectorState();
}

class _DropDownSelectorState extends State<DropDownSelector> {
  String dropdownvalue = "";

  @override
  void initState() {
    super.initState();
    dropdownvalue = widget.items[0];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      value: dropdownvalue,
      onChanged: (String? value) {
        widget.setValue(value!);
        setState(() {
          dropdownvalue = value.toString();
        });
      },
      underline:Container(),
      items: widget.items
          .map((String items) => DropdownMenuItem(
                value: items,
                child: Text(items),
              ))
          .toList(),
    );
  }
}
