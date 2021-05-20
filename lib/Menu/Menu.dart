import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:postgrad/Attendance/Attendance.dart';
import 'package:postgrad/Menu/configuration.dart';
import 'package:postgrad/Notification/notification.dart';
import 'package:postgrad/Course%20Modules/CourseModules.dart';
import 'package:postgrad/Exam_Results/ExamResults.dart';
import 'package:postgrad/Payemnts/Payments.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:postgrad/Requests%20and%20Inquiries/Requests.dart';
import 'package:postgrad/Requests%20and%20Inquiries/Requests1.dart';
import 'package:postgrad/Requests%20and%20Inquiries/List.dart';
import 'package:postgrad/Sheduler/app.dart';
import 'package:postgrad/SignUp/SignIn.dart';
import 'package:postgrad/SignUp/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:postgrad/Time_Table/Time.dart';
import 'package:postgrad/Time_Table/Time_Table.dart';
import 'package:postgrad/profile/profile.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'model.dart';

class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  int _currentIndex = 0;
  getStringValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String stringValue = prefs.getString('token');
    print(stringValue);
    return stringValue;
  }

  Student names;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
  }

  Future<Student> fetchModule() async {
    // setState(() {
    //   isLoading = true;
    // });
    var url = "http://10.0.2.2:3000/api/get-requests";
    var token = await getStringValuesSF();
    final response = await http.post(url, headers: {
      'authentication': 'Bearer $token',
    });
    //print(response.body);
    if (response.statusCode == 200) {
      final jsonresponse = json.decode(response.body);
      Student items = studentFromJson(response.body);
      print('${items.status}');

      return items;
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final title = 'University of Moratuwa\nFaculty of Information Technology';

    return MaterialApp(
      title: title,
      home: Scaffold(
        drawer: Draver(),
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
              onPressed: () => Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Reqsp())),
              // do something
            )
          ],
          backgroundColor: Colors.white,
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.fromLTRB(32, 20, 10, 10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SingleChildScrollView(
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.all(2),
                        padding: EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Text(
                          'Postgraduate Department,\nFaculty of Information Technology.',
                          style: TextStyle(
                              color: Colors.brown,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: Image.asset('assets/images/homephoto.jpg'),
                ),
                Row(children: [
                  Column(children: [
                    Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.4),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                          border:
                              Border.all(color: Colors.blueAccent, width: 10),
                          borderRadius: BorderRadius.circular(10)),
                      child: FlatButton(
                        color: Colors.blueAccent,
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
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.4),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                          border:
                              Border.all(color: Colors.blueAccent, width: 10),
                          borderRadius: BorderRadius.circular(10)),
                      child: FlatButton(
                        color: Colors.blueAccent,
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
                      ),
                    ),
                  ]),
                ]),
                Padding(padding: EdgeInsets.fromLTRB(10, 20, 10, 10)),
                Row(children: [
                  Column(children: [
                    Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.4),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                          border:
                              Border.all(color: Colors.blueAccent, width: 10),
                          borderRadius: BorderRadius.circular(10)),
                      child: FlatButton(
                        color: Colors.blueAccent,
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Attendance())),
                        child: Text(
                          "Attendance",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
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
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.4),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                          border:
                              Border.all(color: Colors.blueAccent, width: 10),
                          borderRadius: BorderRadius.circular(10)),
                      child: FlatButton(
                        color: Colors.blueAccent,
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
                      ),
                    ),
                  ])
                ]),
                Padding(padding: EdgeInsets.fromLTRB(10, 20, 10, 10)),
                Row(children: [
                  Column(children: [
                    Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.4),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                          border:
                              Border.all(color: Colors.blueAccent, width: 10),
                          borderRadius: BorderRadius.circular(10)),
                      child: FlatButton(
                        color: Colors.blueAccent,
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
                      ),
                    ),
                  ]),
                  Padding(padding: EdgeInsets.fromLTRB(10, 20, 10, 10)),
                  Column(children: [
                    Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.4),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                          border:
                              Border.all(color: Colors.blueAccent, width: 10),
                          borderRadius: BorderRadius.circular(10)),
                      child: FlatButton(
                        color: Colors.blueAccent,
                        onPressed: () => Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Req())),
                        child: Text(
                          "Request and Inquiries",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ])
                ])
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomNavyBar(
          selectedIndex: _currentIndex,
          showElevation: true,
          itemCornerRadius: 24,
          curve: Curves.easeIn,
          onItemSelected: (index) => setState(() => _currentIndex = index),
          items: <BottomNavyBarItem>[
            BottomNavyBarItem(
              icon: Icon(Icons.apps),
              title: Text('Home'),
              activeColor: Colors.purple,
              textAlign: TextAlign.center,
            ),
            BottomNavyBarItem(
              icon: Icon(Icons.people),
              title: Text('Users'),
              activeColor: Colors.purple,
              textAlign: TextAlign.center,
            ),
            BottomNavyBarItem(
              icon: Icon(Icons.message),
              title: Text(
                'Messages test for mes teset test test ',
              ),
              activeColor: Colors.purple,
              textAlign: TextAlign.center,
            ),
            BottomNavyBarItem(
              icon: Icon(Icons.logout),
              title: Text('Logout'),
              activeColor: Colors.purple,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var email = getStringValuesSF();
    return Container(
      color: Colors.amberAccent,
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.all(10),
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(
                email,
                style: TextStyle(fontSize: 18),
              ),
              accountEmail: Text('aleydon@gmail.com'),
              currentAccountPicture: CircleAvatar(
                backgroundImage: ExactAssetImage('assets/images/stu.png'),
              ),
              onDetailsPressed: () {},
              decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.7),

                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                  border: Border.all(color: Colors.blueAccent, width: 10),
                  borderRadius: BorderRadius.circular(10)),
            ),
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  ListTile(
                    tileColor: Colors.purple,
                    leading: Icon(
                      Icons.verified_user,
                      color: Colors.white,
                    ),
                    title: Text(
                      'Profile',
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Profilepage())),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  ListTile(
                    tileColor: Colors.purple,
                    leading: Icon(
                      Icons.notifications_active_outlined,
                      color: Colors.white,
                    ),
                    title: Text(
                      'Notification',
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Profilepage())),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  ListTile(
                    tileColor: Colors.purple,
                    leading: Icon(
                      Icons.timer,
                      color: Colors.white,
                    ),
                    title: Text(
                      'Time table',
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Profilepage())),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            ListTile(
              tileColor: Colors.purple,
              leading: Icon(
                Icons.exit_to_app_outlined,
                color: Colors.white,
              ),
              title: Text(
                'Logout',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Profilepage())),
            ),
          ],
        ),
      ),
    );
  }
}
