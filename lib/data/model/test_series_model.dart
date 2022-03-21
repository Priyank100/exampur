/// statusCode : 200
/// data : [{"_id":"6236ff2bd245ce6801e92cba","category":["623234734bec0ede0b6c0100"],"title":"222","description":"222","image":"test_series/qN2Vfk4K-0-463457283789346031617784648389-jpg","macro":[{"icon":"Icon 3","title":"xd","_id":"6236ff2bd245ce6801e92cbb"}],"regular_price":100,"sale_price":0,"flag":"N/A"},{"_id":"6236fcfed245ce6801e92c9f","category":["623234574bec0ede0b6c00ed"],"title":"ghhh","description":"hh","image":"test_series/RYLgsHaR-0-61908432935990331626543302041-jpg","macro":[{"icon":"Icon 1","title":"asd","_id":"6236fcfed245ce6801e92ca0"}],"regular_price":134,"sale_price":30,"flag":"New"}]
/// totalCount : 2

class TestSeriesModel {
  TestSeriesModel({
      int? statusCode,
      List<Data>? data,
      int? totalCount,}){
    _statusCode = statusCode;
    _data = data;
    _totalCount = totalCount;
}

  TestSeriesModel.fromJson(dynamic json) {
    _statusCode = json['statusCode'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
    _totalCount = json['totalCount'];
  }
  int? _statusCode;
  List<Data>? _data;
  int? _totalCount;

  int? get statusCode => _statusCode;
  List<Data>? get data => _data;
  int? get totalCount => _totalCount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['statusCode'] = _statusCode;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    map['totalCount'] = _totalCount;
    return map;
  }

}

/// _id : "6236ff2bd245ce6801e92cba"
/// category : ["623234734bec0ede0b6c0100"]
/// title : "222"
/// description : "222"
/// image : "test_series/qN2Vfk4K-0-463457283789346031617784648389-jpg"
/// macro : [{"icon":"Icon 3","title":"xd","_id":"6236ff2bd245ce6801e92cbb"}]
/// regular_price : 100
/// sale_price : 0
/// flag : "N/A"

class Data {
  Data({
      String? id,
      List<String>? category,
      String? title,
      String? description,
      String? image,
      List<Macro>? macro,
      int? regularPrice,
      int? salePrice,
      String? flag,}){
    _id = id;
    _category = category;
    _title = title;
    _description = description;
    _image = image;
    _macro = macro;
    _regularPrice = regularPrice;
    _salePrice = salePrice;
    _flag = flag;
}

  Data.fromJson(dynamic json) {
    _id = json['_id'];
    _category = json['category'] != null ? json['category'].cast<String>() : [];
    _title = json['title'];
    _description = json['description'];
    _image = json['image'];
    if (json['macro'] != null) {
      _macro = [];
      json['macro'].forEach((v) {
        _macro?.add(Macro.fromJson(v));
      });
    }
    _regularPrice = json['regular_price'];
    _salePrice = json['sale_price'];
    _flag = json['flag'];
  }
  String? _id;
  List<String>? _category;
  String? _title;
  String? _description;
  String? _image;
  List<Macro>? _macro;
  int? _regularPrice;
  int? _salePrice;
  String? _flag;

  String? get id => _id;
  List<String>? get category => _category;
  String? get title => _title;
  String? get description => _description;
  String? get image => _image;
  List<Macro>? get macro => _macro;
  int? get regularPrice => _regularPrice;
  int? get salePrice => _salePrice;
  String? get flag => _flag;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['category'] = _category;
    map['title'] = _title;
    map['description'] = _description;
    map['image'] = _image;
    if (_macro != null) {
      map['macro'] = _macro?.map((v) => v.toJson()).toList();
    }
    map['regular_price'] = _regularPrice;
    map['sale_price'] = _salePrice;
    map['flag'] = _flag;
    return map;
  }

}

/// icon : "Icon 3"
/// title : "xd"
/// _id : "6236ff2bd245ce6801e92cbb"

class Macro {
  Macro({
      String? icon,
      String? title,
      String? id,}){
    _icon = icon;
    _title = title;
    _id = id;
}

  Macro.fromJson(dynamic json) {
    _icon = json['icon'];
    _title = json['title'];
    _id = json['_id'];
  }
  String? _icon;
  String? _title;
  String? _id;

  String? get icon => _icon;
  String? get title => _title;
  String? get id => _id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['icon'] = _icon;
    map['title'] = _title;
    map['_id'] = _id;
    return map;
  }

}