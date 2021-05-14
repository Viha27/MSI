import 'package:flutter/material.dart';
import 'package:postgrad/Exam_Results/ExamResults.dart';
import 'package:postgrad/SignUp/SignIn.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Fogotpw extends StatefulWidget {
  @override
  _FogotpwState createState() => _FogotpwState();
}

class _FogotpwState extends State<Fogotpw> {
  TextEditingController _passwordresetController = new TextEditingController();
  bool _isLoading;
  fogotPassword(String username) async {
    String url = "http://10.0.2.2:3000/api/send-password-reset-email";
    Map body = {"username": username};
    var jsonResponse;
    var res = await http.post(url, body: body);
    if (res.statusCode == 200) {
      jsonResponse = json.decode(res.body);

      if (jsonResponse != null) {
        setState(() {
          print('Error');
        });

        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (BuildContext context) => SignIn()),
            (Route<dynamic> route) => false);
      }
    } else {
      setState(() {
        return CircularProgressIndicator();
      });

      print("Response Status: ${res.body}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            shadowColor: Colors.brown,
            margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
            child: ListTile(
              title: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 60,
                        height: 55,
                        decoration: BoxDecoration(
                          color: Colors.pinkAccent,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Icon(
                          Icons.quick_contacts_mail_rounded,
                          size: 50,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        width: 250,
                        child: Column(
                          children: [
                            Text(
                              'Forgot Password',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
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
                            Text(
                              'We will send you an email to your recovery email with instructions to reset your password. Please enter your username below.',
                              textAlign: TextAlign.left,
                              style: TextStyle(color: Colors.black),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20)),
                              child: TextField(
                                controller: _passwordresetController,
                                decoration: InputDecoration(
                                    hintText: "Username",
                                    border: new OutlineInputBorder(
                                      borderRadius: const BorderRadius.all(
                                        const Radius.circular(10.0),
                                      ),
                                    ),
                                    filled: true,
                                    hintStyle:
                                        new TextStyle(color: Colors.grey[800]),
                                    fillColor: Colors.white70),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 250,
                                ),
                                RaisedButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  color: Colors.blue,
                                  onPressed: () => _passwordresetController
                                              .text ==
                                          ""
                                      ? null
                                      : () {
                                          setState(() {
                                            _isLoading = true;
                                          });
                                          fogotPassword(
                                              _passwordresetController.text);
                                        },
                                  child: Text(
                                    "Send",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
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
          ),
        ],
      ),
    ));
  }
}
