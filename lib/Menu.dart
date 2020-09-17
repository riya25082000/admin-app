import 'package:flutter/material.dart';

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

            },
          ),
          ListTile(
            title: Text('Learning'),
            onTap: () {

            },
          ),
          ListTile(
            title: Text('Search User'),
            onTap: () {
            },
          ),
          ListTile(
            title: Text('Search Advisor'),
            onTap: () {
            },
          ),
          ListTile(
            title: Text('NewsLetter'),
            onTap: () {
            },
          ),
        ],
      ),
    );
  }
}
