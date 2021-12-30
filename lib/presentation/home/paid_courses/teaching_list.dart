// import 'package:exampur_mobile/data/model/DummyModel.dart';
import 'package:exampur_mobile/data/model/dummy_model.dart';
import 'package:exampur_mobile/shared/teaching_container.dart';
import 'package:flutter/material.dart';

class TeachingList extends StatefulWidget {
  final List<DummyModel> list;
  const TeachingList(this.list) : super();

  @override
  _TeachingListState createState() => _TeachingListState();
}

class _TeachingListState extends State<TeachingList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(itemCount: 4,
            itemBuilder: (BuildContext context,int index){
          return  TeachingContainer(widget.list, index);
        })
    );
  }
}
