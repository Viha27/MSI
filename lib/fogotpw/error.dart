import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:postgrad/fogotpw/message.dart';

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

class Errorapp extends StatefulWidget {
  Errorapp({Key key}) : super(key: key);

  @override
  _MyAppState createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<Errorapp> {
  final TextEditingController _controller = TextEditingController();
  Future<Message> _futureAlbum;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Create Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Create Data Example'),
        ),
        body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8.0),
          child: (_futureAlbum == null) ? buildColumn() : buildFutureBuilder(),
        ),
      ),
    );
  }

  Column buildColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        TextField(
          controller: _controller,
          decoration: InputDecoration(hintText: 'Enter Title'),
        ),
        ElevatedButton(
          onPressed: () {
            setState(() {
              _futureAlbum = createAlbum(_controller.text);
            });
          },
          child: Text('Create Data'),
        ),
      ],
    );
  }

  FutureBuilder<Message> buildFutureBuilder() {
    return FutureBuilder<Message>(
      future: _futureAlbum,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text(snapshot.data.message);
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        return CircularProgressIndicator();
      },
    );
  }
}
