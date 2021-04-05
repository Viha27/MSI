import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:postgrad/Attendance/Attendance.dart';
import 'package:postgrad/Exam_Results/ExamResults.dart';
import 'package:postgrad/services/teacher_service.dart';
import 'package:postgrad/services/token_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Attendance extends StatefulWidget {
  _AttendanceState createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance> {
  getStringValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String stringValue = prefs.getString('token');

    print(stringValue);
    return stringValue;
  }

  List attendance = [];
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    this.fetchModule();
  }

  fetchModule() async {
    setState(() {
      isLoading = true;
    });
    var url = "http://10.0.2.2:3000/api/get-attendance";
    var token = await getStringValuesSF();
    var response = await http.post(url, headers: {
      'authentication': 'Bearer $token',
    });
    //print(response.body);
    if (response.statusCode == 200) {
      var items = json.decode(response.body)['attendance'];
      print(items);
      setState(() {
        attendance = items;
        isLoading = false;
      });
      print(response);
    } else {
      print(response.statusCode);
      setState(() {
        attendance = [];
        isLoading = false;
        print("Error");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Attendance",
            style: TextStyle(color: Colors.brown),
          ),
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(
            color: Colors.brown, //change your color here
          ),
        ),
        //body: getBody(),
        body: getBody());
  }

  Widget getBody() {
    return ListView.builder(
        itemCount: attendance.length,
        itemBuilder: (context, index) {
          return getCard(attendance[index]);
        });
  }

  Widget getCard(index) {
    var module = index['moduleCode'] + " " + index['moduleName'];
    var total = index['total'];
    var absent = index['count'];
    var type = index['type'];
    var batch = "Batch: " + index['batch'].toString();
    var attendance = (total - absent) / total * 100;
    //var attendance=85;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      shadowColor: Colors.brown,
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
      child: ListTile(
        title: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 65,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.greenAccent[700],
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Icon(
                    Icons.check_box,
                    size: 50,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                SizedBox(
                  width: 250,
                  child: Column(
                    children: [
                      Text(
                        module.toString(),
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                )
              ],
            ),
            Row(
              children: [
                SizedBox(
                  width: 350,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Row(children: [
                        Column(
                          children: [
                            Text(
                              type.toString(),
                              textAlign: TextAlign.left,
                            ),
                            Text(batch.toString(), textAlign: TextAlign.end),
                          ],
                        ),
                        SizedBox(
                          width: 90,
                        ),
                        Row(
                          children: [
                            (attendance < 80
                                ? Container(
                                    width: 150,
                                    height: 60,
                                    decoration: BoxDecoration(
                                        color: Colors.redAccent,
                                        border: Border.all(
                                          color: Colors.redAccent,
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                    child: Text(
                                      "Attendance: " +
                                          attendance.toStringAsFixed(0) +
                                          "%",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                    ),
                                    alignment: Alignment.center,
                                  )
                                : Container(
                                    width: 150,
                                    height: 60,
                                    decoration: BoxDecoration(
                                        color: Colors.green,
                                        border: Border.all(
                                          color: Colors.green,
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                    child: Text(
                                      "Attendance: " +
                                          attendance.toStringAsFixed(0) +
                                          "%",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                    ),
                                    alignment: Alignment.center,
                                  )),
                          ],
                        ),
                      ]),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            color: Colors.blue,
                            onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ExamResults())),
                            child: Text(
                              "Check Attendance",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(
                            width: 40,
                          ),
                          RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            color: Colors.blue,
                            onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ExamResults())),
                            child: Text(
                              "Check Results",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
