import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'modifygoals.dart';

Widget yourGoals(BuildContext context, List typeGoal, double height,
    double width, List goal_info) {
  return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: goal_info.length,
      itemBuilder: (BuildContext context, int index) {
        return Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 1.0, // soften the shadow
                        spreadRadius: 0, //extend the shadow
                      ),
                    ]),
                height: height * 0.3,
                width: width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Container(
                                child:
                                    Image.asset(goal_info[index].type.imageUrl),
                                height: 50,
                                width: 50,
                              )
                            ],
                          ),
                          Text(
                            goal_info[index].name,
                          ),
                          PopupMenuButton(
                            icon: Icon(Icons.more_horiz),
                            onSelected: (value) {
                              if (value == 1) {}
                            },
                            itemBuilder: (context) => [
                              PopupMenuItem(
                                value: 1,
                                child: Text("Edit"),
                              ),
                              PopupMenuItem(
                                value: 2,
                                child: Text("Mark as completed"),
                              ),
                              PopupMenuItem(
                                value: 3,
                                child: Text("Delete goal"),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(6.0),
                      child: LinearPercentIndicator(
                        lineHeight: 14.0,
                        percent: (goal_info[index].completion) / 100,
                        backgroundColor: Colors.grey,
                        progressColor: Color(0xff63E2E0),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: (width > 350)
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Text(
                                      "Achieve by: ",
                                      style:
                                          TextStyle(color: Color(0xff373D3F)),
                                    ),
                                    Text(goal_info[index].year,
                                        style: TextStyle(
                                            color: Color(0xff373D3F))),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Text("Target: ",
                                        style: TextStyle(
                                            color: Color(0xff373D3F))),
                                    Text(goal_info[index].value,
                                        style: TextStyle(
                                            color: Color(0xff373D3F))),
                                  ],
                                ),
                              ],
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Text(
                                      "Achieve by: ",
                                      style:
                                          TextStyle(color: Color(0xff373D3F)),
                                    ),
                                    Text(goal_info[index].year,
                                        style: TextStyle(
                                            color: Color(0xff373D3F))),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: <Widget>[
                                    Text("Target: ",
                                        style: TextStyle(
                                            color: Color(0xff373D3F))),
                                    Text(goal_info[index].value,
                                        style: TextStyle(
                                            color: Color(0xff373D3F))),
                                  ],
                                ),
                              ],
                            ),
                    )
                  ],
                ),
              ),
            ),
          ],
        );
      });
}
