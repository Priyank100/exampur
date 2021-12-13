import 'package:flutter/material.dart';

class Capsule extends StatefulWidget {
  String topic;

  Capsule({Key? key, required this.topic}) : super(key: key);

  @override
  _CapsuleState createState() => _CapsuleState();
}

class _CapsuleState extends State<Capsule> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xFFD9DBE9)),
          borderRadius: BorderRadius.all(Radius.circular(50)),
          color: Theme.of(context).backgroundColor,
        ),
        child: Material(
          child: InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: () {
                print("tapped");
              },
              child: Padding(
                  padding: EdgeInsets.only(
                      top: 5.0, bottom: 5, left: 10.0, right: 10.0),
                  child: Text(
                    widget.topic,
                    style: TextStyle(fontSize: 16),
                  ))),
          color: Colors.transparent,
        ),
      ),
    );
  }
}
