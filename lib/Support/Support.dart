import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../erroralert.dart';
import 'showQuestion.dart';

class Support extends StatefulWidget {
  String currentUserID;
  Support({@required this.currentUserID});
  @override
  _SupportState createState() => _SupportState();
}

class _SupportState extends State<Support> {
  List advisorcategory = [], usercategory = [];

  String get currentUserID => null;

  void AdvisorCategoryDelete(var sno) async {
    var url =
        'http://sanjayagarwal.in/Finance App/AdminApp/Support/AdvisorCategoryDelete.php';
    final response = await http.post(
      url,
      body: jsonEncode(<String, String>{'sid': sno}),
    );
    var message = await jsonDecode(response.body);
    if (message["message"] == "Successfully Deleted") {
      getCategoryAdvisor();
    } else {
      print(message["message"]);
    }
  }

  void UserCategoryDelete(var sno) async {
    var url =
        'http://sanjayagarwal.in/Finance App/AdminApp/Support/UserCategoryDelete.php';
    final response = await http.post(
      url,
      body: jsonEncode(<String, String>{'sid': sno}),
    );
    var message = await jsonDecode(response.body);
    if (message["message"] == "Successfully Deleted") {
      getCategoryUser();
    } else {
      print(message["message"]);
    }
  }

  bool _loading;
  void getCategoryUser() async {
    setState(() {
      _loading = true;
    });
    try {
      var url2 =
          'http://sanjayagarwal.in/Finance App/UserApp/Support/SupportCategory.php';
      final response2 = await http.post(
        url2,
        body: jsonEncode(<String, String>{}),
      );
      var message2 = await jsonDecode(response2.body);
      print("****************************************");
      print(message2);
      print("****************************************");
      setState(() {
        usercategory = message2;
        _loading = false;
      });
    }
    on TimeoutException catch (e){
      alerttimeout(context, currentUserID);
    } on Error catch (e) {
      alerterror(context, currentUserID);
    } on SocketException catch (e) {
      alertinternet(context, currentUserID);
    }
  }

  Future UserCategoryInsert() async {
    var url1 =
        'http://sanjayagarwal.in/Finance App/AdminApp/Support/UserLatestCategory.php';
    final response = await http.post(
      url1,
      body: jsonEncode(<String, String>{}),
    );
    var message = jsonDecode(response.body);
    String oldu = message[0]['max(sid)'];
    int bet = int.parse(oldu);
    int latest = bet + 1;
    var url =
        'http://sanjayagarwal.in/Finance App/AdminApp/Support/UserCategoryInsert.php';
    print("****************************************************");
    print("$latest ** ${newcategory.text}");
    print("****************************************************");
    final response1 = await http.post(
      url,
      body: jsonEncode(<String, String>{
        'sid': latest.toString(),
        'sname': newcategory.text,
      }),
    );
    var message1 = jsonDecode(response1.body);
    if (message1["message"] == "Successful Insertion") {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Support()));
    } else {
      print(message1["message"]);
    }
  }

  Future AdvisorCategoryInsert() async {
    var url1 =
        'http://sanjayagarwal.in/Finance App/AdminApp/Support/AdvisorLatestCategory.php';
    final response = await http.post(
      url1,
      body: jsonEncode(<String, String>{}),
    );
    var message = jsonDecode(response.body);
    String oldu = message[0]['max(sid)'];
    int bet = int.parse(oldu);
    int latest = bet + 1;
    var url =
        'http://sanjayagarwal.in/Finance App/AdminApp/Support/AdvisorCategoryInsert.php';
    print("****************************************************");
    print("$latest ** ${newcategory.text}");
    print("****************************************************");
    final response1 = await http.post(
      url,
      body: jsonEncode(<String, String>{
        'sid': latest.toString(),
        'sname': newcategory.text,
      }),
    );
    var message1 = jsonDecode(response1.body);
    if (message1["message"] == "Successful Insertion") {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Support()));
    } else {
      print(message1["message"]);
    }
  }

  void getCategoryAdvisor() async {
    var url2 =
        'http://sanjayagarwal.in/Finance App/AdvisorApp/Support/SupportCategoryAdvisor.php';
    final response2 = await http.post(
      url2,
      body: jsonEncode(<String, String>{}),
    );
    var message2 = await jsonDecode(response2.body);
    print("****************************************");
    print(message2);
    print("****************************************");
    setState(() {
      advisorcategory = message2;
    });
  }

  @override
  void initState() {
    print("****************************************");
    print("****************************************");
    getCategoryUser();
    getCategoryAdvisor();
    // TODO: implement initState
    super.initState();
  }

  Widget supportbuilder(List data) {
    return _loading
        ? Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
              backgroundColor: Color(0xff63E2E0),
            ),
          )
        : ListView.builder(
            physics: ScrollPhysics(),
            shrinkWrap: true,
            itemCount: data.length,
            itemBuilder: (BuildContext cntx, int index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => showQuestion(
                                supp,
                                data[index]["sname"],
                                int.parse(data[index]["sid"]),
                              )));
                },
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.purple,
                        width: 2.0,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(data[index]["sname"]),
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
                                            supp == 0
                                                ? UserCategoryDelete(
                                                    data[index]['sid'])
                                                : AdvisorCategoryDelete(
                                                    data[index]['sid']);
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
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
  }

  TextEditingController searchques = TextEditingController();
  TextEditingController newcategory = TextEditingController();
  int supp = 0;
  void changes(int index) {
    setState(() {
      supp = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List supportwindow = [
      supportbuilder(usercategory),
      supportbuilder(advisorcategory)
    ];
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xff63E2E0),
        currentIndex: supp,
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
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          children: <Widget>[
            Container(
              height: height * 0.2,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/app.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.arrow_back_ios),
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      "How can we help you?",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: width * 0.6,
                          decoration: BoxDecoration(color: Colors.white),
                          child: TextFormField(
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              hintText: "Enter your search here",
                            ),
                            textAlign: TextAlign.center,
                            controller: searchques,
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.search),
                          color: Colors.white,
                          onPressed: () {},
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            RaisedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
// return object of type Dialog
                    return AlertDialog(
                      title: Text("New Help Category"),
                      content: TextField(
                        decoration: InputDecoration(
                            hintText: "Enter New Category Title"),
                        controller: newcategory,
                      ),
                      actions: <Widget>[
                        FlatButton(
                          child: Text("Add"),
                          onPressed: () {
                            supp == 0
                                ? UserCategoryInsert()
                                : AdvisorCategoryInsert();
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
              child: Text(' + Add New Category '),
              color: Color(0xff63E2E0),
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.black),
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            supportwindow[supp],
          ],
        ),
      ),
    );
  }
}
