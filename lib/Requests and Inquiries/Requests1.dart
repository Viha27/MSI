import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:postgrad/Attendance/Attendance.dart';
import 'package:postgrad/Exam_Results/ExamResults.dart';
import 'package:postgrad/Requests%20and%20Inquiries/Requests.dart';
import 'package:postgrad/Requests%20and%20Inquiries/Reviewed.dart';
import 'package:postgrad/services/teacher_service.dart';
import 'package:postgrad/services/token_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:date_time_format/date_time_format.dart';

import 'List.dart';

class Req extends StatefulWidget {
  _ReqState createState() => _ReqState();
}

class _ReqState extends State<Req> {
  getStringValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String stringValue = prefs.getString('token');
    print(stringValue);
    return stringValue;
  }

  List courseModules = [];
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
    var url = "http://10.0.2.2:3000/api/get-requests";
    var token = await getStringValuesSF();
    var response = await http.post(url, headers: {
      'authentication': 'Bearer $token',
    });
    //print(response.body);
    if (response.statusCode == 200) {
      var items = json.decode(response.body)['requests'];
      //var times = json.decode(response.body)['lectureHours'];
      print(items);
      setState(() {
        courseModules = items;
        isLoading = false;
      });
      print(response);
    } else {
      print(response.statusCode);
      setState(() {
        courseModules = [];
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
            "Requests and Incuaries",
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
        itemCount: courseModules.length,
        itemBuilder: (context, index) {
          return getCard(courseModules[index]);
        });
  }

  Widget getCard(index) {
    var reqId = index['requestID'];

    var date = DateTime.parse(index['date']);
    var remark = index['remarks'];
    var decision = index['finalDecision'];

    if (decision == null) {
      decision = "pending";
    }

    //var description = index['description'];
    //var credits = "Credits: " + index['credits'].toString();
    //var semester = "Semester: " + index['semester'].toString();
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        shadowColor: Colors.brown,
        margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
        child: ListTile(
            title: Column(children: [
          Row(
            children: [
              Container(
                width: 65,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.pinkAccent,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Icon(
                  Icons.announcement_rounded,
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
                      "Request No : " + reqId.toString(),
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Date: ' +
                          (DateTimeFormat.format(date,
                              format: AmericanDateFormats.dayOfWeek)),
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Text(
                      'Remarks: ' + remark.toString(),
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Text(
                      'Decision: ' + decision.toString(),
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.normal),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                color: Colors.blue,
                onPressed: () => Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Reqs())),
                child: Text(
                  "Requests",
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
                    context, MaterialPageRoute(builder: (context) => Res())),
                child: Text(
                  "Reviewed By",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          )
        ])));
  }
}
