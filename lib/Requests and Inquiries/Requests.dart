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
import 'package:date_time_format/date_time_format.dart';

class Requests extends StatefulWidget {
  _RequestsState createState() => _RequestsState();
}

class _RequestsState extends State<Requests> {
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
      // var times = json.decode(response.body)['lectureHours'];
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
            "Requests and Inquiries",
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
    var status = index['remarks'];
    var date = DateTime.parse(index['date']);
    var reqId = index['requestId'].toString();
    var finalDecision = index['finalDecision'].toString();
    var decision;
    var request;

    if (finalDecision == '1') {
      decision = 'Pending - Reviewer Level 1 ';
    } else if (finalDecision == '2') {
      decision = 'Pending - Reviewer Level 2 ';
    } else if (finalDecision == '3') {
      decision = 'Pending - Reviewer Level 3 ';
    } else {
      decision = 'Accepted';
    }

    if (reqId == '6') {
      request = 'Extension - Permitted Duration up to maximum duration ';
    } else if (finalDecision == '5') {
      request =
          'To sit examinations with next batch as first attempt candidate ';
    } else if (finalDecision == '4') {
      request = 'Deferment ';
    } else if (finalDecision == '3') {
      request = 'Extension - Permitted Duration up to maximum duration ';
    } else if (finalDecision == '2') {
      request = 'Deregistration from course module ';
    } else {
      request = 'Request is not Valid';
    }

    /* var description = index['description'];
    var credits = "Credits: " + index['credits'].toString();
    var semester = "Semester: " + index['semester'].toString(); */
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(35),
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
                    color: Colors.deepPurpleAccent,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Icon(
                    Icons.request_page,
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
                        request,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Submission Date: ' +
                            (DateTimeFormat.format(date,
                                format: AmericanDateFormats.dayOfWeek)),
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueGrey),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        status.toString(),
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.redAccent),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        decision,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.greenAccent[700]),
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
