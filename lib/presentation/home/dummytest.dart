import 'package:exampur_mobile/provider/Authprovider.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Dummytest extends StatefulWidget {
  const Dummytest({Key? key}) : super(key: key);

  @override
  _DummytestState createState() => _DummytestState();
}

class _DummytestState extends State<Dummytest> {
  @override
  void initState() {
    super.initState();
    //final postMdl = Provider.of<AuthProvider>(context, listen: false).userInfo;
    //postMdl.initAddressList(context);
  }

  Widget build(BuildContext context) {
    final postMdl = Provider.of<AuthProvider>(context, listen: false).userInfo;
    return Scaffold(
        appBar: AppBar(
          title: Text("Tes"),
        ),
        body: Column(
          children: [Text(postMdl.first_name.toString())],
        ));
  }
}
