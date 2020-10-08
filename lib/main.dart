import 'package:adminapp/HomePage.dart';
import 'package:adminapp/SearchTemp.dart';
import 'package:adminapp/SearchUser.dart';
import 'package:adminapp/Learning/LearningHomePage.dart';
import 'package:adminapp/UserInfo.dart';
import 'package:flutter/material.dart';
import 'SearchAdvisor.dart';
import 'Signin.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginPage(),
    );
  }
}
