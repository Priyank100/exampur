import 'package:exampur_mobile/provider/user_info_provider.dart';
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
    final postMdl = Provider.of<AuthProvider>(context, listen: false);
    postMdl.initAddressList(context);
  }
  Widget build(BuildContext context) {
    final postMdl = Provider.of<AuthProvider>(context);
    return Scaffold(
      appBar: AppBar(),
body: ListView.builder(
  itemCount: postMdl.userList.length,
    itemBuilder: (BuildContext context,int index)
{
  return Container(
    child:Text(postMdl.userList[index].phoneConf.toString()) ,
  );
}
),

    );
  }
}
