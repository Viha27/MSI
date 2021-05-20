// To parse this JSON data, do
//
//     final time = timeFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/src/material/card.dart';

List<Time> timeFromJson(String str) =>
    List<Time>.from(json.decode(str).map((x) => Time.fromJson(x)));

String timeToJson(List<Time> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Time {
  Time({
    this.id,
    this.subject,
    this.startTime,
    this.endTime,
    this.description,
    this.day,
    this.isAllDay,
  });

  int id;
  String subject;
  DateTime startTime;
  DateTime endTime;
  String description;
  int day;
  bool isAllDay;

  factory Time.fromJson(Map<String, dynamic> json) => Time(
        id: json["Id"],
        subject: json["Subject"],
        startTime: DateTime.parse(json["StartTime"]),
        endTime: DateTime.parse(json["EndTime"]),
        description: json["Description"],
        day: json["day"],
        isAllDay: json["IsAllDay"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Subject": subject,
        "StartTime": startTime.toIso8601String(),
        "EndTime": endTime.toIso8601String(),
        "Description": description,
        "day": day,
        "IsAllDay": isAllDay,
      };

  map(Card Function(req) param0) {}
}

class req {
  int id;
  String subject;
  DateTime startTime;
  DateTime endTime;
  String description;
  int day;
  bool isAllDay;
}
