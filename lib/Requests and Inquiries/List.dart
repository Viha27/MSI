import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:postgrad/Requests%20and%20Inquiries/Model.dart';

import 'package:shared_preferences/shared_preferences.dart';

class Reqs extends StatefulWidget {
  final int index;
  const Reqs({Key key, this.index}) : super(key: key);

  _ReqsState createState() => _ReqsState();
}

class _ReqsState extends State<Reqs> {
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
    var url =
        "http://ec2-13-233-98-120.ap-south-1.compute.amazonaws.com:3000/api/get-requests";
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
            "Requests",
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
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                ],
              );
            } else {
              // Show data if exist
              return Column(
                children: snapshot.data
                    .requests[snapshot.data.requests.length - 1].requestTypes
                    .map((req) => SingleChildScrollView(
                          child: Container(
                            padding: EdgeInsets.all(16),
                            margin: EdgeInsets.fromLTRB(1, 3, 16, 3),
                            decoration: BoxDecoration(
                                color: Colors.deepPurple,
                                borderRadius: BorderRadius.horizontal(
                                  right: Radius.circular(16),
                                )),
                            child: Column(
                              children: <Widget>[
                                Wrap(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          height: 10,
                                          width: 10,
                                          decoration: BoxDecoration(
                                            color: Colors.green,
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        Container(
                                          child: Expanded(
                                            child: Text(
                                              req.request,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .title
                                                  .copyWith(
                                                    color: Colors.white,
                                                    fontSize: 18,
                                                  ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ))
                    .toList(),
              );
            }
          },
        ));
  }
}
