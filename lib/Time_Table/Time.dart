import 'package:date_time_format/date_time_format.dart';
import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:postgrad/Requests%20and%20Inquiries/Model.dart';
import 'package:postgrad/Time_Table/model.dart';

import 'package:shared_preferences/shared_preferences.dart';

class Saturday extends StatefulWidget {
  const Saturday({Key key}) : super(key: key);

  _ReqsState createState() => _ReqsState();
}

class _ReqsState extends State<Saturday> {
  getStringValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String stringValue = prefs.getString('token');
    print(stringValue);
    return stringValue;
  }

  getStringValuesSFN() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String stringValue = prefs.getString('username');
    print(stringValue);
    return stringValue;
  }

  List<Time> names;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
  }

  Future<List<Time>> fetchModule() async {
    // setState(() {
    //   isLoading = true;
    // });
    var uname = await getStringValuesSFN();

    var url = "http://10.0.2.2:3000/api//get-timetable/$uname/3";

    var token = await getStringValuesSF();
    final response = await http.get(url, headers: {
      'authentication': 'Bearer $token',
    });
    //print(response.body);
    if (response.statusCode == 200) {
      final jsonresponse = json.decode(response.body);
      List<Time> items = timeFromJson(response.body);
      print('${items.length}');

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
            "Saturday",
            style: TextStyle(color: Colors.brown),
          ),
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(
            color: Colors.brown, //change your color here
          ),
        ),
        //body: getBody(),
        body: FutureBuilder<List<Time>>(
          future: fetchModule(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              // Show Loading indicator
              return CircularProgressIndicator();
            } else {
              // Show data if exist
              return Column(
                children: snapshot.data
                    .map(
                      (req) => req.day == 0
                          ? SingleChildScrollView(
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
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          child: Text(
                                            req.subject,
                                            style: Theme.of(context)
                                                .textTheme
                                                .title
                                                .copyWith(
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 8),
                                    Row(
                                      children: <Widget>[
                                        Container(
                                          height: 10,
                                          width: 10,
                                          decoration: BoxDecoration(
                                            color: Colors.green,
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          req.description,
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle
                                              .copyWith(
                                                color: Colors.white,
                                              ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 6,
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Container(
                                          height: 10,
                                          width: 10,
                                          decoration: BoxDecoration(
                                            color: Colors.green,
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                        SizedBox(width: 5),
                                        Text(
                                          (DateTimeFormat.format(req.startTime,
                                                  format: 'H:i') +
                                              ' - ' +
                                              (DateTimeFormat.format(
                                                  req.endTime,
                                                  format: 'H:i'))),
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle
                                              .copyWith(
                                                color: Colors.white,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : Text(''),
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
