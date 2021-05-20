// To parse this JSON data, do
//
//     final notifi = notifiFromJson(jsonString);

import 'dart:convert';

Notifi notifiFromJson(String str) => Notifi.fromJson(json.decode(str));

String notifiToJson(Notifi data) => json.encode(data.toJson());

class Notifi {
  Notifi({
    this.status,
    this.notifications,
  });

  bool status;
  List<Notification> notifications;

  factory Notifi.fromJson(Map<String, dynamic> json) => Notifi(
        status: json["status"],
        notifications: List<Notification>.from(
            json["notifications"].map((x) => Notification.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "notifications":
            List<dynamic>.from(notifications.map((x) => x.toJson())),
      };
}

class Notification {
  Notification({
    this.notificationId,
    this.subject,
    this.message,
    this.sender,
    this.timeSent,
    this.received,
    this.recipients,
  });

  int notificationId;
  String subject;
  String message;
  String sender;
  DateTime timeSent;
  bool received;
  List<dynamic> recipients;

  factory Notification.fromJson(Map<String, dynamic> json) => Notification(
        notificationId: json["notificationID"],
        subject: json["subject"],
        message: json["message"],
        sender: json["sender"],
        timeSent: DateTime.parse(json["timeSent"]),
        received: json["received"],
        recipients: List<dynamic>.from(json["recipients"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "notificationID": notificationId,
        "subject": subject,
        "message": message,
        "sender": sender,
        "timeSent": timeSent.toIso8601String(),
        "received": received,
        "recipients": List<dynamic>.from(recipients.map((x) => x)),
      };
}
