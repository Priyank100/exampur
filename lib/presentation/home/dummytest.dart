import 'dart:convert';

import 'package:exampur_mobile/data/model/state_json.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyApp extends StatefulWidget {
  @override
  _UploadImageState createState() => _UploadImageState();
}

class _UploadImageState extends State<MyApp> {
  bool _isLoading = false;
  List<Object> objectList =[];
  late String selectedFruit;
  Future<String> loadFromAssets() async {
    return await rootBundle.loadString('assets/Statejson/State.json');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadYourData();
  }

  loadYourData() async {
    setState(() {
      _isLoading = true;
    });

    String jsonString = await loadFromAssets();
    final StateResponse = stateJsonFromJson(jsonString);
    objectList = StateResponse.states!.cast<Object>();
    setState(() {
      _isLoading = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    String selectedFruit;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(5.0),
                //   border: Border.all(
                //       color: Colors.red, style: BorderStyle.solid, width: 0.80),
                 ),
                child: DropdownButton(
                   // value: selectedFruit,
                    isExpanded: true,
                    icon: Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Icon(Icons.arrow_drop_down),
                    ),
                    iconSize: 25,
                    underline: SizedBox(),
                    onChanged: (newValue) {
                      setState(() {
                        print(newValue);
                       // selectedFruit = newValue;
                      });
                     // print(selectedFruit);
                    },
                    hint: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Select'),
                    ),
                    items: objectList.map((data) {
                      return DropdownMenuItem(
                        value: data.name.toString(),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text(
                            data.name!,
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      );
                    }).toList()),
              ),
            ),
          ),
        ),
      ),
    );
  }
}




FruitResponse fruitResponseFromJson(String str) => FruitResponse.fromJson(json.decode(str));

String fruitResponseToJson(FruitResponse data) => json.encode(data.toJson());

class FruitResponse {
  List<Object>? objects;


  FruitResponse({
    this.objects,

  });

  factory FruitResponse.fromJson(Map<String, dynamic> json) => FruitResponse(
    objects: List<Object>.from(json["objects"].map((x) => Object.fromJson(x))),

  );

  Map<String, dynamic> toJson() => {
    "objects": List<dynamic>.from(objects!.map((x) => x.toJson())),

  };
}

class Object {

  String? name;


  Object({

    this.name,

  });

  factory Object.fromJson(Map<String, dynamic> json) => Object(

    name: json["name"],

  );

  Map<String, dynamic> toJson() => {

    "name": name,

  };
}