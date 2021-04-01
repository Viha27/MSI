import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:postgrad/Attendance/Attendance.dart';
import 'package:postgrad/Course%20Modules/CourseModules.dart';
import 'package:postgrad/Exam_Results/ExamResults.dart';
import 'package:postgrad/Payemnts/Payments.dart';
import 'package:postgrad/Requests%20and%20Inquiries/Requests.dart';
import 'package:postgrad/SignUp/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:postgrad/Time_Table/Time_Table.dart';

class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    final title = 'University of Moratuwa\nFaculty of Information Technology';

    return MaterialApp(
      title: title,
      home: Scaffold(
          appBar: AppBar(
            title: Text(title),
          ),
          body: Padding(
            padding: EdgeInsets.fromLTRB(36, 40, 10, 10),
            child: Column(
              children: [
                Row(children: [
                  Column(children: [
                    Container(
                        height: 150,
                        width: 150,
                        color: Colors.blue,
                        child: RaisedButton(
                          color: Colors.blue,
                          onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CourseModules())),
                          child: Text(
                            "Course Modules",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        )),
                  ]),
                  Padding(padding: EdgeInsets.fromLTRB(10, 20, 10, 10)),
                  Column(children: [
                    Container(
                        height: 150,
                        width: 150,
                        color: Colors.blue,
                        child: RaisedButton(
                          color: Colors.blue,
                          onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Timetable())),
                          child: Text(
                            "Time Table",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        )),
                  ])
                ]),
                Padding(padding: EdgeInsets.fromLTRB(10, 20, 10, 10)),
                Row(children: [
                  Column(children: [
                    Container(
                        height: 150,
                        width: 150,
                        color: Colors.blue,
                        child: RaisedButton(
                          color: Colors.blue,
                          onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Attendance())),
                          child: Text(
                            "Attendance",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        )),
                  ]),
                  Padding(padding: EdgeInsets.fromLTRB(10, 20, 10, 10)),
                  Column(children: [
                    Container(
                        height: 150,
                        width: 150,
                        color: Colors.blue,
                        child: RaisedButton(
                          color: Colors.blue,
                          onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ExamResults())),
                          child: Text(
                            "Exam Results",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        )),
                  ])
                ]),
                Padding(padding: EdgeInsets.fromLTRB(10, 20, 10, 10)),
                Row(children: [
                  Column(children: [
                    Container(
                        height: 150,
                        width: 150,
                        color: Colors.blue,
                        child: RaisedButton(
                          color: Colors.blue,
                          onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Payments())),
                          child: Text(
                            "Payments",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        )),
                  ]),
                  Padding(padding: EdgeInsets.fromLTRB(10, 20, 10, 10)),
                  Column(children: [
                    Container(
                        height: 150,
                        width: 150,
                        color: Colors.blue,
                        child: RaisedButton(
                          color: Colors.blue,
                          onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Requests())),
                          child: Text(
                            "Requests and Inquiries",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        )),
                  ])
                ])
              ],
            ),
          )),
    );
  }
}
