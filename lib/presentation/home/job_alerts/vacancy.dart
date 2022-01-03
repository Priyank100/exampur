import 'package:exampur_mobile/data/model/job_alert_model.dart';
import 'package:exampur_mobile/shared/pdf_card_ca.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'admit_card.dart';

class Vacancy extends StatefulWidget {
  final List<JobAlertModel> list;
  const Vacancy(this.list) : super();
  @override
  _VacancyState createState() => _VacancyState();
}

class _VacancyState extends State<Vacancy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: widget. list.length == 0
            ? Center(child: CircularProgressIndicator())
            :ListView.builder(itemCount: widget.list.length,
            itemBuilder: (BuildContext context,int index){
              return JobAlertViewContainer(widget.list, index);
            }));
  }
}

