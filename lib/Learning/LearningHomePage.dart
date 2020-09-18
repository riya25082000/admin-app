import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'AddModules.dart';
import 'Introduction.dart';
import 'ModuleCode.dart';

class LearningHomePage extends StatefulWidget {
  String currentUserID;
  LearningHomePage({@required this.currentUserID});
  @override
  _LearningHomePageState createState() =>
      _LearningHomePageState(currentUserID: currentUserID);
}

class _LearningHomePageState extends State<LearningHomePage> {
  Widget userbody(List data, double width, double height) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: GridView.count(
          shrinkWrap: true,
          crossAxisCount: 2,
          crossAxisSpacing: 20.0,
          mainAxisSpacing: 20.0,
          physics: ScrollPhysics(),
          children: List.generate(data.length, (index) {
            return GestureDetector(
              onTap: () {},
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0xff48F5D9), Colors.white]),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          width: width * 0.1,
                          height: height * 0.05,
                          child: Center(child: Text(data[index]["moduleno"])),
                          color: Color(0xff17AD94), //
                        ),
                        PopupMenuButton(
                          icon: Icon(Icons.more_horiz),
                          onSelected: (value) {
                            if (value == 1) {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  // return object of type Dialog
                                  return AlertDialog(
                                    title: Text(person == 0
                                        ? "Edit Existing User Module"
                                        : "Edit Existing Advisor Module"),
                                    content: TextFormField(
                                      decoration: InputDecoration(
                                          hintText: "Enter New Module"),
                                      keyboardType: TextInputType.number,
                                      controller: modname,
                                    ),
                                    actions: <Widget>[
                                      FlatButton(
                                        child: Text("Edit"),
                                        onPressed: () {},
                                      ),
                                      FlatButton(
                                        child: new Text("Close"),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                            if (value == 2) {
                              print("delete");
                            }
                          },
                          itemBuilder: (context) => [
                            PopupMenuItem(
                              value: 1,
                              child: Text("Edit"),
                            ),
                            PopupMenuItem(
                              value: 2,
                              child: Text("Delete"),
                            ),
                          ],
                        )
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Divider(
                          color: Colors.black,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Text(
                            data[index]["modulename"],
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          })),
    );
  }

  List learnuser = [];
  int person = 0;
  void changes(int index) {
    setState(() {
      person = index;
    });
  }

  void getQuesUser() async {
    var url = 'http://sanjayagarwal.in/Finance App/learning.php';
    final response = await http.post(
      url,
      body: jsonEncode(<String, String>{
        "UserID": currentUserID,
      }),
    );
    var message = await jsonDecode(response.body);
    print("****************************************");
    print(message);
    print("****************************************");
    setState(() {
      learnuser = message;
    });
  }

  @override
  void initState() {
    print("****************************************");
    print(currentUserID);
    print("****************************************");
    getQuesUser();
    getQuesAdvisor();
    // TODO: implement initState
    super.initState();
  }

  List learnadvisor = [];
  void getQuesAdvisor() async {
    var url = 'http://sanjayagarwal.in/Finance App/learningAdvisor.php';
    final response = await http.post(
      url,
      body: jsonEncode(<String, String>{
        "UserID": currentUserID,
      }),
    );
    var message = await jsonDecode(response.body);
    print("****************************************");
    print(message);
    print("****************************************");
    setState(() {
      learnadvisor = message;
    });
  }

  String currentUserID;
  TextEditingController modname = TextEditingController();
  _LearningHomePageState({@required this.currentUserID});
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    final List<Widget> usertype = [
      userbody(learnuser, width, height),
      userbody(learnadvisor, width, height)
    ];
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
          color: Color(0xff373D3F),
        ),
        backgroundColor: Color(0xff63E2E0),
        centerTitle: true,
        title: Text(
          'LEARNING',
          style: TextStyle(color: Color(0xff373D3F)),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xff63E2E0),
        currentIndex: person,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.black,
        onTap: changes,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text("User"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.perm_contact_calendar),
            title: Text("Advisor"),
          ),
        ],
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
                padding: EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          person == 0 ? "User Modules" : "Advisor Modules",
                          style: TextStyle(
                            fontSize: 20,
                            color: Color(0xff373D3F),
                          ),
                        ),
                        RaisedButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                // return object of type Dialog
                                return AlertDialog(
                                  title: Text(person == 0
                                      ? "New User Module"
                                      : "New Advisor Module"),
                                  content: TextField(
                                    decoration: InputDecoration(
                                        hintText: "Enter New Module"),
                                    keyboardType: TextInputType.number,
                                    controller: modname,
                                  ),
                                  actions: <Widget>[
                                    FlatButton(
                                      child: Text("Add"),
                                      onPressed: () {},
                                    ),
                                    FlatButton(
                                      child: new Text("Close"),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: Text(' + Add '),
                          color: Color(0xff63E2E0),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    usertype[person],
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
