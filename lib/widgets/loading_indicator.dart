import 'package:flutter/material.dart';

Widget LoadingIndicator(BuildContext context) {
  return Center(
    child: Container(
      width: 90,
      height: 90,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: CircularProgressIndicator(
          color: Theme.of(context).primaryColor,
        ),
      ),
    ),
  );
}
