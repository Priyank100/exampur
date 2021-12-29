import 'package:exampur_mobile/utils/dimensions.dart';
import 'package:flutter/material.dart';

class DailyMonthlyCard extends StatefulWidget {
  const DailyMonthlyCard() : super();

  @override
  _DailyMonthlyCardState createState() => _DailyMonthlyCardState();
}

class _DailyMonthlyCardState extends State<DailyMonthlyCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      child: Card(
        elevation: 2,
        child: Padding(
          padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
          child: Row(
            children: [
              Container(
                  width: Dimensions.DailyMonthlyImageWidth,
                  height: Dimensions.DailyMonthlyImageHeight,
                  child: Image.asset('widget.list[widget.index].imagePath.toString()', fit: BoxFit.fill)
              ),
              SizedBox(width: 10),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('widget.list[widget.index].title.toString()',overflow: TextOverflow.ellipsis, maxLines: 2),
                    Row(
                      children: [
                        InkWell(
                          onTap: (){},
                          child: Container(
                            margin: const EdgeInsets.all(10.0),
                            padding: const EdgeInsets.all(3.0),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)
                            ),
                            child: Text(' View '),
                          ),
                        ),
                        Icon(Icons.remove_red_eye),
                        Text('1000,000+'),
                        InkWell(
                          onTap: (){},
                          child: Row(
                            children: [
                              Icon(Icons.share_outlined),
                              Text('Share'),
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
