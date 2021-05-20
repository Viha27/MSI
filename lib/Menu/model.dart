// To parse this JSON data, do
//
//     final student = studentFromJson(jsonString);

import 'dart:convert';

Student studentFromJson(String str) => Student.fromJson(json.decode(str));

String studentToJson(Student data) => json.encode(data.toJson());

class Student {
  Student({
    this.status,
    this.details,
    this.educationQualifications,
  });

  bool status;
  Details details;
  List<dynamic> educationQualifications;

  factory Student.fromJson(Map<String, dynamic> json) => Student(
        status: json["status"],
        details: Details.fromJson(json["details"]),
        educationQualifications:
            List<dynamic>.from(json["educationQualifications"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "details": details.toJson(),
        "educationQualifications":
            List<dynamic>.from(educationQualifications.map((x) => x)),
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
      };
}
