import 'package:exampur_mobile/utils/appBar.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:flutter/material.dart';

class CurrentAffairsDetails extends StatefulWidget {
  const CurrentAffairsDetails({Key? key}) : super(key: key);

  @override
  State<CurrentAffairsDetails> createState() => _CurrentAffairsDetailsState();
}

class _CurrentAffairsDetailsState extends State<CurrentAffairsDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Text('Title',style: TextStyle(fontSize: 20),),
              Row(
                children: [
                  Chip(
                    backgroundColor: AppColors.grey300,
                    label: Text(
                      'Tag :',
                      style: TextStyle(fontSize: 15),
                    ), //Text
                  ),
                  SizedBox(width: 5,),
                  Text('Title',style: TextStyle(fontSize: 15),),
                ],
              ),
              SizedBox(height: 5,),
                Text('Title',style: TextStyle(fontSize: 20),),
            ],),
          ),
        ),
      ),
    );
  }
}
