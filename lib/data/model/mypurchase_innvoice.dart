import 'dart:convert';
/// statusCode : 200
/// data : {"_id":"61fa769102ada41f40916e5f","order_no":18,"date":"02-02-2022","payment_source":"Razorpay","transaction_id":"pay_Ir8cRS3fLkVw5W","amount":1999,"promo_code":null,"final_amount":1999,"product":{"type":"Course","_id":"61c98d223a7d50ce67803edb","title":"Course 1","logo_path":"course/DGUKTpZX-logo_exampur.png","banner_path":"course/12JNP4Uo-banner_course_2.jpeg"}}

MypurchaseInnvoice mypurchaseInnvoiceFromJson(String str) => MypurchaseInnvoice.fromJson(json.decode(str));
String mypurchaseInnvoiceToJson(MypurchaseInnvoice data) => json.encode(data.toJson());
class MypurchaseInnvoice {
  MypurchaseInnvoice({
      int? statusCode,
    InvoiceData? data,}){
    _statusCode = statusCode;
    _data = data;
}

  MypurchaseInnvoice.fromJson(dynamic json) {
    _statusCode = json['statusCode'];
    _data = json['data'] != null ? InvoiceData.fromJson(json['data']) : null;
  }
  int? _statusCode;
  InvoiceData? _data;

  int? get statusCode => _statusCode;
  InvoiceData? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['statusCode'] = _statusCode;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }

}

/// _id : "61fa769102ada41f40916e5f"
/// order_no : 18
/// date : "02-02-2022"
/// payment_source : "Razorpay"
/// transaction_id : "pay_Ir8cRS3fLkVw5W"
/// amount : 1999
/// promo_code : null
/// final_amount : 1999
/// product : {"type":"Course","_id":"61c98d223a7d50ce67803edb","title":"Course 1","logo_path":"course/DGUKTpZX-logo_exampur.png","banner_path":"course/12JNP4Uo-banner_course_2.jpeg"}

InvoiceData dataFromJson(String str) => InvoiceData.fromJson(json.decode(str));
String dataToJson(InvoiceData data) => json.encode(data.toJson());
class InvoiceData {
  InvoiceData({
      String? id, 
      String? orderNo,
      String? date, 
      String? paymentSource, 
      String? transactionId, 
      double? amount,
      dynamic promoCode, 
      double? finalAmount,
      Product? product,
      EmiPlans? emiPlans,
      int? emiPaidTill,
      double? emiTotalAmount,
      double? pendingEmiAmount,
      int? totalInstallmentPending
  }){
    _id = id;
    _orderNo = orderNo;
    _date = date;
    _paymentSource = paymentSource;
    _transactionId = transactionId;
    _amount = amount;
    _promoCode = promoCode;
    _finalAmount = finalAmount;
    _product = product;
    _emiPlans = emiPlans;
    _emiPaidTill = emiPaidTill;
    _emiTotalAmount = emiTotalAmount;
    _pendingEmiAmount = pendingEmiAmount;
    _totalInstallmentPending = totalInstallmentPending;
}

  InvoiceData.fromJson(dynamic json) {
    _id = json['_id'];
    _orderNo = json['order_no'].toString();
    _date = json['date'];
    _paymentSource = json['payment_source'];
    _transactionId = json['transaction_id'];
    _amount = json['amount'].toDouble();
    _promoCode = json['promo_code'];
    _finalAmount = json['final_amount'].toDouble();
    _product = json['product'] != null ? Product.fromJson(json['product']) : null;
    _emiPlans = json['emi_plans'] != null ? EmiPlans.fromJson(json['emi_plans']) : null;
    _emiPaidTill = json['emi_paid_till']??null;
    _emiTotalAmount = json['emi_totol_amount'] != null ? json['emi_totol_amount'].toDouble() : null;
    _pendingEmiAmount = json['pending_emi_amount'] != null ? json['pending_emi_amount'].toDouble() : null;
    _totalInstallmentPending = json['total_installment_pending']??null;
  }
  String? _id;
  String? _orderNo;
  String? _date;
  String? _paymentSource;
  String? _transactionId;
  double? _amount;
  dynamic _promoCode;
  double? _finalAmount;
  Product? _product;
  EmiPlans? _emiPlans;
  int? _emiPaidTill;
  double? _emiTotalAmount;
  double? _pendingEmiAmount;
  int? _totalInstallmentPending;


