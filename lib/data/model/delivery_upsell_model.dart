import 'dart:convert';
/// statusCode : 200
/// data : {"order_no":"slPG1655727921RqDf","order_id":"62b0673297b2b2c56106dfcc","amount":1500,"payment_source":"Razorpay","book_selected":true,"upsell_book_details":[{"_id":"624d6a8fcb451e7474c8a3ba","category":["623234574bec0ede0b6c00ed","623234734bec0ede0b6c0100","6232349c4bec0ede0b6c011a","624d20716f3fc07a402ebff0","624d20716f3fc07a402ebff1","624d20716f3fc07a402ebff2","624d20716f3fc07a402ebff3","624d20716f3fc07a402ebff4","624d20716f3fc07a402ebff5","624d20716f3fc07a402ebff6","624d20716f3fc07a402ebff7","624d20716f3fc07a402ebff8","624d20716f3fc07a402ebff9"],"title":"Exampur UP Lekhpal  (Paperback, Hindi, Vivek Sir)","description":"Exampur UP Lekhpal  (Paperback, Hindi, Vivek Sir)Exampur UP Lekhpal  (Paperback, Hindi, Vivek Sir)Exampur UP Lekhpal  (Paperback, Hindi, Vivek Sir)Exampur UP Lekhpal  (Paperback, Hindi, Vivek Sir)Exampur UP Lekhpal  (Paperback, Hindi, Vivek Sir)Exampur UP Lekhpal  (Paperback, Hindi, Vivek Sir)","sort_weightage":0,"regular_price":400,"sale_price":350,"is_ebook":true,"flag":"N/A","status":"Published","macro":[],"created_at":"2022-04-06T10:25:19.412Z","updated_at":"2022-04-06T10:25:43.837Z","pdf_path":"book/RtybVos7-pdf-pdf"}],"payment_order_id":"order_JjkRngxk3KcyTW","description":"Payment for Course: combo course Title","status":"Pending"}

DeliveryUpsellModel deliveryUpsellModelFromJson(String str) => DeliveryUpsellModel.fromJson(json.decode(str));
String deliveryUpsellModelToJson(DeliveryUpsellModel data) => json.encode(data.toJson());

class DeliveryUpsellModel {
  DeliveryUpsellModel({
      int? statusCode, 
      Data? data,}){
    _statusCode = statusCode;
    _data = data;
}

