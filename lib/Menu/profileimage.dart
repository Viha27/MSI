import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:postgrad/Menu/profilemodel.dart';
import 'package:postgrad/Requests%20and%20Inquiries/Model.dart';

import 'package:shared_preferences/shared_preferences.dart';

class ProfileImg extends StatefulWidget {
  const ProfileImg({Key key}) : super(key: key);

  _ReqsState createState() => _ReqsState();
}

class _ReqsState extends State<ProfileImg> {
  getStringValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String stringValue = prefs.getString('token');
    print(stringValue);
    return stringValue;
  }

  Picture names;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
  }

  Future<Picture> fetchModule() async {
    // setState(() {
    //   isLoading = true;
    // });
    var url =
        "http://ec2-13-233-98-120.ap-south-1.compute.amazonaws.com:3000/api/get-profile-picture";
    var token = await getStringValuesSF();
    final response = await http.post(url, headers: {
      'authentication': 'Bearer $token',
    });
    //print(response.body);
    if (response.statusCode == 200) {
      Picture items = pictureFromJson(response.body);
      print('${items.status}');

      return items;
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Picture>(
        future: fetchModule(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            // Show Loading indicator
            return CircularProgressIndicator();
          } else {
            // Show data if exist
            return Image.network(snapshot.data.profilePicture);
          }
        });
  }
}
