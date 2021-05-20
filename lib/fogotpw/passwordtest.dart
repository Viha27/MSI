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

import 'message.dart';

class SignpIn extends StatefulWidget {
  SignpIn({Key key}) : super(key: key);

  @override
  _SigninpState createState() => _SigninpState();
}

class _SigninpState extends State<SignpIn> {
  Future<Message> _futureAlbum;
  TextEditingController _controller = TextEditingController();
  bool _isLoading = false;
  Future<Message> createAlbum(String title) async {
    String url = "http://10.0.2.2:3000/api/send-password-reset-email";
    Map body = {"username": title};

    var res = await http.post(url, body: body);

    if (res.statusCode == 200) {
      print("Response Status ${res.statusCode}");
      print("Response Status ${res.body}");
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      return Message.fromJson(jsonDecode(res.body));
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      print("Response Status ${res.statusCode}");
      print("Response Status ${res.body}");

      return Message.fromJson(jsonDecode(res.body));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Fogot Password?",
            style: TextStyle(color: Colors.brown),
          ),
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(
            color: Colors.brown, //change your color here
          ),
        ),
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
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.pinkAccent,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            child: Icon(
                              Icons.quick_contacts_mail_rounded,
                              size: 49,
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
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
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
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 18),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          '       USERNAME :',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.brown),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 4),
                                    Container(
                                      width: 300,
                                      decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.4),
                                            spreadRadius: 5,
                                            blurRadius: 7,
                                            offset: Offset(0,
                                                3), // changes position of shadow
                                          ),
                                        ],
                                      ),
                                      child: TextField(
                                        controller: _controller,
                                        decoration: InputDecoration(
                                            hintText: "EX : 184078M",
                                            border: new OutlineInputBorder(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                const Radius.circular(10.0),
                                              ),
                                            ),
                                            filled: true,
                                            hintStyle: new TextStyle(
                                                color: Colors.grey[800]),
                                            fillColor: Colors.white70),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.all(8.0),
                                  child: (_futureAlbum == null)
                                      ? null
                                      : buildFutureBuilder(),
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 250,
                                    ),
                                    RaisedButton(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                      ),
                                      color: Colors.blue,
                                      onPressed: () {
                                        setState(() {
                                          _futureAlbum =
                                              createAlbum(_controller.text);
                                        });
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

  FutureBuilder<Message> buildFutureBuilder() {
    return FutureBuilder<Message>(
      future: _futureAlbum,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text(
            snapshot.data.message,
            style:
                TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold),
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        return CircularProgressIndicator();
      },
    );
  }
}
