import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:postgrad/Requests%20and%20Inquiries/Model.dart';
import 'package:postgrad/Requests%20and%20Inquiries/Requests1.dart';

import 'package:shared_preferences/shared_preferences.dart';

class Res extends StatefulWidget {
  _ResState createState() => _ResState();
}

class _ResState extends State<Res> {
  getStringValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String stringValue = prefs.getString('token');
    print(stringValue);
    return stringValue;
  }

  Users names;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
  }

  Future<Users> fetchModule() async {
    // setState(() {
    //   isLoading = true;
    // });
    var url = "http://10.0.2.2:3000/api/get-requests";
    var token = await getStringValuesSF();
    final response = await http.post(url, headers: {
      'authentication': 'Bearer $token',
    });
    //print(response.body);
    if (response.statusCode == 200) {
      final jsonresponse = json.decode(response.body);
      Users items = new Users.fromJson(jsonresponse);
      print('${items.requests[0].requestTypes[0].request}');

      return items;
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Requests and Incuaries",
            style: TextStyle(color: Colors.brown),
          ),
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(
            color: Colors.brown, //change your color here
          ),
        ),
        //body: getBody(),
        body: FutureBuilder<Users>(
          future: fetchModule(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              // Show Loading indicator
              return CircularProgressIndicator();
            } else {
              // Show data if exist
              return ListView(
                children: snapshot.data.requests[0].reasons
                    .map(
                      (res) => ListTile(
                        leading: Text("${res.requestId}"),
                        title: Text(res.reason),
                      ),
                    )
                    .toList(),
              );
            }
          },
        ));
  }
}
