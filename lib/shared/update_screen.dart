import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:exampur_mobile/utils/images.dart';
import 'package:flutter/material.dart';

class UpdateScreen extends StatefulWidget {
  const UpdateScreen({Key? key}) : super(key: key);

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(Images.updateImg),
          const SizedBox(height: 10),
          const Padding(
            padding: EdgeInsets.all(10),
            child: Text(
                'Dear user its time to update',
                style: TextStyle(fontSize: 15)
            ),
          ),
          const Padding(
            padding:  EdgeInsets.all(10),
            child: Text(
                'We added lots of new features and new looks to Exampur app to make your experience as smooth as possible. Please update the app to continue learning.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12, wordSpacing: 4)
            ),
          ),
          const SizedBox(height: 20),
          InkWell(
            onTap: (){
              AppConstants.openPlayStore();
            },
            child: Container(
              width: MediaQuery.of(context).size.width - 100,
              height: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: const LinearGradient(
                  colors: [Color(0xFFEE0979), Color(0xFFFF6A00)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
              child: const Text('UPDATE APP',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white,fontSize: 15)
              ),
            ),
          )
        ],
      ),
    );
  }
}
