import 'package:exampur_mobile/widgets/custom_smaller_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CourseCard extends StatefulWidget {
  String subject;
  String name;

  CourseCard({
    Key? key,
    required this.subject,
    required this.name,
  }) : super(key: key);

  @override
  _CourseCardState createState() => _CourseCardState();
}

class _CourseCardState extends State<CourseCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: InkWell(
          child: Container(
            height: 80,
            decoration: BoxDecoration(
              color: Colors.white70,
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 30,
                  ),
                  Flexible(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        RichText(
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          text: TextSpan(
                            style: TextStyle(
                              color: Colors.black
                            ),
                            text: widget.name,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                          CustomSmallerElevatedButton(onPressed: () {}, text: "Buy Course"),
                          CustomSmallerElevatedButton(onPressed: () {}, text: "View Details")
                        ],)
                      ],
                    ),
                  ),
                ],
              ),
            ),
          onTap: () {},
      ),
    );
  }
}