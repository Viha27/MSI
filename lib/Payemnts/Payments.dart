import 'package:date_time_format/date_time_format.dart';
import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:postgrad/Payemnts/model.dart';
import 'package:postgrad/Requests%20and%20Inquiries/Model.dart';

import 'package:shared_preferences/shared_preferences.dart';

class Pays extends StatefulWidget {
  const Pays({Key key}) : super(key: key);

  _ReqsState createState() => _ReqsState();
}

class _ReqsState extends State<Pays> {
  getStringValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String stringValue = prefs.getString('token');
    print(stringValue);
    return stringValue;
  }

  Pay names;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
  }

  Future<Pay> fetchModule() async {
    // setState(() {
    //   isLoading = true;
    // });
    var url =
        "http://ec2-13-233-98-120.ap-south-1.compute.amazonaws.com:3000/api/get-payments";
    var token = await getStringValuesSF();
    final response = await http.post(url, headers: {
      'authentication': 'Bearer $token',
    });
    //print(response.body);
    if (response.statusCode == 200) {
      final jsonresponse = json.decode(response.body);
      Pay items = payFromJson(response.body);
      print('hh');

      return items;
    } else {
      return null;
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
        body: FutureBuilder<Pay>(
          future: fetchModule(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              // Show Loading indicator
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                ],
              );
            } else {
              // Show data if exist
              return Column(
                children: snapshot.data.payments
                    .map((req) => Expanded(
                          child: SingleChildScrollView(
                            child: Container(
                              padding: EdgeInsets.all(16),
                              margin: EdgeInsets.fromLTRB(1, 3, 16, 20),
                              decoration: BoxDecoration(
                                  color: Colors.deepPurple,
                                  borderRadius: BorderRadius.horizontal(
                                    right: Radius.circular(16),
                                  )),
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        height: 10,
                                        width: 10,
                                        decoration: BoxDecoration(
                                          color: Colors.green,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Container(
                                        child: Expanded(
                                          child: Text(
                                            'Id :' + req.id.toString(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .title
                                                .copyWith(
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        height: 10,
                                        width: 10,
                                        decoration: BoxDecoration(
                                          color: Colors.green,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Container(
                                        child: Expanded(
                                          child: Text(
                                            ' Slip No :' +
                                                req.slipNo.toString(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .title
                                                .copyWith(
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        height: 10,
                                        width: 10,
                                        decoration: BoxDecoration(
                                          color: Colors.green,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Container(
                                        child: Expanded(
                                          child: Text(
                                            ' Amount : Rs' +
                                                req.amount.toString(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .title
                                                .copyWith(
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        height: 10,
                                        width: 10,
                                        decoration: BoxDecoration(
                                          color: Colors.green,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Container(
                                        child: Expanded(
                                          child: Text(
                                            ' Bank : ' + req.bank,
                                            style: Theme.of(context)
                                                .textTheme
                                                .title
                                                .copyWith(
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        height: 10,
                                        width: 10,
                                        decoration: BoxDecoration(
                                          color: Colors.green,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Container(
                                        child: Expanded(
                                          child: Text(
                                            'Payment Date :' +
                                                (DateTimeFormat.format(
                                                    req.paymentDate,
                                                    format: AmericanDateFormats
                                                        .dayOfWeek)),
                                            style: Theme.of(context)
                                                .textTheme
                                                .title
                                                .copyWith(
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        height: 10,
                                        width: 10,
                                        decoration: BoxDecoration(
                                          color: Colors.green,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Container(
                                        child: Expanded(
                                          child: Text(
                                            ' External Notes :' +
                                                req.externalNote,
                                            style: Theme.of(context)
                                                .textTheme
                                                .title
                                                .copyWith(
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 8,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ))
                    .toList(),
              );
            }
          },
        ));
  }
}

/* import 'package:date_time_format/date_time_format.dart';
import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:postgrad/Payemnts/model.dart';
import 'package:postgrad/Requests%20and%20Inquiries/Model.dart';

import 'package:shared_preferences/shared_preferences.dart';

class Pays extends StatefulWidget {
  const Pays({Key key}) : super(key: key);

  _ReqsState createState() => _ReqsState();
}

class _ReqsState extends State<Pays> {
  getStringValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String stringValue = prefs.getString('token');
    print(stringValue);
    return stringValue;
  }

  Pay names;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
  }

  Future<Pay> fetchModule() async {
    // setState(() {
    //   isLoading = true;
    // });
    var url =
        "http://ec2-13-233-98-120.ap-south-1.compute.amazonaws.com:3000/api/get-payments";
    var token = await getStringValuesSF();
    final response = await http.post(url, headers: {
      'authentication': 'Bearer $token',
    });
    //print(response.body);
    if (response.statusCode == 200) {
      final jsonresponse = json.decode(response.body);
      Pay items = payFromJson(response.body);
      print('${items.payments}');

      return items;
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Requests",
            style: TextStyle(color: Colors.brown),
          ),
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(
            color: Colors.brown, //change your color here
          ),
        ),
        //body: getBody(),
        body: FutureBuilder<Pay>(
          future: fetchModule(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              // Show Loading indicator
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                ],
              );
            } else {
              // Show data if exist
              return Column(
                children: snapshot.data.payments
                    .map((req) => SingleChildScrollView(
                        child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            shadowColor: Colors.brown,
                            margin: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 5.0),
                            child: ListTile(
                                title: Column(children: [
                              Row(
                                children: [
                                  Container(
                                    width: 55,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: Colors.purple,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    ),
                                    child: Icon(
                                      Icons.request_page_outlined,
                                      size: 40,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  SizedBox(
                                    width: 250,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        /* Text(
                                          " Id : " + req.id.toString(),
                                          style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        ),
                                        SizedBox(
                                          height: 3,
                                        ),
                                        Text(
                                          ' Slip No : ' + req.slipNo.toString(),
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 17,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 3,
                                        ),
                                        Text(
                                          ' Amount : Rs ' +
                                              req.amount.toString(),
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          height: 3,
                                        ),
                                        Text(
                                          ' Payment Date : ' +
                                              (DateTimeFormat.format(
                                                  req.paymentDate,
                                                  format: AmericanDateFormats
                                                      .dayOfWeek)),
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          height: 3,
                                        ), */
                                        Text(
                                          ' Description : ' + req.description,
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              /* Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                color: Colors.blue,
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Reqs(
                              index: reqId,
                            ))),
                child: Text(
                  "Requests",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                color: Colors.blue,
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Review(
                              index: reqId,
                            ))),
                child: Text(
                  "Reasons",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                color: Colors.blue,
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RevBy(index: reqId))),
                child: Text(
                  "Reviewed By",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ) */
                            ])))))
                    .toList(),
              );
            }
          },
        ));
  }
}
 */
