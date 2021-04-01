import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class ApiService {

  ApiService();

  Future <http.Response> login(String username, String password  ) async {
    String _url = 'http://localhost:3000/api/login';

    var body = {
      "username": username,
      "password" : password
    };
    //if(res.statusCode == 200) return res.body;
    //return null;
    return http.post(_url, body: body);
  }
  Future <http.Response> getModules(String username, String password  ) async {
    String _url = 'http://localhost:3000/api/login';

    var body = {
      "username": username,
      "password" : password
    };
    //if(res.statusCode == 200) return res.body;
    //return null;
    return http.post(_url, body: body);
  }


}