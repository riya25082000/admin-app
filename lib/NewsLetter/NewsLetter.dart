import 'dart:async';
import 'dart:io';
import '../erroralert.dart';

import 'package:flutter/material.dart';

import 'ShowLetter.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class NewsLetter extends StatefulWidget {
  @override
  _NewsLetterState createState() => _NewsLetterState();
}

class _NewsLetterState extends State<NewsLetter> {
  int x;
  TextEditingController newletter = TextEditingController();
  TextEditingController newurl = TextEditingController();
  TextEditingController existnews = TextEditingController();
  TextEditingController existurl = TextEditingController();

  String get currentUserID => null;

  Future UserNewsInsert() async {
    var url =
        'http://sanjayagarwal.in/Finance App/AdminApp/NewsLetter/UserNewsInsert.php';
    print("****************************************************");
    print("${newletter.text} ** ${newurl.text}");
    print("****************************************************");
    final response1 = await http.post(
      url,
      body: jsonEncode(
          <String, String>{'ntitle': newletter.text, 'nurl': newurl.text}),
    );
    var message1 = jsonDecode(response1.body);
    if (message1 == "Successful Insertion") {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => NewsLetter()));
    } else {
      print(message1);
    }
  }

  void UserNewsDelete(var nno) async {
    var url =
        'http://sanjayagarwal.in/Finance App/AdminApp/NewsLetter/UserNewsDelete.php';
    final response = await http.post(
      url,
      body: jsonEncode(<String, String>{'nid': nno}),
    );
    var message = await jsonDecode(response.body);
    if (message == "Successfully Deleted") {
      getLetterUser();
    } else {
      print(message);
    }
  }

  List letteruse = [];
  bool _loading;
  void getLetterUser() async {
    setState(() {
      _loading = true;
    });
    var url =
        'http://sanjayagarwal.in/Finance App/UserApp/NewsLetter/NewsLetterDetails.php';
    try {
      final response = await http.post(
        url,
        body: jsonEncode(<String, String>{}),
      );
      var message = await jsonDecode(response.body);
      print("****************************************");
      print(message);
      print("****************************************");
      setState(() {
        letteruse = message;
        _loading = false;
      });
    } on TimeoutException catch (e) {
      alerttimeout(context, currentUserID);
    } on Error catch (e) {
      alerterror(context, currentUserID);
    } on SocketException catch (e) {
      alertinternet(context, currentUserID);
    }
  }

  Future AdvisorNewsInsert() async {
    var url =
        'http://sanjayagarwal.in/Finance App/AdminApp/NewsLetter/AdvisorNewsInsert.php';
    print("****************************************************");
    print("${newletter.text} ** ${newurl.text}");
    print("****************************************************");
    final response1 = await http.post(
      url,
      body: jsonEncode(
          <String, String>{'ntitle': newletter.text, 'nurl': newurl.text}),
    );
    var message1 = jsonDecode(response1.body);
    if (message1 == "Successful Insertion") {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => NewsLetter()));
    } else {
      print(message1);
    }
  }

  void AdvisorNewsDelete(var nno) async {
    var url =
        'http://sanjayagarwal.in/Finance App/AdminApp/NewsLetter/AdvisorNewsDelete.php';
    final response = await http.post(
      url,
      body: jsonEncode(<String, String>{'nid': nno}),
    );
    var message = await jsonDecode(response.body);
    if (message == "Successfully Deleted") {
      getLetterAdvisor();
    } else {
      print(message);
    }
  }

  List letteradvi = [];
  void getLetterAdvisor() async {
    setState(() {
      _loading = true;
    });
    try {
      var url =
          'http://sanjayagarwal.in/Finance App/AdvisorApp/NewsLetter/NewsLetterDetailsAdvisor.php';
      final response = await http.post(
        url,
        body: jsonEncode(<String, String>{}),
      );
      var message = await jsonDecode(response.body);
      print("****************************************");
      print(message);
      print("****************************************");
      setState(() {
        letteradvi = message;
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
  void initState() {
    print("****************************************");
    print("****************************************");
    getLetterUser();
    getLetterAdvisor();
    // TODO: implement initState
    super.initState();
  }

  int c = 0;
  void changes(int index) {
    setState(() {
      c = index;
    });
  }

  Widget letterbody(List data) {
    return _loading
        ? Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
              backgroundColor: Color(0xff63E2E0),
            ),
          )
        : Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.count(
              shrinkWrap: true,
              crossAxisCount: 2,
              crossAxisSpacing: 20.0,
              mainAxisSpacing: 20.0,
              physics: ScrollPhysics(),
              children: List.generate(data.length, (index) {
                return GestureDetector(
                  onTap: () {
                    print(data[index]['nurl']);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => ShowLetter(
                                  int.parse(data[index]['nid']),
                                  data[index]['ntitle'],
                                  data[index]['nurl'],
                                )));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Color(0xff48F5D9), Colors.white]),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Align(
                          alignment: Alignment.topRight,
                          child: IconButton(
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
                                            c == 0
                                                ? UserNewsDelete(
                                                    data[index]['nid'])
                                                : AdvisorNewsDelete(
                                                    data[index]['nid']);
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
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Text(
                            data[index]['ntitle'],
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    List newsletterbody = [letterbody(letteruse), letterbody(letteradvi)];
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
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
          'NEWS LETTER',
          style: TextStyle(color: Color(0xff373D3F)),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xff63E2E0),
        currentIndex: c,
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
      body: _loading
          ? Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
                backgroundColor: Color(0xff63E2E0),
              ),
            )
          : LayoutBuilder(
              builder:
                  (BuildContext context, BoxConstraints viewportConstraints) {
                return SingleChildScrollView(
                  physics: ScrollPhysics(),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: viewportConstraints.maxHeight,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                c == 0
                                    ? 'User News Letter'
                                    : 'Advisor News Letter',
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
                                        title: Text("New News Letter"),
                                        content: Container(
                                          height: height * 0.15,
                                          child: Column(
                                            children: <Widget>[
                                              TextField(
                                                decoration: InputDecoration(
                                                    hintText:
                                                        "Enter News Letter Title"),
                                                controller: newletter,
                                              ),
                                              TextField(
                                                decoration: InputDecoration(
                                                    hintText:
                                                        "Enter URL of News Letter"),
                                                controller: newurl,
                                              ),
                                            ],
                                          ),
                                        ),
                                        actions: <Widget>[
                                          FlatButton(
                                            child: Text("Add"),
                                            onPressed: () {
                                              c == 0
                                                  ? UserNewsInsert()
                                                  : AdvisorNewsInsert();
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
                          newsletterbody[c],
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
