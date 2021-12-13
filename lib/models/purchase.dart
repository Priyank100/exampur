// To parse this JSON data, do
//
//     final purchase = purchaseFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Purchase purchaseFromJson(String str) => Purchase.fromJson(json.decode(str));

String purchaseToJson(Purchase data) => json.encode(data.toJson());

class Purchase {
  Purchase({
    required this.product,
    required this.course,
  });

  List<Product> product;
  List<Course> course;

  factory Purchase.fromJson(Map<String, dynamic> json) => Purchase(
        product: json["product"] == null
            ? []
            : List<Product>.from(
                json["product"].map((x) => Product.fromJson(x))),
        course: json["course"] == null
            ? []
            : List<Course>.from(json["course"].map((x) => Course.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "product": product == null
            ? null
            : List<dynamic>.from(product.map((x) => x.toJson())),
        "course": course == null
            ? null
            : List<dynamic>.from(course.map((x) => x.toJson())),
      };
}

class Course {
  Course({
    required this.course,
    required this.user,
    required this.paymentId,
    required this.amount,
    required this.promoCode,
    required this.finalAmount,
  });

  int course;
  int user;
  int paymentId;
  int amount;
  String promoCode;
  int finalAmount;

  factory Course.fromJson(Map<String, dynamic> json) => Course(
        course: json["course"] == null ? -1 : json["course"],
        user: json["user"] == null ? -1 : json["user"],
        paymentId: json["payment_id"] == null ? -1 : json["payment_id"],
        amount: json["amount"] == null ? -1 : json["amount"],
        promoCode: json["promo_code"] == null ? "" : json["promo_code"],
        finalAmount: json["final_amount"] == null ? -1 : json["final_amount"],
      );

  Map<String, dynamic> toJson() => {
        "course": course == null ? null : course,
        "user": user == null ? null : user,
        "payment_id": paymentId == null ? null : paymentId,
        "amount": amount == null ? null : amount,
        "promo_code": promoCode == null ? null : promoCode,
        "final_amount": finalAmount == null ? null : finalAmount,
      };
}

class Product {
  Product({
    required this.user,
    required this.product,
    required this.paymentId,
    required this.amount,
    required this.promoCode,
    required this.finalAmount,
    required this.billingPhone,
    required this.billingAddress,
    required this.billingCity,
    required this.billingState,
    required this.billingCountry,
    required this.billingPincode,
    required this.status,
  });

  int user;
  int product;
  int paymentId;
  int amount;
  String promoCode;
  int finalAmount;
  String billingPhone;
  String billingAddress;
  String billingCity;
  String billingState;
  String billingCountry;
  String billingPincode;
  String status;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        user: json["user"] == null ? -1 : json["user"],
        product: json["product"] == null ? -1 : json["product"],
        paymentId: json["payment_id"] == null ? -1 : json["payment_id"],
        amount: json["amount"] == null ? -1 : json["amount"],
        promoCode: json["promo_code"] == null ? "" : json["promo_code"],
        finalAmount: json["final_amount"] == null ? -1 : json["final_amount"],
        billingPhone:
            json["billing_phone"] == null ? "" : json["billing_phone"],
        billingAddress:
            json["billing_address"] == null ? "" : json["billing_address"],
        billingCity: json["billing_city"] == null ? "" : json["billing_city"],
        billingState:
            json["billing_state"] == null ? "" : json["billing_state"],
        billingCountry:
            json["billing_country"] == null ? "" : json["billing_country"],
        billingPincode:
            json["billing_pincode"] == null ? "" : json["billing_pincode"],
        status: json["status"] == null ? "" : json["status"],
      );

  Map<String, dynamic> toJson() => {
        "user": user == null ? null : user,
        "product": product == null ? null : product,
        "payment_id": paymentId == null ? null : paymentId,
        "amount": amount == null ? null : amount,
        "promo_code": promoCode == null ? null : promoCode,
        "final_amount": finalAmount == null ? null : finalAmount,
        "billing_phone": billingPhone == null ? null : billingPhone,
        "billing_address": billingAddress == null ? null : billingAddress,
        "billing_city": billingCity == null ? null : billingCity,
        "billing_state": billingState == null ? null : billingState,
        "billing_country": billingCountry == null ? null : billingCountry,
        "billing_pincode": billingPincode == null ? null : billingPincode,
        "status": status == null ? null : status,
      };
}
