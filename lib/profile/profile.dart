import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Profilepage extends StatefulWidget {
  Profilepage({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<Profilepage> {
  Future<Response> futureAlbum;

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Fetch Data Example'),
        ),
        body: Center(
          child: FutureBuilder<Response>(
            future: futureAlbum,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data.details.firstName);
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              // By default, show a loading spinner.
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}

Future<Response> fetchAlbum() async {
  var url = "http://10.0.2.2:3000/api/get-user-details";
  var token = await getStringValuesSF();
  final response = await http.post(url, headers: {
    'authentication': 'Bearer $token',
  });
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Response.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

getStringValuesSF() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //Return String
  String stringValue = prefs.getString('token');
  print(stringValue);
  return stringValue;
}

Response responseFromJson(String str) => Response.fromJson(json.decode(str));

String responseToJson(Response data) => json.encode(data.toJson());

class Response {
  Response({
    this.status,
    this.details,
    this.educationQualifications,
  });

  bool status;
  Details details;
  List<dynamic> educationQualifications;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
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
