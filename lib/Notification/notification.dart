import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'Model.dart';

import 'package:shared_preferences/shared_preferences.dart';

class Reqsp extends StatefulWidget {
  const Reqsp({Key key}) : super(key: key);

  _ReqspState createState() => _ReqspState();
}

class _ReqspState extends State<Reqsp> {
  getStringValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String stringValue = prefs.getString('token');
    print(stringValue);
    return stringValue;
  }

  Notifi names;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
  }

  Future<Notifi> fetchModule() async {
    // setState(() {
    //   isLoading = true;
    // });
    var url = "http://10.0.2.2:3000/api/get-notifications";
    var token = await getStringValuesSF();
    final response = await http.post(url, headers: {
      'authentication': 'Bearer $token',
    });
    //print(response.body);
    if (response.statusCode == 200) {
      final jsonresponse = json.decode(response.body);
      Notifi items = new Notifi.fromJson(jsonresponse);
      print('${items.status}');

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
            "Notifications",
            style: TextStyle(color: Colors.brown),
          ),
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(
            color: Colors.brown, //change your color here
          ),
        ),
        //body: getBody(),
        body: FutureBuilder<Notifi>(
          future: fetchModule(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              // Show Loading indicator
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                ],
              );
            } else {
              // Show data if exist
              return Column(
                children: snapshot.data.notifications
                    .map(
                      (req) => Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          shadowColor: Colors.brown,
                          margin: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 5.0),
                          child: ListTile(
                              title: Column(children: [
                            Row(
                              children: [
                                Container(
                                    width: 30,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      color: Colors.pinkAccent,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    ),
                                    child: Text('')),
                                SizedBox(
                                  width: 20,
                                ),
                                SizedBox(
                                  width: 250,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 30,
                                      ),
                                      Text(
                                        req.sentBy,
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      SizedBox(
                                        height: 3,
                                      ),
                                      SizedBox(
                                        height: 3,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                          ]))),
                    )
                    .toList(),
              );
              /* 
               return ListView(
                children: snapshot.data.requests[0].requestTypes
                    .map(
                      (req) => ListTile(
                        leading: Text("${req.requestId}"),
                        title: Text(req.request),
                      ),
                    )
                    .toList(),
              ); */
            }
          },
        ));
  }
}
