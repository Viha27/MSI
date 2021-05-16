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
import 'package:postgrad/fogotpw/ptest.dart';
import 'package:postgrad/services/api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sign_button/sign_button.dart';

class SignIn extends StatefulWidget {
  SignIn({Key key}) : super(key: key);

  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<SignIn> {
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  signIn(String username, String password) async {
    String url = "http://10.0.2.2:3000/api/login";
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map body = {"username": username, "password": password};
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
        sharedPreferences.setString("username", jsonResponse['username']);
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
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.fromLTRB(20, 100, 20, 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/UoM_logo.png',
                width: 100,
                height: 200,
              ),
              Text(
                "Management Information  ",
                style: TextStyle(fontSize: 25),
              ),
              Text(
                "System",
                style: TextStyle(fontSize: 25),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20)),
                child: TextField(
                  controller: _userNameController,
                  decoration: InputDecoration(
                      hintText: "Username",
                      border: new OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(10.0),
                        ),
                      ),
                      filled: true,
                      hintStyle: new TextStyle(color: Colors.grey[800]),
                      fillColor: Colors.white70),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20)),
                child: TextField(
                  obscureText: true,
                  controller: _passwordController,
                  decoration: InputDecoration(
                      hintText: "Password",
                      border: new OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(10.0),
                        ),
                      ),
                      filled: true,
                      hintStyle: new TextStyle(color: Colors.grey[800]),
                      fillColor: Colors.white70),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              FlatButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignpIn()));
                  //TODO FORGOT PASSWORD SCREEN GOES HERE
                },
                child: Text(
                  'Forgot Password ?',
                  style: TextStyle(color: Colors.blue, fontSize: 15),
                ),
              ),
              Container(
                height: 50,
                width: 200,
                child: RaisedButton(
                  hoverColor: Colors.blue,
                  color: Colors.blue,
                  child: Text(
                    "Sign In",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  onPressed: _userNameController.text == "" ||
                          _passwordController.text == ""
                      ? null
                      : () {
                          setState(() {
                            _isLoading = true;
                          });
                          signIn(_userNameController.text,
                              _passwordController.text);
                        },
                ),
              ),
              Padding(padding: EdgeInsets.all(20)),
            ],
          ),
        ),
      ),
    );
  }
}
