import 'package:adminapp/Learning/LearningHomePage.dart';
import 'package:adminapp/NewsLetter/NewsLetter.dart';
import 'package:adminapp/RewardCodes/RewardHomePage.dart';
import 'package:adminapp/Rewards.dart';
import 'package:adminapp/SearchUser.dart';
import 'package:adminapp/createAdmin.dart';
import 'package:adminapp/createAdvisor.dart';
import 'package:flutter/material.dart';
import 'EarnPage/EarnMethods.dart';
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
          ListTile(
            title: Text('Create Advisor'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => CreateAdvisor()));
            },
          ),
          ListTile(
            title: Text('Create Admin'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => CreateAdmin()));
            },
          ),
          ListTile(
            title: Text('Rewards Details'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => ShowRewards()));
            },
          ),
          ListTile(
            title: Text('Rewards and Referrals'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => RewardandRefer(
                            currentUserID: "987654321",
                          )));
            },
          ),
          ListTile(
            title: Text('Earning Methods'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => EarnMethods()));
            },
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
        ],
      ),
    );
  }
}
