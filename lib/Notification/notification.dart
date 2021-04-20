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

import 'helloworld.dart';

class Notificationa extends StatefulWidget {
  _NotificationaState createState() => _NotificationaState();
}

class _NotificationaState extends State<Notificationa> {
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
    var url = "http://10.0.2.2:2000/Notifications";
    //var token = await getStringValuesSF();
    var response = await http.get(url);
    //print(response.body);
    if (response.statusCode == 200) {
      var items = json.decode(response.body)['Notifications'];
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
            "Notifications",
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
    var subject = index['Subject'].toString();
    //var description = index['moduleName'];
    var message = index['Message'];
    var id = index['id'].toString();
    var comlete = index['complete'];
    //var lecturehall = index['LectureHall'];
    var color1;

    if (comlete == true) {
      color1 = Colors.redAccent;
    } else {
      color1 = Colors.greenAccent[700];
    }

    return SingleChildScrollView(
      child: Center(
          child: Container(
        width: 400,
        height: 200,
        padding: new EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            color: color1,
            elevation: 10,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(Icons.album, size: 60),
                Text(subject,
                    style:
                        TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold)),
                Text(message, style: TextStyle(fontSize: 18.0)),
                ButtonBar(
                  children: <Widget>[
                    RaisedButton(
                      child: const Text('Remember Me'),
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Helloworld())),
                    ),
                    RaisedButton(
                      child: const Text('Done'),
                      onPressed: () {/* ... */},
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