  DeliveryUpsellModel.fromJson(dynamic json) {
    _statusCode = json['statusCode'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  int? _statusCode;
  Data? _data;

  int? get statusCode => _statusCode;
  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['statusCode'] = _statusCode;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }

}

/// order_no : "slPG1655727921RqDf"
/// order_id : "62b0673297b2b2c56106dfcc"
/// amount : 1500
/// payment_source : "Razorpay"
/// book_selected : true
/// upsell_book_details : [{"_id":"624d6a8fcb451e7474c8a3ba","category":["623234574bec0ede0b6c00ed","623234734bec0ede0b6c0100","6232349c4bec0ede0b6c011a","624d20716f3fc07a402ebff0","624d20716f3fc07a402ebff1","624d20716f3fc07a402ebff2","624d20716f3fc07a402ebff3","624d20716f3fc07a402ebff4","624d20716f3fc07a402ebff5","624d20716f3fc07a402ebff6","624d20716f3fc07a402ebff7","624d20716f3fc07a402ebff8","624d20716f3fc07a402ebff9"],"title":"Exampur UP Lekhpal  (Paperback, Hindi, Vivek Sir)","description":"Exampur UP Lekhpal  (Paperback, Hindi, Vivek Sir)Exampur UP Lekhpal  (Paperback, Hindi, Vivek Sir)Exampur UP Lekhpal  (Paperback, Hindi, Vivek Sir)Exampur UP Lekhpal  (Paperback, Hindi, Vivek Sir)Exampur UP Lekhpal  (Paperback, Hindi, Vivek Sir)Exampur UP Lekhpal  (Paperback, Hindi, Vivek Sir)","sort_weightage":0,"regular_price":400,"sale_price":350,"is_ebook":true,"flag":"N/A","status":"Published","macro":[],"created_at":"2022-04-06T10:25:19.412Z","updated_at":"2022-04-06T10:25:43.837Z","pdf_path":"book/RtybVos7-pdf-pdf"}]
/// payment_order_id : "order_JjkRngxk3KcyTW"
/// description : "Payment for Course: combo course Title"
/// status : "Pending"

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      String? orderNo, 
      String? orderId, 
      double? amount,
      String? paymentSource, 
      bool? bookSelected, 
      List<UpsellBookDetails>? upsellBookDetails, 
      String? paymentOrderId, 
      String? description, 
      String? status,}){
    _orderNo = orderNo;
    _orderId = orderId;
    _amount = amount;
    _paymentSource = paymentSource;
    _bookSelected = bookSelected;
    _upsellBookDetails = upsellBookDetails;
    _paymentOrderId = paymentOrderId;
    _description = description;
    _status = status;
}

  Data.fromJson(dynamic json) {
    _orderNo = json['order_no'];
    _orderId = json['order_id'];
    _amount = json['amount'].toDouble();
    _paymentSource = json['payment_source'];
    _bookSelected = json['book_selected'];
    if (json['upsell_book_details'] != null) {
      _upsellBookDetails = [];
      json['upsell_book_details'].forEach((v) {
        _upsellBookDetails?.add(UpsellBookDetails.fromJson(v));
      });
    }
    _paymentOrderId = json['payment_order_id'];
    _description = json['description'];
    _status = json['status'];
  }
  String? _orderNo;
  String? _orderId;
  double? _amount;
  String? _paymentSource;
  bool? _bookSelected;
  List<UpsellBookDetails>? _upsellBookDetails;
  String? _paymentOrderId;
  String? _description;
  String? _status;

  String? get orderNo => _orderNo;
  String? get orderId => _orderId;
  double? get amount => _amount;
  String? get paymentSource => _paymentSource;
  bool? get bookSelected => _bookSelected;
  List<UpsellBookDetails>? get upsellBookDetails => _upsellBookDetails;
  String? get paymentOrderId => _paymentOrderId;
  String? get description => _description;
  String? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['order_no'] = _orderNo;
    map['order_id'] = _orderId;
    map['amount'] = _amount;
    map['payment_source'] = _paymentSource;
    map['book_selected'] = _bookSelected;
    if (_upsellBookDetails != null) {
      map['upsell_book_details'] = _upsellBookDetails?.map((v) => v.toJson()).toList();
    }
    map['payment_order_id'] = _paymentOrderId;
    map['description'] = _description;
    map['status'] = _status;
    return map;
  }

}

/// _id : "624d6a8fcb451e7474c8a3ba"
/// category : ["623234574bec0ede0b6c00ed","623234734bec0ede0b6c0100","6232349c4bec0ede0b6c011a","624d20716f3fc07a402ebff0","624d20716f3fc07a402ebff1","624d20716f3fc07a402ebff2","624d20716f3fc07a402ebff3","624d20716f3fc07a402ebff4","624d20716f3fc07a402ebff5","624d20716f3fc07a402ebff6","624d20716f3fc07a402ebff7","624d20716f3fc07a402ebff8","624d20716f3fc07a402ebff9"]
/// title : "Exampur UP Lekhpal  (Paperback, Hindi, Vivek Sir)"
/// description : "Exampur UP Lekhpal  (Paperback, Hindi, Vivek Sir)Exampur UP Lekhpal  (Paperback, Hindi, Vivek Sir)Exampur UP Lekhpal  (Paperback, Hindi, Vivek Sir)Exampur UP Lekhpal  (Paperback, Hindi, Vivek Sir)Exampur UP Lekhpal  (Paperback, Hindi, Vivek Sir)Exampur UP Lekhpal  (Paperback, Hindi, Vivek Sir)"
/// sort_weightage : 0
/// regular_price : 400
/// sale_price : 350
/// is_ebook : true
/// flag : "N/A"
/// status : "Published"
/// macro : []
/// created_at : "2022-04-06T10:25:19.412Z"
/// updated_at : "2022-04-06T10:25:43.837Z"
/// pdf_path : "book/RtybVos7-pdf-pdf"

