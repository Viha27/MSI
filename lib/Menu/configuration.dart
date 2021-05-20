import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:postgrad/Menu/model.dart';
import 'package:postgrad/Requests%20and%20Inquiries/Model.dart';
import 'package:postgrad/profile/profile.dart';

import 'package:shared_preferences/shared_preferences.dart';

class Draver extends StatefulWidget {
  const Draver({Key key}) : super(key: key);

  _ReqsState createState() => _ReqsState();
}

class _ReqsState extends State<Draver> {
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
    var url = "http://10.0.2.2:3000/api/get-user-details";
    var token = await getStringValuesSF();
    final response = await http.post(url, headers: {
      'authentication': 'Bearer $token',
    });
    //print(response.body);
    if (response.statusCode == 200) {
      final jsonresponse = json.decode(response.body);
      Student items = studentFromJson(response.body);
      print('${items.details.email}');

      return items;
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Student>(
        future: fetchModule(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            // Show Loading indicator
            return CircularProgressIndicator();
          } else {
            // Show data if exist
            return Container(
              color: Colors.amberAccent,
              child: Drawer(
                child: ListView(
                  padding: EdgeInsets.all(10),
                  children: <Widget>[
                    UserAccountsDrawerHeader(
                      accountName: Text(
                        snapshot.data.details.fullName,
                        style: TextStyle(fontSize: 18),
                      ),
                      accountEmail: Text(snapshot.data.details.email),
                      currentAccountPicture: Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage:
                              ExactAssetImage('assets/images/pp.jpg'),
                        ),
                      ),
                      onDetailsPressed: () {},
                      decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.7),

                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                          border:
                              Border.all(color: Colors.blueAccent, width: 10),
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
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Profilepage())),
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
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Profilepage())),
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
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Profilepage())),
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
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Profilepage())),
                    ),
                  ],
                ),
              ),
            );
          }
        });
  }
}
