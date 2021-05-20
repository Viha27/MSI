import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:postgrad/Sheduler/pages/detail_page.dart';
import 'package:postgrad/Time_Table/Sunday.dart';
import 'package:postgrad/Time_Table/Time.dart';
import '../Sheduler/widgets/app_bar_title.dart';
import '../Sheduler/widgets/date_box.dart';

class Timetable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Time Table",
          style: TextStyle(color: Colors.brown),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.brown, //change your color here
        ),
      ),
      body: ListView(
        children: <Widget>[
          DateContainer(),
          TagContainer(),
          SchedulesContainer(),
        ],
      ),
    );
  }
}

class DateContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      width: 200,
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(32),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              FlatButton(
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Saturday())),
                child: DateBox(
                  active: true,
                  // date: 17,
                  day: 'SATURDAY',
                  dots: [Colors.yellow, Colors.orange, Colors.green],
                ),
              ),
              FlatButton(
                onPressed: () => Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Sunday())),
                child: DateBox(
                  active: true,
                  // date: 18,
                  day: 'SUNDAY',
                  dots: [Colors.yellow, Colors.orange, Colors.green],
                ),
              ),
            ],
          ),
          Container(
            height: 4,
            width: 100,
            decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(4)),
          ),
        ],
      ),
    );
  }
}