UpsellBookDetails upsellBookDetailsFromJson(String str) => UpsellBookDetails.fromJson(json.decode(str));
String upsellBookDetailsToJson(UpsellBookDetails data) => json.encode(data.toJson());
class UpsellBookDetails {
  UpsellBookDetails({
      String? id, 
      List<String>? category, 
      String? title, 
      String? description, 
      int? sortWeightage, 
      int? regularPrice, 
      int? salePrice, 
      bool? isEbook, 
      String? flag, 
      String? status, 
      List<Macro>? macro,
      String? createdAt, 
      String? updatedAt, 
      String? pdfPath,}){
    _id = id;
    _category = category;
    _title = title;
    _description = description;
    _sortWeightage = sortWeightage;
    _regularPrice = regularPrice;
    _salePrice = salePrice;
    _isEbook = isEbook;
    _flag = flag;
    _status = status;
    _macro = macro;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _pdfPath = pdfPath;
}

  UpsellBookDetails.fromJson(dynamic json) {
    _id = json['_id'];
    _category = json['category'] != null ? json['category'].cast<String>() : [];
    _title = json['title'];
    _description = json['description'];
    _sortWeightage = json['sort_weightage'];
    _regularPrice = json['regular_price'];
    _salePrice = json['sale_price'];
    _isEbook = json['is_ebook'];
    _flag = json['flag'];
    _status = json['status'];
    if (json['macro'] != null) {
      _macro = [];
      json['macro'].forEach((v) {
        _macro?.add(Macro.fromJson(v));
      });
    }
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _pdfPath = json['pdf_path'];
  }
  String? _id;
  List<String>? _category;
  String? _title;
  String? _description;
  int? _sortWeightage;
  int? _regularPrice;
  int? _salePrice;
  bool? _isEbook;
  String? _flag;
  String? _status;
  List<Macro>? _macro;
  String? _createdAt;
  String? _updatedAt;
  String? _pdfPath;

  String? get id => _id;
  List<String>? get category => _category;
  String? get title => _title;
  String? get description => _description;
  int? get sortWeightage => _sortWeightage;
  int? get regularPrice => _regularPrice;
  int? get salePrice => _salePrice;
  bool? get isEbook => _isEbook;
  String? get flag => _flag;
  String? get status => _status;
  List<Macro>? get macro => _macro;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get pdfPath => _pdfPath;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['category'] = _category;
    map['title'] = _title;
    map['description'] = _description;
    map['sort_weightage'] = _sortWeightage;
    map['regular_price'] = _regularPrice;
    map['sale_price'] = _salePrice;
    map['is_ebook'] = _isEbook;
    map['flag'] = _flag;
    map['status'] = _status;
    if (_macro != null) {
      map['macro'] = _macro?.map((v) => v.toJson()).toList();
    }
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['pdf_path'] = _pdfPath;
    return map;
  }

}

Macro macroFromJson(String str) => Macro.fromJson(json.decode(str));
String macroToJson(Macro data) => json.encode(data.toJson());
class Macro {
  Macro({
    String? icon,
    String? title,}) {
    _icon = icon;
    _title = title;
  }

  Macro.fromJson(dynamic json) {
    _icon = json['icon'];
    _title = json['title'];
  }

  String? _icon;
  String? _title;

  String? get icon => _icon;

  String? get title => _title;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['icon'] = _icon;
    map['title'] = _title;
    return map;
  }
}