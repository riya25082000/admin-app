import 'package:adminapp/Learning/LearningHomePage.dart';
import 'package:adminapp/NewsLetter/NewsLetter.dart';
import 'package:adminapp/SearchUser.dart';
import 'package:flutter/material.dart';
import 'SearchAdvisor.dart';
import 'Support/Support.dart';

class AdminMenu extends StatefulWidget {
  @override
  _AdminMenuState createState() => _AdminMenuState();
}

class _AdminMenuState extends State<AdminMenu> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        children: <Widget>[
          Container(
            height: 80,
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xff63E2E0),
              ),
              child: Text(
                'ADMIN',
                style: TextStyle(
                  color: Color(0xff373D3F),
                  fontSize: 20,
                ),
              ),
            ),
          ),
          ListTile(
            title: Text('Support'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => Support()));
            },
          ),
          ListTile(
            title: Text('Learning'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => LearningHomePage()));
            },
          ),
          ListTile(
            title: Text('Search User'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => SearchUserPage()));
            },
          ),
          ListTile(
            title: Text('Search Advisor'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => SearchAdvisorPage()));
            },
          ),
          ListTile(
            title: Text('News Letter'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => NewsLetter()));
            },
          ),
        ],
      ),
    );
  }
}
