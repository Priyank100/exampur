import 'package:flutter/material.dart';

import '../../utils/analytics_constants.dart';
import '../../utils/app_constants.dart';

class ToggleButton extends StatefulWidget {
  final bool tab;
  Function functionChat;
  Function functionPlaylist;
  ToggleButton(this.tab,this.functionChat, this.functionPlaylist);
  @override
  _ToggleButtonState createState() => _ToggleButtonState();
}

const double width = 270.0;
const double height = 45.0;
const double loginAlign = -1;
const double signInAlign = 1;
const Color selectedColor = Colors.amber;
const Color normalColor = Colors.black54;

class _ToggleButtonState extends State<ToggleButton> {
  late double xAlign;
  late Color loginColor;
  late Color signInColor;

  @override
  void initState() {
    super.initState();
    xAlign = loginAlign;
    loginColor = selectedColor;
    signInColor = normalColor;
    if(widget.tab) {
      xAlign = signInAlign;
      signInColor = selectedColor;
      loginColor = normalColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Center(
        child: Container(
          //width: width,
          height: height,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
              border: Border.all(color: Colors.grey)
          ),
          child: Stack(
            children: [
              AnimatedAlign(
                alignment: Alignment(xAlign, 0),
                duration: Duration(milliseconds: 300),
                child: Container(
                  width: width * 0.7,
                  height: height,
                  decoration: BoxDecoration(
                    color: Colors.white70,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                      border: Border.all(color: Colors.grey)
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  this.widget.functionChat();
                  var map = {
                    'Page_Name':'Free Videos',
                    'Mobile_Number':AppConstants.userMobile,
                    'Language':'en',
                    'video name': AppConstants.channelname,
                    'course name': AppConstants.courseName,
                    'channel name': AppConstants.channelname
                  };
                  AnalyticsConstants.trackEventMoEngage(AnalyticsConstants.YouTube_click_paid_course, map);
                  setState(() {
                    xAlign = loginAlign;
                    loginColor = selectedColor;
                    signInColor = normalColor;
                  });
                },
                // onTap: widget.onPressedChat,
                child: Align(
                  alignment: Alignment(-1, 0),
                  child: Container(
                    width: width * 0.7,
                    color: Colors.transparent,
                    alignment: Alignment.center,
                    child: Text(
                      'Paid Course',
                      style: TextStyle(
                        color: loginColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  this.widget.functionPlaylist();
                  setState(() {
                    xAlign = signInAlign;
                    signInColor = selectedColor;
                    loginColor = normalColor;
                  });
                },
              //  onTap: widget.onPressedPlaylist,
                child: Align(
                  alignment: Alignment(1, 0),
                  child: Container(
                    width: width * 0.7,
                    color: Colors.transparent,
                    alignment: Alignment.center,
                    child: Text(
                      'Playlist',
                      style: TextStyle(
                        color: signInColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

    );
  }
}