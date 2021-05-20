// To parse this JSON data, do
//
//     final studetails = studetailsFromJson(jsonString);

import 'dart:convert';

Studetails studetailsFromJson(String str) =>
    Studetails.fromJson(json.decode(str));

String studetailsToJson(Studetails data) => json.encode(data.toJson());

class Studetails {
  Studetails({
    this.status,
    this.details,
    this.educationQualifications,
  });

  bool status;
  Details details;
  List<EducationQualification> educationQualifications;

  factory Studetails.fromJson(Map<String, dynamic> json) => Studetails(
        status: json["status"],
        details: Details.fromJson(json["details"]),
        educationQualifications: List<EducationQualification>.from(
            json["educationQualifications"]
                .map((x) => EducationQualification.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "details": details.toJson(),
        "educationQualifications":
            List<dynamic>.from(educationQualifications.map((x) => x.toJson())),
      };
}

class Details {
  Details({
    this.username,
    this.roleName,
    this.firstName,
    this.lastName,
    this.email,
    this.recoveryEmail,
    this.fullName,
    this.courseName,
    this.address,
    this.dateOfBirth,
    this.nic,
    this.mobile,
    this.home,
    this.designation,
    this.company,
    this.academicYear,
    this.currentGpa,
  });

  String username;
  String roleName;
  String firstName;
  String lastName;
  String email;
  String recoveryEmail;
  String fullName;
  String courseName;
  String address;
  DateTime dateOfBirth;
  String nic;
  String mobile;
  String home;
  String designation;
  String company;
  int academicYear;
  dynamic currentGpa;

  factory Details.fromJson(Map<String, dynamic> json) => Details(
        username: json["username"],
        roleName: json["roleName"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        recoveryEmail: json["recoveryEmail"],
        fullName: json["fullName"],
        courseName: json["courseName"],
        address: json["address"],
        dateOfBirth: DateTime.parse(json["dateOfBirth"]),
        nic: json["nic"],
        mobile: json["mobile"],
        home: json["home"],
        designation: json["designation"],
        company: json["company"],
        academicYear: json["academicYear"],
        currentGpa: json["currentGPA"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "roleName": roleName,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "recoveryEmail": recoveryEmail,
        "fullName": fullName,
        "courseName": courseName,
        "address": address,
        "dateOfBirth": dateOfBirth.toIso8601String(),
        "nic": nic,
        "mobile": mobile,
        "home": home,
        "designation": designation,
        "company": company,
        "academicYear": academicYear,
        "currentGPA": currentGpa,
      };
}

class EducationQualification {
  EducationQualification({
    this.degree,
    this.institute,
    this.dateCompleted,
    this.educationQualificationClass,
  });

  String degree;
  String institute;
  DateTime dateCompleted;
  String educationQualificationClass;

  factory EducationQualification.fromJson(Map<String, dynamic> json) =>
      EducationQualification(
        degree: json["degree"],
        institute: json["institute"],
        dateCompleted: DateTime.parse(json["dateCompleted"]),
        educationQualificationClass: json["class"],
      );

  Map<String, dynamic> toJson() => {
        "degree": degree,
        "institute": institute,
        "dateCompleted": dateCompleted.toIso8601String(),
        "class": educationQualificationClass,
      };
}
