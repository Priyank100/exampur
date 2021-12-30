import 'package:exampur_mobile/data/model/daily_monthly_ca_model.dart';
import 'package:exampur_mobile/shared/daily_monthly_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DailyMonthlyCA extends StatefulWidget {
  final List<DailyMonthlyCaModel> list;
  const DailyMonthlyCA(this.list) : super();

  @override
  _DailyMonthlyCAState createState() => _DailyMonthlyCAState();
}

class _DailyMonthlyCAState extends State<DailyMonthlyCA> {

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
