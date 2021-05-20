import 'package:flutter/material.dart';

class DateBox extends StatelessWidget {
  final String day;
  final bool active;
  final List<Color> dots;

  DateBox({
    @required this.day,
    this.active = false,
    this.dots = const <Color>[],
  });

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = active ? Colors.purple : Colors.grey[300];
    Color color =
        active ? Colors.white : Theme.of(context).textTheme.display1.color;

    return Container(
      width: 120,
      height: 110,
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.only(left: 8),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          Text(
            day,
            style: Theme.of(context).textTheme.title.copyWith(
                  color: color,
                ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: dots.map((color) {
              return Container(
                height: 8,
                width: 8,
                margin: EdgeInsets.symmetric(horizontal: 2),
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
