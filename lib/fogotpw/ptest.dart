import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:postgrad/Menu/Menu.dart';
import 'package:postgrad/Requests%20and%20Inquiries/Requests1.dart';
import 'package:postgrad/SignUp/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:postgrad/fogotpw/passwordReset.dart';
import 'package:postgrad/fogotpw/passwordtest.dart';
import 'package:postgrad/services/api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sign_button/sign_button.dart';

class SignppIn extends StatefulWidget {
  SignppIn({Key key}) : super(key: key);

  @override
  _SigninppState createState() => _SigninppState();
}

class _SigninppState extends State<SignppIn> {
  TextEditingController _passwordresetController = TextEditingController();
  bool _isLoading = false;
  signIn(String username) async {
    String url = "http://10.0.2.2:3000/api/send-password-reset-email";
    Map body = {"username": username};
    var jsonResponse;
    var res = await http.post(url, body: body);
    if (res.statusCode == 200) {
      jsonResponse = json.decode(res.body);
      print("Response Status ${res.statusCode}");
      print("Response Status ${res.body}");

      if (jsonResponse != null) {
        setState(() {
          _isLoading = false;
        });
        //sharedPreferences.setString("token", jsonResponse['token']);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (BuildContext context) => Menu()),
            (Route<dynamic> route) => false);
      }
    } else {
      setState(() {
        _isLoading = false;
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
                                  onPressed: () {
                                    setState(() {
                                      _isLoading = true;
                                    });
                                    signIn(_passwordresetController.text);
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
