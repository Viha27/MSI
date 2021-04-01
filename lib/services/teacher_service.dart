import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:postgrad/SignUp/SignIn.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TeacherService {
  getAssessments () async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    //Return String
    String token = sharedPreferences.getString('token');
    print(token);
    return token;
    //return http.post("http://localhost:3000/teacher/get-assignments");
  }
}