  String? get id => _id;
  String? get orderNo => _orderNo;
  String? get date => _date;
  String? get paymentSource => _paymentSource;
  String? get transactionId => _transactionId;
  double? get amount => _amount;
  dynamic get promoCode => _promoCode;
  double? get finalAmount => _finalAmount;
  Product? get product => _product;
  EmiPlans? get emiPlans => _emiPlans;
  int? get emiPaidTill => _emiPaidTill;
  double? get emiTotalAmount => _emiTotalAmount;
  double? get pendingEmiAmount => _pendingEmiAmount;
  int? get totalInstallmentPending => _totalInstallmentPending;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['order_no'] = _orderNo;
    map['date'] = _date;
    map['payment_source'] = _paymentSource;
    map['transaction_id'] = _transactionId;
    map['amount'] = _amount;
    map['promo_code'] = _promoCode;
    map['final_amount'] = _finalAmount;
    if (_product != null) {
      map['product'] = _product?.toJson();
    }
    if (_emiPlans != null) {
      map['emi_plans'] = _emiPlans?.toJson();
    }
    map['emi_paid_till'] = _emiPaidTill;
    map['emi_totol_amount'] = _emiTotalAmount;
    map['pending_emi_amount'] = _pendingEmiAmount;
    map['total_installment_pending'] = _totalInstallmentPending;
    return map;
  }

}

/// type : "Course"
/// _id : "61c98d223a7d50ce67803edb"
/// title : "Course 1"
/// logo_path : "course/DGUKTpZX-logo_exampur.png"
/// banner_path : "course/12JNP4Uo-banner_course_2.jpeg"

Product productFromJson(String str) => Product.fromJson(json.decode(str));
String productToJson(Product data) => json.encode(data.toJson());
class Product {
  Product({
      String? type, 
      String? id, 
      String? title, 
      String? logoPath, 
      String? bannerPath,}){
    _type = type;
    _id = id;
    _title = title;
    _logoPath = logoPath;
    _bannerPath = bannerPath;
}

  Product.fromJson(dynamic json) {
    _type = json['type'];
    _id = json['_id'];
    _title = json['title'];
    _logoPath = json['logo_path'];
    _bannerPath = json['banner_path'];
  }
  String? _type;
  String? _id;
  String? _title;
  String? _logoPath;
  String? _bannerPath;

  String? get type => _type;
  String? get id => _id;
  String? get title => _title;
  String? get logoPath => _logoPath;
  String? get bannerPath => _bannerPath;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = _type;
    map['_id'] = _id;
    map['title'] = _title;
    map['logo_path'] = _logoPath;
    map['banner_path'] = _bannerPath;
    return map;
  }

}

EmiPlans emiPlansFromJson(String str) => EmiPlans.fromJson(json.decode(str));
String emiPlansToJson(EmiPlans data) => json.encode(data.toJson());
class EmiPlans {
  EmiPlans({
    String? title,
    String? emiPaidEvery,
    String? costPerEmi,
    String? totalMonths,
    String? id,
  }){
    _title = title;
    _emiPaidEvery = emiPaidEvery;
    _costPerEmi = costPerEmi;
    _totalMonths = totalMonths;
    _id = id;
  }

  EmiPlans.fromJson(dynamic json) {
    _title = json['title']==null?'':json['title'].toString();
    _emiPaidEvery = json['emi_paid_every']==null?'':json['emi_paid_every'].toString();
    _costPerEmi = json['cost_per_emi']==null?'':json['cost_per_emi'].toString();
    _totalMonths = json['total_months']==null?'':json['total_months'].toString();
    _id = json['_id']==null?'':json['_id'].toString();
  }
  String? _title;
  String? _emiPaidEvery;
  String? _costPerEmi;
  String? _totalMonths;
  String? _id;

  String? get title => _title;
  String? get emiPaidEvery => _emiPaidEvery;
  String? get costPerEmi => _costPerEmi;
  String? get totalMonths => _totalMonths;
  String? get id => _id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = _title;
    map['emi_paid_every'] = _emiPaidEvery;
    map['cost_per_emi'] = _costPerEmi;
    map['total_months'] = _totalMonths;
    map['_id'] = _id;
    return map;
  }

}