// To parse this JSON data, do
//
//     final raiseTicket = raiseTicketFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

RaiseTicket raiseTicketFromJson(String str) => RaiseTicket.fromJson(json.decode(str));

String raiseTicketToJson(RaiseTicket data) => json.encode(data.toJson());

class RaiseTicket {
  RaiseTicket({
    required this.type,
    required this.message,
    required this.status,
    required this.userId,
  });

  String type;
  String message;
  String status;
  int userId;

  factory RaiseTicket.fromJson(Map<String, dynamic> json) => RaiseTicket(
    type: json["type"] == null ? "" : json["type"],
    message: json["message"] == null ? "" : json["message"],
    status: json["status"] == null ? "" : json["status"],
    userId: json["user_id"] == null ? "" : json["user_id"],
  );

  Map<String, dynamic> toJson() => {
    "type": type == null ? null : type,
    "message": message == null ? null : message,
    "status": status == null ? null : status,
    "user_id": userId == null ? null : userId,
  };
}
