import 'package:exampur_mobile/data/model/ca_content_model.dart';
import 'package:exampur_mobile/shared/daily_monthly_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ContentsCA extends StatefulWidget {
  final List<CaContentModel> list;
  const ContentsCA(this.list) : super();

  @override
  _ContentsCAState createState() => _ContentsCAState();
}

class _ContentsCAState extends State<ContentsCA> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.list.length == 0
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
          itemCount: widget.list.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return DailyMonthlyCard(widget.list, index);
          }),
    );
  }
}
