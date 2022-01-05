import 'package:exampur_mobile/data/model/CoursesModel.dart';
import 'package:exampur_mobile/data/model/e_books_model.dart';
import 'package:exampur_mobile/provider/Authprovider.dart';
import 'package:exampur_mobile/provider/BooksEBooksProvider.dart';
import 'package:exampur_mobile/provider/HomeBannerProvider.dart';
import 'package:exampur_mobile/provider/courses_provider.dart';
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
  final ScrollController _controller = ScrollController();
  List<EBooks> bookList = [];

  @override
  initState() {
    callProvider();
    super.initState();
    _controller.addListener(_scrollListener);
  }

  Future<void> callProvider() async {
    // bookList = (await Provider.of<BooksEBooksProvider>(context, listen: false).getE_booksList(context))!;
    setState(() {});
  }

  void _scrollListener() {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      callProvider();
    }
  }
    @override
    Widget build(BuildContext context) {
      // final postMdl = Provider.of<CoursesProvider>(context);
      return Scaffold(
          appBar: AppBar(
            title: Text("Test"),
          ),
          body:
          // CustomScrollView(
          //   slivers: [
          //
          //     SliverGrid(
          //       delegate: SliverChildBuilderDelegate(
          //             (context, index) {
          //           return Container(
          //             alignment: Alignment.center,
          //             color: Colors.teal[100 * (index % 9)],
          //             child: Text('grid item $index'),
          //           );
          //         },
          //         childCount: 10,
          //       ),
          //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //         crossAxisCount: 2,
          //         mainAxisSpacing: 15,
          //         crossAxisSpacing: 15,
          //         childAspectRatio: 2.0,
          //       ),
          //     ),
          //
          //
          //   ],
          // )

          // ListView.builder(itemCount: postMdl.coursesModel.length,
          //     itemBuilder: (BuildContext context,int index){
          //   print(postMdl.coursesModel[index].courses!.first.amount.toString());
          //   return Container(child: Text(postMdl.coursesModel[index].courses!.first.amount.toString()),);
          // })

          // Consumer<BooksProvider>(
          //     builder: (context, bookProvider, child) {
          //       return  bookProvider != null ?
          //        ListView.builder(itemCount: bookProvider.ebooksModel.books!.length,
          //           itemBuilder: (BuildContext context,int index){
          //             print(bookProvider.ebooksModel.books![index].title);
          //             return Container(child: Text(bookProvider.ebooksModel.books![index].title.toString()),);
          //           }) : CircularProgressIndicator();
          //     }),

          bookList.length != 0 ?
          ListView.builder(controller: _controller,
              itemCount: bookList.length,
              itemBuilder: (BuildContext context, int index) {
                print(bookList[index].title);
                return Container(
                  child: Text(bookList[index].title.toString()),);
              }) : CircularProgressIndicator()
      );
    }
  }

/*
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
}*/