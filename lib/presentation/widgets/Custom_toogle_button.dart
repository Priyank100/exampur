import 'package:flutter/material.dart';

class ToggleButton extends StatefulWidget {
  final VoidCallback? onPressedChat;
  final VoidCallback? onPressedPlaylist;
  ToggleButton({this.onPressedChat,this.onPressedPlaylist});
  @override
  _ToggleButtonState createState() => _ToggleButtonState();
}

const double width = 300.0;
const double height = 60.0;
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
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    xAlign = loginAlign;
                    loginColor = selectedColor;
                    signInColor = normalColor;
                  });
                  widget.onPressedChat;
                },
                // onTap: widget.onPressedChat,
                child: Align(
                  alignment: Alignment(-1, 0),
                  child: Container(
                    width: width * 0.5,
                    color: Colors.transparent,
                    alignment: Alignment.center,
                    child: Text(
                      'Chat',
                      style: TextStyle(
                        color: loginColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    xAlign = signInAlign;
                    signInColor = selectedColor;
                    loginColor = normalColor;
                  });
                  widget.onPressedPlaylist;
                },
              //  onTap: widget.onPressedPlaylist,
                child: Align(
                  alignment: Alignment(1, 0),
                  child: Container(
                    width: width * 0.5,
                    color: Colors.transparent,
                    alignment: Alignment.center,
                    child: Text(
                      'Playlist',
                      style: TextStyle(
                        color: signInColor,
                        fontSize: 18,
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