import 'package:flutter/material.dart';

class DropDownSelector extends StatefulWidget {
  final List<String> items;
  final Function(String) setValue;
final bool isExpanded;
  const DropDownSelector(
      {Key? key, required this.items, required this.setValue,required this.isExpanded})
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
    return Container(

      decoration: BoxDecoration(borderRadius:   BorderRadius.circular(5.0), color: Colors.grey.shade300,),
      margin: EdgeInsets.only(left: 10,right: 10),
     // width: MediaQuery.of(context).size.width * 1,
      padding: EdgeInsets.only(left: 10,right: 20),
      child: DropdownButton(
        value: dropdownvalue,
        isExpanded:widget.isExpanded,
        onChanged: (String? value) {
          widget.setValue(value!);
          setState(() {
            dropdownvalue = value.toString();
          });
        },
        style:TextStyle(color:Colors.grey, fontSize: 16),
        underline:Container(),
        items: widget.items
            .map((String items) => DropdownMenuItem(
                  value: items,
                  child: Text(items),
                ))
            .toList(),
      ),
    );
  }
}
