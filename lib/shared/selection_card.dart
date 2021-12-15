import 'package:exampur_mobile/presentation/widgets/custom_smaller_button.dart';
import 'package:exampur_mobile/presentation/widgets/custom_outlined_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SelectionCard extends StatefulWidget {
  Color color;
  String name;

  SelectionCard({
    Key? key,
    required this.color,
    required this.name,
  }) : super(key: key);

  @override
  _SelectionCardState createState() => _SelectionCardState();
}

class _SelectionCardState extends State<SelectionCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0,),
      child: Wrap(
        children: [
          Material(
            elevation: 10,
            shadowColor: Colors.black,
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
            child: Container(
              width: MediaQuery.of(context).size.width*0.45,
              decoration: BoxDecoration(
                color: Colors.white54,
                border: Border.all(color: widget.color, width: 4),
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      // child: Image(
                      //   image: AssetImage(""),
                      // ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      widget.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),


                  ],
                ),
              ),
            ),
          ),],
      ),
    );
  }
}