import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../widgets/app_bar_title.dart';
import '../widgets/date_box.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: AppBarTitle(),
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
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(32),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              DateBox(
                active: true,
                //  date: 17,
                day: 'Mon',
                dots: [Colors.yellow, Colors.orange, Colors.green],
              ),
              DateBox(
                // date: 18,
                day: 'Tue',
                dots: [Colors.yellow, Colors.orange, Colors.green],
              ),
              DateBox(
                // date: 19,
                day: 'Wed',
                dots: [Colors.orange],
              ),
              DateBox(
                // date: 20,
                day: 'Thu',
                dots: [Colors.orange, Colors.green],
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

class TagContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      child: Row(
        children: <Widget>[
          Tag(tag: 'Lectures', color: Colors.green, textColor: Colors.white),
          Tag(tag: 'Lab Sessions', color: Colors.pink, textColor: Colors.white),
        ],
      ),
    );
  }
}

class Tag extends StatelessWidget {
  final String tag;
  final Color color;
  final Color textColor;

  Tag({
    @required this.tag,
    this.color = Colors.grey,
    this.textColor = Colors.black87,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 16,
      ),
      margin: EdgeInsets.only(right: 8),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        tag,
        style: TextStyle(color: textColor),
      ),
    );
  }
}

class SchedulesContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Postgraduate Devision Faculty of IT',
                  style: TextStyle(fontSize: 20, color: Colors.blueAccent),
                ),
                Text(
                  '',
                  style: TextStyle(
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ),
          Schedules(),
        ],
      ),
    );
  }
}

class Schedules extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.4),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
          border: Border.all(color: Colors.blueAccent, width: 10),
          borderRadius: BorderRadius.circular(10)),
      child: Image.asset(
        'assets/images/fac.jpg',
        width: 300,
      ),
    );
  }
}

class Schedule extends StatelessWidget {
  final String name;
  final String time;
  final Color dotColor;
  final bool active;

  Schedule({this.name, this.time, this.dotColor, this.active});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      margin: active ? EdgeInsets.only(right: 16) : null,
      decoration: BoxDecoration(
        color: active ? Colors.deepPurple : Colors.transparent,
        borderRadius: active
            ? BorderRadius.horizontal(
                right: Radius.circular(16),
              )
            : null,
      ),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                name,
                style: Theme.of(context).textTheme.title.copyWith(
                      color: active ? Colors.white : null,
                    ),
              ),
              active
                  ? Icon(
                      Icons.edit,
                      size: 16,
                      color: active ? Colors.white : null,
                    )
                  : Container()
            ],
          ),
          SizedBox(height: 8),
          Row(
            children: <Widget>[
              Container(
                height: 10,
                width: 10,
                decoration: BoxDecoration(
                  color: dotColor,
                  shape: BoxShape.circle,
                ),
              ),
              Text(
                ' $time',
                style: Theme.of(context).textTheme.subtitle.copyWith(
                      color: active ? Colors.white : null,
                    ),
              )
            ],
          )
        ],
      ),
    );
  }
}
