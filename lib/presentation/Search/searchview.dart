import 'package:exampur_mobile/utils/images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchView extends StatefulWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
appBar: AppBar(
  iconTheme: IconThemeData(
    color: Colors.black, //change your color here
  ),
  backgroundColor: Colors.white,
  elevation: 0,
  title: Container(
    width: double.infinity,
    // padding: EdgeInsets.only(0),
      decoration: BoxDecoration(
    color: Colors.grey[300],

    borderRadius:  BorderRadius.all(const Radius.circular(12)),
    //       border: Border(
    //   left: BorderSide(10)
    // ),
    boxShadow: [
      BoxShadow(color: Colors.grey.withOpacity(0.1), spreadRadius: 1, blurRadius: 3, offset: Offset(0, 1)) // changes position of shadow
    ],
  ),
      child: TextField(
        cursorColor:Colors.amber,
       // controller: widget.controller,
        //obscureText: _obscureText,
        //focusNode: widget.focusNode,
        textInputAction: TextInputAction.next,

        decoration: InputDecoration(
            suffixIcon: IconButton(icon: Icon(Icons.search,color: Colors.black,), onPressed:(){}),
            hintText:  'Search',
            contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
            isDense: true,
            //filled: true,
            hintStyle: TextStyle(
              color: Colors.grey[600],
            ),
            fillColor: Colors.grey.withOpacity(0.1),
            errorStyle: TextStyle(height: 1.5),
            // focusedBorder: OutlineInputBorder(borderSide: BorderRadius.all( Radius.circular(12)),),
            // hintStyle: titilliumRegular.copyWith(color: Theme.of(context).hintColor),
            border: InputBorder.none),
      )),
),
      backgroundColor: Colors.white.withOpacity(0.9),
      body:Center(
        // child: Column(
        //  // mainAxisAlignment: MainAxisAlignment.center,
        //   //crossAxisAlignment: CrossAxisAlignment.center,
        //   children: [
      child:    Image.asset(Images.offlinebatch,height: 100,width: 120,)
       // ],),
      ) ,
    );
  }
}
