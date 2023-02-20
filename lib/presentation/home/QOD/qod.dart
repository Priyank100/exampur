import 'package:exampur_mobile/utils/appBar.dart';
import 'package:flutter/material.dart';

import '../../../utils/app_constants.dart';

class QOD extends StatefulWidget {
  const QOD({Key? key}) : super(key: key);

  @override
  State<QOD> createState() => _QODState();
}

class _QODState extends State<QOD> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: AppConstants.comingSoonImage(),
    );
  }
}
