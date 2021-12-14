import 'package:exampur_mobile/presentation/theme/custom_text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chips_input/flutter_chips_input.dart';

class SelectSubject extends StatefulWidget {
  final Function(List<String>) value;
  SelectSubject({Key? key, required this.value}) : super(key: key);

  @override
  _SelectSubjectState createState() => _SelectSubjectState();
}

class _SelectSubjectState extends State<SelectSubject> {
  final _chipKey = GlobalKey<ChipsInputState>();
  @override
  Widget build(BuildContext context) {
    const subs = ["Maths", "Biology", "Chemistry"];
    List<String> selected=[] ;

    return Padding(
      padding: EdgeInsets.all(5),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            RichText(
              text: TextSpan(
                style: CustomTextStyle.headingBold(context),
                text: 'Select Subjects',
              ),
            ),
            SizedBox(height: 20),
            ChipsInput(
              key: _chipKey,
              keyboardAppearance: Brightness.dark,
              textCapitalization: TextCapitalization.words,
              textStyle: const TextStyle(
                  height: 1.5, fontSize: 16),
              decoration: const InputDecoration(

                labelText: 'Select Subject',

              ),
              findSuggestions: (String query) {

                if (query.isNotEmpty) {
                  var lowercaseQuery = query.toLowerCase();
                  return subs.where((profile) {
                    return profile
                        .toLowerCase()
                        .contains(query.toLowerCase());
                  }).toList(growable: false)
                    ..sort((a, b) => a
                        .toLowerCase()
                        .indexOf(lowercaseQuery)
                        .compareTo(
                        b.toLowerCase().indexOf(lowercaseQuery)));
                }

                return subs;
              },
              onChanged: (data) {
                selected=data as List<String>;
                widget.value(selected);
                print(data);

              },
              chipBuilder: (context, state, dynamic profile) {
                return InputChip(
                  key: ObjectKey(profile),
                  label: Text(profile),
                  onDeleted: () => state.deleteChip(profile),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                );
              },
              suggestionBuilder: (context, state, dynamic profile) {
                return ListTile(
                  key: ObjectKey(profile),
                  // leading: CircleAvatar(
                  //   backgroundImage: NetworkImage(profile.imageUrl),
                  // ),
                  title: Text(profile),

                  onTap: () => state.selectSuggestion(profile),
                );
              },
            ),
            SizedBox(height: 20),
            // ElevatedButton(
            //   onPressed: () {
            //     print(selected);
            //     widget.value(selected);
            //   },
            //   child: Text('Submit subject'),
            // ),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}


