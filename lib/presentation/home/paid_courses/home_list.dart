import 'package:exampur_mobile/data/model/dummy_model.dart';
import 'package:exampur_mobile/shared/couses_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeList extends StatefulWidget {
  final List<DummyModel> list;
  const HomeList(this.list) : super();
  @override
  _HomeListState createState() => _HomeListState();
}

class _HomeListState extends State< HomeList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(itemCount: 4,
            itemBuilder: (BuildContext context,int index){
              return  Padding(
                padding: const EdgeInsets.all(8.0),
                child: ContainerwithBuyandView(widget.list, index),
              );
            })

    );
  }
}
