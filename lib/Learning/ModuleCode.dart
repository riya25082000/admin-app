import 'package:flutter/material.dart';

Widget modules(double width, double height, Color back, Color front, int x) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(15)),
      boxShadow: [
        BoxShadow(
          color: Colors.grey,
          blurRadius: 1.0, // soften the shadow
          spreadRadius: 0, //extend the shadow
        ),
      ],
    ),
    child: Column(
      children: <Widget>[
        Container(
          height: height * 0.12,
          color: back, //,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: width * 0.1,
                height: height * 0.05,
                child: Center(child: Text("$x")),
                color: front, //
              )
            ],
          ),
        ),
        Container(
          height: height * 0.06,
          child: Padding(
            padding: EdgeInsets.only(top: 15),
            child: Text(
              "Stock Market Basics",
              textAlign: TextAlign.center,
            ),
          ),
        )
      ],
    ),
  );
}
