// To parse this JSON data, do
//
//     final pay = payFromJson(jsonString);

import 'dart:convert';

Pay payFromJson(String str) => Pay.fromJson(json.decode(str));

String payToJson(Pay data) => json.encode(data.toJson());

class Pay {
  Pay({
    this.status,
    this.payments,
  });

  bool status;
  List<Payment> payments;

  factory Pay.fromJson(Map<String, dynamic> json) => Pay(
        status: json["status"],
        payments: List<Payment>.from(
            json["payments"].map((x) => Payment.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "payments": List<dynamic>.from(payments.map((x) => x.toJson())),
      };
}

class Payment {
  Payment({
    this.id,
    this.slipNo,
    this.amount,
    this.paymentDate,
    this.bank,
    this.studentId,
    this.confirmStatus,
    this.description,
    this.externalNote,
  });

  int id;
  int slipNo;
  int amount;
  DateTime paymentDate;
  String bank;
  String studentId;
  int confirmStatus;
  dynamic description;
  String externalNote;

  factory Payment.fromJson(Map<String, dynamic> json) => Payment(
        id: json["id"],
        slipNo: json["slipNo"],
        amount: json["amount"],
        paymentDate: DateTime.parse(json["paymentDate"]),
        bank: json["bank"],
        studentId: json["studentID"],
        confirmStatus: json["confirmStatus"],
        description: json["description"],
        externalNote: json["externalNote"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "slipNo": slipNo,
        "amount": amount,
        "paymentDate": paymentDate.toIso8601String(),
        "bank": bank,
        "studentID": studentId,
        "confirmStatus": confirmStatus,
        "description": description,
        "externalNote": externalNote,
      };
}
