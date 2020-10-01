import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../erroralert.dart';
import 'Introduction.dart';
import 'ModuleCode.dart';

class LearningHomePage extends StatefulWidget {
  String currentUserID;
  LearningHomePage({@required this.currentUserID});
  @override
  _LearningHomePageState createState() => _LearningHomePageState();
}

class _LearningHomePageState extends State<LearningHomePage> {
  int x;

  String get currentUserID => null;
  Future UserModuleUpdate() async {
    var url =
        'http://sanjayagarwal.in/Finance App/AdminApp/Learning/UserModuleUpdate.php';
    final response1 = await http.post(
      url,
      body: jsonEncode(<String, String>{
        'moduleno': learnuser[x]['moduleno'],
        'modulename': editmodname.text,
      }),
    );
    var message1 = jsonDecode(response1.body);
    if (message1 == "Successful Updation") {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LearningHomePage()));
    } else {
      print(message1);
    }
  }

  Future AdvisorModuleUpdate() async {
    var url =
        'http://sanjayagarwal.in/Finance App/AdminApp/Learning/AdvisorModuleUpdate.php';
    final response1 = await http.post(
      url,
      body: jsonEncode(<String, String>{
        'moduleno': learnadvisor[x]['moduleno'],
        'modulename': editmodname.text,
      }),
    );
    var message1 = jsonDecode(response1.body);
    if (message1 == "Successful Updation") {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LearningHomePage()));
    } else {
      print(message1);
    }
  }

  void UserModuleDelete(var mno) async {
    var url =
        'http://sanjayagarwal.in/Finance App/AdminApp/Learning/UserModuleDelete.php';
    final response = await http.post(
      url,
      body: jsonEncode(<String, String>{'moduleno': mno}),
    );
    var message = await jsonDecode(response.body);
    if (message == "Successfully Deleted") {
      getQuesUser();
    } else {
      print(message);
    }
  }

  void AdvisorModuleDelete(var mno) async {
    var url =
        'http://sanjayagarwal.in/Finance App/AdminApp/Learning/AdvisorModuleDelete.php';
    final response = await http.post(
      url,
      body: jsonEncode(<String, String>{'moduleno': mno}),
    );
    var message = await jsonDecode(response.body);
    if (message == "Successfully Deleted") {
      getQuesAdvisor();
    } else {
      print(message);
    }
  }

  Future UserModuleInsert() async {
    var url1 =
        'http://sanjayagarwal.in/Finance App/AdminApp/Learning/getUser.php';
    final response = await http.post(
      url1,
      body: jsonEncode(<String, String>{}),
    );
    var message = jsonDecode(response.body);
    String oldu = message[0]['max(moduleno)'];
    int bet = int.parse(oldu);
    int latest = bet + 1;
    var url =
        'http://sanjayagarwal.in/Finance App/AdminApp/Learning/UserModuleInsert.php';
    print("****************************************************");
    print("$latest ** ${umod.text}");
    print("****************************************************");
    final response1 = await http.post(
      url,
      body: jsonEncode(<String, String>{
        'moduleno': latest.toString(),
        'modulename': umod.text,
      }),
    );
    var message1 = jsonDecode(response1.body);
    if (message1 == "Successful Insertion") {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LearningHomePage()));
    } else {
      print(message1);
    }
  }

  Future AdvisorModuleInsert() async {
    var url1 =
        'http://sanjayagarwal.in/Finance App/AdminApp/Learning/getAdvisor.php';
    final response = await http.post(
      url1,
      body: jsonEncode(<String, String>{}),
    );
    var message = jsonDecode(response.body);
    String oldu = message[0]['max(moduleno)'];
    int bet = int.parse(oldu);
    int latest = bet + 1;
    var url =
        'http://sanjayagarwal.in/Finance App/AdminApp/Learning/AdvisorModuleInsert.php';
    print("****************************************************");
    print("$latest ** ${amod.text}");
    print("****************************************************");
    final response1 = await http.post(
      url,
      body: jsonEncode(<String, String>{
        'moduleno': latest.toString(),
        'modulename': amod.text,
      }),
    );
    var message1 = jsonDecode(response1.body);
    if (message1 == "Successful Insertion") {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LearningHomePage()));
    } else {
      print(message1);
    }
  }

  TextEditingController umod = TextEditingController();
  TextEditingController amod = TextEditingController();
  TextEditingController editmodname = TextEditingController();
  Widget userbody(List data, double width, double height) {
    return _loading
        ? Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
              backgroundColor: Color(0xff63E2E0),
            ),
          )
        : Padding(
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
                                child:
                                    Center(child: Text((index + 1).toString())),
                                color: Color(0xff17AD94), //
                              ),
                              Column(
                                children: <Widget>[
                                  IconButton(
                                    icon: Icon(Icons.delete),
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text('Warning'),
                                              content: Text(
                                                  "Are you sure you want to delete this module ?"),
                                              actions: <Widget>[
                                                FlatButton(
                                                  child: Text("Yes"),
                                                  onPressed: () {
                                                    person == 0
                                                        ? UserModuleDelete(
                                                            learnuser[index]
                                                                ['moduleno'])
                                                        : AdvisorModuleDelete(
                                                            learnadvisor[index]
                                                                ['moduleno']);
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                                FlatButton(
                                                  child: Text("Cancel"),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                )
                                              ],
                                            );
                                          });
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.edit),
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          // return object of type Dialog
                                          return AlertDialog(
                                            title: Text(person == 0
                                                ? "Edit Existing User Module"
                                                : "Edit Existing Advisor Module"),
                                            content: TextFormField(
                                              keyboardType: TextInputType.text,
                                              decoration: InputDecoration(
                                                  hintText: "Enter New Module"),
                                              controller: editmodname,
                                            ),
                                            actions: <Widget>[
                                              FlatButton(
                                                child: Text("Edit"),
                                                onPressed: () {
                                                  x = index;
                                                  person == 0
                                                      ? UserModuleUpdate()
                                                      : AdvisorModuleUpdate();
                                                },
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

  bool _loading;
  void getQuesUser() async {
    setState(() {
      _loading = true;
    });
    var url =
        'http://sanjayagarwal.in/Finance App/AdminApp/Learning/UserLearning.php';
    final response = await http.post(
      url,
      body: jsonEncode(<String, String>{}),
    );
    var message = await jsonDecode(response.body);
    print("****************************************");
    print(message);
    print("****************************************");
    setState(() {
      learnuser = message;
      _loading = false;
    });
  }

  @override
  void initState() {
    print("****************************************");
    print("****************************************");
    getQuesUser();
    getQuesAdvisor();
    // TODO: implement initState
    super.initState();
  }

  List learnadvisor = [];
  void getQuesAdvisor() async {
    var url =
        'http://sanjayagarwal.in/Finance App/AdminApp/Learning/AdvisorLearning.php';
    try {
      final response = await http
          .post(
            url,
            body: jsonEncode(<String, String>{}),
          )
          .timeout(Duration(seconds: 30));
      var message = await jsonDecode(response.body);
      print("****************************************");
      print(message);
      print("****************************************");
      setState(() {
        learnadvisor = message;
      });
    } on TimeoutException catch (e) {
      alerttimeout(context, currentUserID);
    } on Error catch (e) {
      alerterror(context, currentUserID);
    } on SocketException catch (e) {
      alertinternet(context, currentUserID);
    }
  }

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
                                    controller: person == 0 ? umod : amod,
                                  ),
                                  actions: <Widget>[
                                    FlatButton(
                                      child: Text("Add"),
                                      onPressed: () {
                                        person == 0
                                            ? UserModuleInsert()
                                            : AdvisorModuleInsert();
                                      },
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
