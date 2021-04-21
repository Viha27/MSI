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

class Timetable extends StatefulWidget {
  _TimetableState createState() => _TimetableState();
}

class _TimetableState extends State<Timetable> {
  getStringValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String stringValue = prefs.getString('token');

    print(stringValue);
    return stringValue;
  }

  getStringValuesUN() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String stringValue = prefs.getString('username');

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

    var uname = await getStringValuesUN();
    var url = "http://10.0.2.2:3000/api/get-timetable/$uname/3";
    //var token = await getStringValuesSF();
    var response = await http.get(url);
    //print(response.body);
    if (response.statusCode == 200) {
      var items = json.decode(response.body);
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
            "Time Table",
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
    var moduleName = index['Subject'];
    //var description = index['moduleName'];
    var credits1 = index['Description'].toString();
    var credits = index['Description'].toString();
    var start = DateTime.parse(index['StartTime']);
    var end = DateTime.parse(index['EndTime']);
    //var lecturehall = index['LectureHall'];
    var color1;
    var icon;
    var color2;

    if (credits1 == "Lecture") {
      color1 = Colors.white;
      color2 = Colors.blue;
      icon = Icons.people;
    } else {
      color1 = Colors.yellowAccent[100];
      color2 = Colors.red;
      icon = Icons.computer;
    }

    return Card(
      color: color1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      shadowColor: Colors.brown,
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      child: ListTile(
        leading: Container(
          width: 65,
          height: 60,
          decoration: BoxDecoration(
            color: color2,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Icon(
            icon,
            size: 45,
            color: Colors.white,
          ),
        ),
        title: Column(children: [
          Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                moduleName.toString(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                credits.toString(),
                style: TextStyle(
                  fontSize: 17.0,
                  color: color2,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Start :' +
                    (DateTimeFormat.format(start, format: 'D, M j, H:i')),
                style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.normal,
                    color: Colors.black),
              ),
              Text(
                'End  :' + (DateTimeFormat.format(end, format: 'D, M j, H:i')),
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          )
        ]),
      ),
    );
    /* return Card(
      
      child: ListTile(
        
        title: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(color: Colors.brown),
                  child: Icon(
                    Icons.menu_book,
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
                        moduleName.toString(),
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
                      Text(
                        lecturehall.toString(),
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Text(credits.toString(), textAlign: TextAlign.end),
                        ],
                      ),
                      Row(
                        children: [
                          Text(semester.toString(), textAlign: TextAlign.end),
                        ],
                      ),
                      Row(
                        children: [
                          Text(semester1.toString(), textAlign: TextAlign.end),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Container(
                              height: 50,
                              width: 120,
                              color: Colors.blue,
                              child: RaisedButton(
                                color: Colors.blue,
                                onPressed: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Attendance())),
                                child: Text(
                                  "Check Attendance",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              )),
                          SizedBox(
                            width: 40,
                          ),
                          Container(
                              height: 50,
                              width: 120,
                              color: Colors.blue,
                              child: RaisedButton(
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
                              )),
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
 */
  }
}
