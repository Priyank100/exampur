import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

String sortBy = '';

showSortDialog(
  BuildContext context,
  int index,
  List<String> queries,
  List<String> texts,
  Function() fun,
) {
  Widget item(BuildContext context, String text, String query) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
      child: InkWell(
        onTap: () {
          sortBy = query;
          Navigator.of(context).pop();
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Icon(
                Icons.radio_button_off_sharp,
              ),
              SizedBox(
                width: 10,
              ),
              Text(text),
            ],
          ),
        ),
      ),
    );
  }

  // Create AlertDialog
  Dialog sort = Dialog(
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            color: Theme.of(context).primaryColor,
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.close),
                ),
                Text(
                  'Sort by',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Column(
              children: [
                for (int i = 0; i < texts.length; i++)
                  item(context, texts[i], queries[i])
              ],
            ),
          ),
        ],
      ),
    ),
  );
  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return sort;
    },
  );
}
