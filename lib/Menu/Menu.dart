import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:postgrad/Attendance/Attendance.dart';
import 'package:postgrad/Notification/notification.dart';
import 'package:postgrad/Course%20Modules/CourseModules.dart';
import 'package:postgrad/Exam_Results/ExamResults.dart';
import 'package:postgrad/Payemnts/Payments.dart';
import 'package:postgrad/Requests%20and%20Inquiries/Requests.dart';
import 'package:postgrad/Requests%20and%20Inquiries/Requests1.dart';
import 'package:postgrad/SignUp/SignIn.dart';
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
          drawer: NavDrawer(),
          appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.brown),
            title: Text(
              'Main Menu',
              style: TextStyle(color: Colors.brown),
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.notifications_active,
                  color: Colors.brown,
                ),
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Notificationa())),
                // do something
              )
            ],
            backgroundColor: Colors.white,
            centerTitle: true,
          ),
          body: Padding(
            padding: EdgeInsets.fromLTRB(36, 20, 10, 10),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SingleChildScrollView(
                    child: Row(
                      children: [
                        Text(
                          'Postgraduate Department,\nFaculty of Information Technology.',
                          style: TextStyle(
                              color: Colors.brown,
                              fontWeight: FontWeight.bold,
                              fontSize: 22),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(children: [
                    Column(children: [
                      Container(
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50)),
                        child: FlatButton(
                          color: Colors.blueGrey,
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
                        ),
                      ),
                    ]),
                    Padding(padding: EdgeInsets.fromLTRB(10, 20, 10, 10)),
                    Column(children: [
                      Container(
                          height: 150,
                          width: 150,
                          color: Colors.blueGrey,
                          child: RaisedButton(
                            color: Colors.blueGrey,
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
                          color: Colors.blueGrey,
                          child: RaisedButton(
                            color: Colors.blueGrey,
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
                          color: Colors.blueGrey,
                          child: RaisedButton(
                            color: Colors.blueGrey,
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
                          color: Colors.blueGrey,
                          child: RaisedButton(
                            color: Colors.blueGrey,
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
                          color: Colors.blueGrey,
                          child: RaisedButton(
                            color: Colors.blueGrey,
                            onPressed: () => Navigator.push(context,
                                MaterialPageRoute(builder: (context) => Req())),
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
            ),
          )),
    );
  }
}

class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              'Undergraduate Department\nFaculty of Information Technology',
              style: TextStyle(color: Colors.yellow, fontSize: 20),
            ),
            decoration: BoxDecoration(
              color: Colors.brown,

              //image: DecorationImage(
              //  fit: BoxFit.fill,
              //image: AssetImage('assets/images/cover.jpg'))
            ),
          ),
          ListTile(
            leading: Icon(Icons.input),
            title: Text('Welcome'),
            onTap: () => {},
          ),
          ListTile(
            leading: Icon(Icons.verified_user),
            title: Text('Profile'),
            onTap: () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => SignIn())),
          ),
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text('Notifications'),
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => Notificationa())),
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => SignIn())),
          ),
        ],
      ),
    );
  }
}
