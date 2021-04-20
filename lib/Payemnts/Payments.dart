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

class Payments extends StatefulWidget {
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payments> {
  getStringValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String stringValue = prefs.getString('token');
    print(stringValue);
    return stringValue;
  }

  List payments = [];
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    this.fetchModule();
  }

  fetchModule() async {
    setState(() {
      isLoading = true;
    });
    var url = "https://api.mocki.io/v1/945e0ee6";
    var token = await getStringValuesSF();
    var response = await http.post(url);
    //var response=await http.post(url, headers: {
    //'authentication': 'Bearer $token',
    //});
    //print(response.body);
    if (response.statusCode == 200) {
      var items = json.decode(response.body)['results'];
      print(items);
      setState(() {
        payments = items;
        isLoading = false;
      });
      print(response);
    } else {
      print(response.statusCode);
      setState(() {
        payments = [];
        isLoading = false;
        print("Error");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Payments",
            style: TextStyle(color: Colors.brown),
          ),
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(
            color: Colors.brown, //change your color here
          ),
        ),
        //body: getBody(),
        body: getBody());
  }

  Widget getBody() {
    return ListView.builder(
        itemCount: payments.length,
        itemBuilder: (context, index) {
          return getCard(payments[index]);
        });
  }

  Widget getCard(index) {
    return Card(
      child: ListTile(
        title: Column(children: [
          Row(
            children: [
              //Text(name.toString())
            ],
          ),
          Row(
            children: [
              //Text(slipNo.toString())
            ],
          ),
          Row(
            children: [
              //Text(studentID.toString())
            ],
          ),
          Row(
            children: [
              //Text(amount.toString())
            ],
          ),
        ]),
      ),
    );
  }
}
