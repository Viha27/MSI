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

class ExamResults extends StatefulWidget {
  _ExamResultsState createState()=>_ExamResultsState();
}

class _ExamResultsState extends State<ExamResults>{
  getStringValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String stringValue = prefs.getString('token');
    print(stringValue);
    return stringValue;
  }

  List courseModules=[];
  bool isLoading=false;
  @override
  void initState(){
    super.initState();
    this.fetchModule();
  }
  fetchModule() async{
    setState(() {
      isLoading = true;
    });
    var url="http://10.0.2.2:3000/api/get-results";
    var token =await getStringValuesSF();
    var response=await http.post(url, headers: {
      'authentication': 'Bearer $token',
    });
    //print(response.body);
    if(response.statusCode==200){
      var items=json.decode(response.body)['results'];
      print(items);
      setState(() {
        courseModules=items;
        isLoading=false;
      });
      print(response);
    }
    else{
      print(response.statusCode);
      setState(() {
        courseModules=[];
        isLoading=false;
        print("Error");
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Exam Results"),
        ),
        //body: getBody(),
        body: getBody()
    );
  }
  Widget getBody() {
    return ListView.builder(
        itemCount: courseModules.length,
        itemBuilder: (context, index){
          return getCard(courseModules[index]);
        }
    );
  }
  Widget getCard(index){
    var grade=index['grade'];
    //var grade="B";
    var year=index['academicYear'];
    var semester="Semester "+index['semester'].toString();
    var moduleName=index['moduleCode']+" "+index['moduleName'];
    return Card(
      child: ListTile(
        title: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                      color: Colors.brown
                  ),
                  child: Icon(
                    Icons.school,
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
                      Text(moduleName.toString(), style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
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
                      Row(
                        children: [
                          Text(year.toString(), textAlign: TextAlign.end),
                        ],
                      ),
                      Row(
                        children: [
                          Text(semester.toString(), textAlign: TextAlign.end),
                          SizedBox(
                            width: 100,
                          ),
                          Column(
                            children: [
                              (grade=='A+') ?
                              Container(
                                height: 40,
                                width: 50,
                                color: Color(0xFF009900),
                                child: Text(grade.toString(), style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 30), textAlign: TextAlign.center, ),
                              ) : (grade=='A')?
                              Container(
                                height: 40,
                                width: 50,
                                color: Color(0xFF00CC00),
                                child: Text(grade.toString(), style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 30), textAlign: TextAlign.center, ),
                              ) : (grade=='A-')?
                              Container(
                                height: 40,
                                width: 50,
                                color: Color(0xFF00FF00),
                                child: Text(grade.toString(), style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 30), textAlign: TextAlign.center, ),
                              ):(grade=='B+')?
                              Container(
                                height: 40,
                                width: 50,
                                color: Color(0xFF80FF00),
                                child: Text(grade.toString(), style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 30), textAlign: TextAlign.center, ),
                              ):(grade=='B')?
                              Container(
                                height: 40,
                                width: 50,
                                color: Color(0xFF99FF33),
                                child: Text(grade.toString(), style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 30), textAlign: TextAlign.center, ),
                              ):(grade=='B')?
                              Container(
                                height: 40,
                                width: 50,
                                color: Color(0xFFB2FF66),
                                child: Text(grade.toString(), style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 30), textAlign: TextAlign.center, ),
                              ):(grade=='C+')?
                              Container(
                                height: 40,
                                width: 50,
                                color: Color(0xFFFFFF00),
                                child: Text(grade.toString(), style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 30), textAlign: TextAlign.center, ),
                              ):(grade=='C')?
                              Container(
                                height: 40,
                                width: 50,
                                color: Color(0xFFFFFF33),
                                child: Text(grade.toString(), style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 30), textAlign: TextAlign.center, ),
                              ):(grade=='C-')?
                              Container(
                                height: 40,
                                width: 50,
                                color: Color(0xFFFFFF66),
                                child: Text(grade.toString(), style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 30), textAlign: TextAlign.center, ),
                              ):Container(
                                height: 40,
                                width: 50,
                                color: Color(0xFFFF0000),
                                child: Text(grade.toString(), style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 30), textAlign: TextAlign.center, ),
                              )

                            ],
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