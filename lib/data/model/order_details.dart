import 'dart:convert';
/// course_id : "61c98d223a7d50ce67803edb"
/// billing_address : "Plot no: 21, Zam Zam Villa, Near Khasra Ground, Motapir Road"
/// billing_city : "Bhuj"
/// billing_state : "Gujarat"
/// billing_country : "India"
/// billing_pincode : "370001"

// OrderDetails orderDetailsFromJson(String str) => OrderDetails.fromJson(json.decode(str));
// String orderDetailsToJson(OrderDetails data) => json.encode(data.toJson());
// class OrderDetails {
//   OrderDetails({
//       String? courseId,
//       String? billingAddress,
//       String? billingCity,
//       String? billingState,
//       String? billingCountry,
//       String? billingPincode,}){
//     _courseId = courseId;
//     _billingAddress = billingAddress;
//     _billingCity = billingCity;
//     _billingState = billingState;
//     _billingCountry = billingCountry;
//     _billingPincode = billingPincode;
// }
//
//   OrderDetails.fromJson(dynamic json) {
//     _courseId = json['course_id'];
//     _billingAddress = json['billing_address'];
//     _billingCity = json['billing_city'];
//     _billingState = json['billing_state'];
//     _billingCountry = json['billing_country'];
//     _billingPincode = json['billing_pincode'];
//   }
//   String? _courseId;
//   String? _billingAddress;
//   String? _billingCity;
//   String? _billingState;
//   String? _billingCountry;
//   String? _billingPincode;
//
//   String? get courseId => _courseId;
//   String? get billingAddress => _billingAddress;
//   String? get billingCity => _billingCity;
//   String? get billingState => _billingState;
//   String? get billingCountry => _billingCountry;
//   String? get billingPincode => _billingPincode;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['course_id'] = _courseId;
//     map['billing_address'] = _billingAddress;
//     map['billing_city'] = _billingCity;
//     map['billing_state'] = _billingState;
//     map['billing_country'] = _billingCountry;
//     map['billing_pincode'] = _billingPincode;
//     return map;
//   }
//
// }
class OrderDetails {
  String? courseId;
  String? billingAddress;
  String? billingCity;
  String? billingstate;
  String? billingCountry;
  String? billingpincode;


  OrderDetails(
      {this.courseId,
        this.billingAddress,
        this.billingCity,
        this.billingstate,
        this.billingCountry,
        this.billingpincode,
       });

  OrderDetails.fromJson(Map<String, dynamic> json) {
    courseId = json['course_id'];
    billingAddress = json['billing_address'];
    billingCity = json['billing_city'];
    billingstate= json['billing_state'];
    billingCountry = json['billing_country'];
    billingpincode = json['billing_pincode'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['course_id'] = this.courseId;
    data['billing_address'] = this.billingAddress;
    data['billing_city'] = this.billingCity;
    data['billing_state'] = this.billingstate;
    data['billing_country'] = this.billingCountry;
    data['billing_pincode'] = this.billingpincode;

    return data;
  }
}



// To parse this JSON data, do
//
//     final orderDetailsModel = orderDetailsModelFromJson(jsonString);



OrderDetailsModel orderDetailsModelFromJson(String str) => OrderDetailsModel.fromJson(json.decode(str));

String orderDetailsModelToJson(OrderDetailsModel data) => json.encode(data.toJson());

class OrderDetailsModel {
  OrderDetailsModel({
    this.statusCode,
    this.data,
  });

  int? statusCode;
  Data? data;

  factory OrderDetailsModel.fromJson(Map<String, dynamic> json) => OrderDetailsModel(
    statusCode: json["statusCode"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "data": data!.toJson(),
  };
}

class Data {
  Data({
    this.orderId,
    this.amount,
    this.paymentSource,
    this.paymentOrderId,
    this.description,
    this.status,
  });

  String? orderId;
  int? amount;
  String? paymentSource;
  String? paymentOrderId;
  String? description;
  String? status;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    orderId: json["order_id"],
    amount: json["amount"],
    paymentSource: json["payment_source"],
    paymentOrderId: json["payment_order_id"],
    description: json["description"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "order_id": orderId,
    "amount": amount,
    "payment_source": paymentSource,
    "payment_order_id": paymentOrderId,
    "description": description,
    "status": status,
  };
}
