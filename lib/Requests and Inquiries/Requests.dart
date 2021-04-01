import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:postgrad/services/teacher_service.dart';

class Requests extends StatefulWidget {
  @override
  CourseModuleState createState() =>CourseModuleState();
}
class CourseModuleState extends State<Requests>{

  TeacherService _teacherService = new TeacherService();

  @override
  void initState() {
    getAssessments();
    super.initState();
  }

  Future getAssessments() async {
    var assessments = await _teacherService.getAssessments();
    print(assessments.body);
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Requests and Inquiries"),
        backgroundColor: Colors.blue,
      ),
      body: Container(
          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Column(
            children: [
              Padding(padding: EdgeInsets.fromLTRB(10, 10, 10, 10)),
              Text("You can view status of submitted requests.", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),

            ],
          )
      ),
    );
  }

}