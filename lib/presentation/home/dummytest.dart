import 'package:exampur_mobile/provider/Authprovider.dart';
import 'package:exampur_mobile/provider/HomeBannerProvider.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:exampur_mobile/utils/images.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Dummytest extends StatefulWidget {
  const Dummytest({Key? key}) : super(key: key);

  @override
  _DummytestState createState() => _DummytestState();
}

class _DummytestState extends State<Dummytest> {
  @override
  // initState()   {
  //   super.initState();
  //   callProvider();
  //   // postMdl.(context);
  // }
  // Future<void> callProvider() async {
  //   await Provider.of<HomeBannerProvider>(context, listen: false).getHomeBannner(context);
  //   // await Provider.of<AuthProvider>(context,listen: false).login();
  // }

  Widget build(BuildContext context) {
    //final postMdl = Provider.of<HomeBannerProvider>(context, listen: false).homeBannerModel;
    return Scaffold(
        appBar: AppBar(
          title: Text("Test"),
        ),
        body:
        CustomScrollView(
          slivers: [

            SliverGrid(
              delegate: SliverChildBuilderDelegate(
                    (context, index) {
                  return Container(
                    alignment: Alignment.center,
                    color: Colors.teal[100 * (index % 9)],
                    child: Text('grid item $index'),
                  );
                },
                childCount: 10,
              ),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 15,
                crossAxisSpacing: 15,
                childAspectRatio: 2.0,
              ),
            ),


          ],
        )
    );
  }
}

class Choice {
  const Choice({this.title, this.icon});
  final String? title;
  final IconData? icon;
}

const List<Choice> choices = const <Choice>[
  const Choice(title: 'Home', icon: Icons.home),
  const Choice(title: 'Contact', icon: Icons.contacts),
  const Choice(title: 'Map', icon: Icons.map),
  const Choice(title: 'Phone', icon: Icons.phone),
  const Choice(title: 'Camera', icon: Icons.camera_alt),
  const Choice(title: 'Setting', icon: Icons.settings),
  const Choice(title: 'Album', icon: Icons.photo_album),
  const Choice(title: 'WiFi', icon: Icons.wifi),
];

class SelectCard extends StatelessWidget {
  const SelectCard({ this.choice}) : super();
  final Choice? choice;

  @override
  Widget build(BuildContext context) {
    //final TextStyle textStyle = Theme.of(context).textTheme.display1;
    return Card(
        color: Colors.orange,
        child: Center(child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(child: Icon(choice!.icon, size:50.0,)),
              Text(choice!.title.toString(),),
            ]
        ),
        )
    );
  }
}