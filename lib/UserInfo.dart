import 'package:adminapp/Income_Expenses/income2.dart';
import 'package:adminapp/MyGoals/NewGoalsHomePage.dart';
import 'package:adminapp/SearchUser.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'Rewards.dart';

class UserInfo extends StatefulWidget {
  String currentUserID;
  UserInfo({@required this.currentUserID});
  @override
  _UserInfoState createState() => _UserInfoState(currentUserID: currentUserID);
}

class _UserInfoState extends State<UserInfo> {
  String currentUserID;
  _UserInfoState({@required this.currentUserID});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Future.delayed(Duration.zero, () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => SearchUserPage()));

            });

          },
          icon: Icon(Icons.arrow_back_ios),
          color: Color(0xff373D3F),
        ),
        backgroundColor: Color(0xff63E2E0),
        centerTitle: true,
        title: Text(
          'USER DATA',
          style: TextStyle(color: Color(0xff373D3F)),
        ),
      ),
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return SingleChildScrollView(
          physics: ScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: viewportConstraints.maxHeight,
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => NewGoalsPage(
                                    currentUserID: "987654321",
                                  )));
                    },
                    child: Container(
                      child: Row(
                        children: [
                          Icon(Icons.golf_course),
                          Text('Goals'),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => income2(
                                    currentUserID: "987654321",
                                  )));
                    },
                    child: Container(
                      child: Row(
                        children: [
                          Icon(Icons.monetization_on),
                          Text('Income & Expenses'),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => RewardandRefer(
                                    currentUserID: "987654321",
                                  )));
                    },
                    child: Container(
                      child: Row(
                        children: [
                          Icon(Icons.card_giftcard),
                          Text('Rewards & Referrals'),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
