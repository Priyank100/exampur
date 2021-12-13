import 'package:flutter/material.dart';

class ProfileIcon extends StatefulWidget {
  String? imgurl;
  String? name;

  ProfileIcon({Key? key, this.imgurl, this.name}) : super(key: key);

  @override
  _ProfileIconState createState() => _ProfileIconState();
}

class _ProfileIconState extends State<ProfileIcon> {
  @override
  Widget build(BuildContext context) {
    String temp = widget.name == "" ? "" : widget.name!.substring(0, 1);

    return (widget.imgurl == null
        ? CircleAvatar(
            backgroundColor: Theme.of(context).primaryColor,
            // backgroundColor: Colors.purple,
            child: Text(
              temp.toUpperCase(),
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
            ),
          )
        : Container());
  }
}
