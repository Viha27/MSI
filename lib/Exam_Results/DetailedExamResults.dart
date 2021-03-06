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

class DetailedExamResults extends StatefulWidget {
  _DetailedExamResultsState createState()=>_DetailedExamResultsState();
}

class _DetailedExamResultsState extends State<DetailedExamResults>{
  getStringValuesMN() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String moduleName = prefs.getString('moduleName');
    print(moduleName);
    return moduleName;
  }
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
    var url="http://10.0.2.2:3000/api/get-modules";
    var token =await getStringValuesSF();
    var response=await http.post(url, headers: {
      'authentication': 'Bearer $token',
    });
    //print(response.body);
    if(response.statusCode==200){
      var items=json.decode(response.body)['modules'];
      var times=json.decode(response.body)['lectureHours'];
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
    var moduleName= index['moduleCode']+" "+index['moduleName'];
    var credits="Credits: "+index['credits'].toString();
    var semester="Semester: "+index['semester'].toString();
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
                          Text(credits.toString(), textAlign: TextAlign.end),
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
                              Container(
                                  height: 50,
                                  width: 150,
                                  color: Colors.blue,
                                  child: RaisedButton(
                                    color: Colors.blue,
                                    onPressed: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=>ExamResults())),
                                    child:Text("Check Detailed Results", style: TextStyle(color: Colors.white, fontSize: 15,), textAlign: TextAlign.center,),
                                  )
                              ),
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
