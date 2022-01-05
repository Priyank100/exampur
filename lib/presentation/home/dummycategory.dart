import 'package:exampur_mobile/data/model/ChooseCategoryModel.dart';
import 'package:exampur_mobile/provider/ChooseCategory_provider.dart';
import 'package:exampur_mobile/utils/app_constants.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Dummycategorytest extends StatefulWidget {
  const Dummycategorytest({Key? key}) : super(key: key);

  @override
  _DummycategorytestState createState() => _DummycategorytestState();
}

class _DummycategorytestState extends State<Dummycategorytest> {

  List<Category> categoryList = [];

  @override
  initState() {
    callProvider();
    super.initState();

  }

  Future<void> callProvider() async {

    categoryList = (await Provider.of<ChooseCategoryProvider>(context, listen: false).getChooseCategoryList(context))!;
    setState(() {
      AppConstants.printLog('CategoryList>> ${categoryList.length.toString()}');
    });
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

        categoryList.length != 0 ?
        ListView.builder(
            itemCount: categoryList.length,
            itemBuilder: (BuildContext context, int index) {
              // print(bookList[index].categories);
              return Container(
                child: Text('bookList[index].categories!.first.name.toString()'),);
            }) : CircularProgressIndicator()
    );
  }
}

