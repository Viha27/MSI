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

class Attendance extends StatefulWidget {
  _AttendanceState createState()=>_AttendanceState();
}

class _AttendanceState extends State<Attendance>{
  getStringValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String stringValue = prefs.getString('token');
    print(stringValue);
    return stringValue;
  }

  List attendance=[];
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
    var url="http://10.0.2.2:3000/api/get-attendance";
    var token =await getStringValuesSF();
    var response=await http.post(url, headers: {
      'authentication': 'Bearer $token',
    });
    //print(response.body);
    if(response.statusCode==200){
      var items=json.decode(response.body)['attendance'];
      print(items);
      setState(() {
        attendance=items;
        isLoading=false;
      });
      print(response);
    }
    else{
      print(response.statusCode);
      setState(() {
        attendance=[];
        isLoading=false;
        print("Error");
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Attendance"),
        ),
        //body: getBody(),
        body: getBody()
    );
  }
  Widget getBody() {
    return ListView.builder(
        itemCount: attendance.length,
        itemBuilder: (context, index){
          return getCard(attendance[index]);
        }
    );
  }
  Widget getCard(index){
    var module=index['moduleCode']+" "+index['moduleName'];
    var total= index['total'];
    var absent = index['count'];
    var type=index['type'];
    var batch="Batch: "+index['batch'].toString();
    var attendance=(total-absent)/total*100;
    //var attendance=85;
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
                    Icons.check_box,
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
                      Text(module.toString(), style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
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
                              Text(type.toString(), textAlign: TextAlign.left,),
                        ],
                      ),
                      Row(
                        children: [
                          Text(batch.toString(), textAlign: TextAlign.end),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          (attendance<80? SizedBox(
                            width: 150,
                            height: 60,
                            child: Container(
                              color: Colors.red,
                              child: Text("Attendance: "+attendance.toStringAsFixed(0)+"%", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold), textAlign: TextAlign.center,), alignment: Alignment.center,
                            ),
                          ):SizedBox(
                            child: Container(
                              width: 150,
                              height: 60,
                              color: Colors.green,
                              child: Text("Attendance: "+attendance.toStringAsFixed(0)+"%", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold), textAlign: TextAlign.center,), alignment: Alignment.center,
                            ),
                          ))
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
                                onPressed: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=>ExamResults())),
                                child:Text("Check Attendance", style: TextStyle(color: Colors.white, fontSize: 15,), textAlign: TextAlign.center,),
                              )
                          ),
                          SizedBox(
                            width: 40,
                          ),
                          Container(
                              height: 50,
                              width: 120,
                              color: Colors.blue,
                              child: RaisedButton(
                                color: Colors.blue,
                                onPressed: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=>ExamResults())),
                                child:Text("Check Results", style: TextStyle(color: Colors.white, fontSize: 15,), textAlign: TextAlign.center,),
                              )
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