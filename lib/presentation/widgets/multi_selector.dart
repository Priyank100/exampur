import 'package:exampur_mobile/presentation/widgets/custom_button.dart';
import 'package:exampur_mobile/presentation/widgets/custom_smaller_button.dart';
import 'package:exampur_mobile/shared/free_course_card.dart';
import 'package:exampur_mobile/shared/selection_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MultiSelect extends StatefulWidget {
  final Function(Set<String>) function;
  final List<String> options;
  final Set<String> selected;

  MultiSelect({Key? key, required this.function, required this.options, required this.selected})
      : super(key: key);

  @override
  _MultiSelectState createState() => _MultiSelectState();
}

class _MultiSelectState extends State<MultiSelect> {
  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: EdgeInsets.all(5),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            for (var name in widget.options)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    widget.selected.contains(name)? widget.selected.remove(name):widget.selected.add(name);
                    widget.function(widget.selected);
                  },
                  child: SelectionCard(color: widget.selected.contains(name)
                      ? Colors.yellow
                      : Colors.black, name: name,),
                ),
              ),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
