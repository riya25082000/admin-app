import 'package:flutter/material.dart';

Widget textpart(BuildContext context, String money) {
  return Text(
    "Rs. $money",
    style: TextStyle(color: Color(0xff373D3F), fontSize: 16),
  );
}
