import 'package:exampur_mobile/dummy3.dart';
import 'package:exampur_mobile/utils/images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Dummy2 extends StatefulWidget {
  const Dummy2() : super();

  @override
  _Dummy2State createState() => _Dummy2State();
}

class _Dummy2State extends State<Dummy2> {
  List<String> videoList = [
    'https://www.youtube.com/watch?v=ZoOwI3P5POo',
    'https://www.youtube.com/watch?v=ZoOwI3P5POo',
    'https://www.youtube.com/watch?v=ZoOwI3P5POo'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Youtube'),
      ),
      body: Container(
        child: ListView.builder(
          itemCount: videoList.length,
            itemBuilder: (context, index) {
              return myCard(index);
            }
        ),
      ),
    );
  }

  Widget myCard(index) {
    return Container(
      height: MediaQuery.of(context).size.width/1.1,
      margin: EdgeInsets.all(10),
      child: Card(
        child: Column(
          children: [
            Align(
              alignment: FractionalOffset.topCenter,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Dummy3(videoList[index].toString())));
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width/2.2,
                  child: Image.asset(Images.exampur_logo),
                )
              ),
            ),
            Expanded(
              child: Container(
                  padding: EdgeInsets.all(10),
                  child: Text(
                      "Abcd efghij klmn opqrs tuvwx yz.")),
            ),
            Align(
              alignment: FractionalOffset.bottomCenter,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Dummy3(videoList[index].toString())));
                },
                child: Container(
                  height: 50,
                  color: Colors.amber,
                  alignment: Alignment.center,
                  child: Text('Watch Now', style: TextStyle(color: Colors.white),),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
