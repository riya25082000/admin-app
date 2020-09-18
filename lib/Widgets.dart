import 'package:flutter/material.dart';

InputDecoration textfield(String hintText) {
  return InputDecoration(
    fillColor: Colors.white,
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.black),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.black),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Color(0xff18FFFF),
      ),
    ),
    filled: true,
    hintText: hintText,
    hintStyle: TextStyle(color: Color(0xff373D3F)),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: BorderSide(
        width: 0,
        style: BorderStyle.none,
      ),
    ),
  );
}

TextStyle titleBox() {
  return TextStyle(
    fontWeight: FontWeight.bold,
    color: Color(0xff616161),
    fontSize: 30,
    decoration: TextDecoration.none,
  );
}
