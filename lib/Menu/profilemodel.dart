// To parse this JSON data, do
//
//     final picture = pictureFromJson(jsonString);

import 'dart:convert';

Picture pictureFromJson(String str) => Picture.fromJson(json.decode(str));

String pictureToJson(Picture data) => json.encode(data.toJson());

class Picture {
  Picture({
    this.status,
    this.profilePicture,
  });

  bool status;
  String profilePicture;

  factory Picture.fromJson(Map<String, dynamic> json) => Picture(
        status: json["status"],
        profilePicture: json["profilePicture"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "profilePicture": profilePicture,
      };
}
