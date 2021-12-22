import 'package:exampur_mobile/provider/Authprovider.dart';
import 'package:exampur_mobile/provider/HomeBannerProvider.dart';
import 'package:exampur_mobile/utils/app_constants.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Dummytest extends StatefulWidget {
  const Dummytest({Key? key}) : super(key: key);

  @override
  _DummytestState createState() => _DummytestState();
}

class _DummytestState extends State<Dummytest> {
  @override
  Future<void> initState() async {
    super.initState();
    await Provider.of<HomeBannerProvider>(context, listen: false).getHomeBannner(context);
   // postMdl.(context);
  }

  Widget build(BuildContext context) {
    final postMdl = Provider.of<HomeBannerProvider>(context, listen: false).homeBannerModel;
    return Scaffold(
        appBar: AppBar(
          title: Text("Tes"),
        ),
        body: Column(
          children: [Text(postMdl.length.toString())],
        ));
  }
}
