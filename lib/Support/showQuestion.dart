import 'package:adminapp/Support/Support.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class showQuestion extends StatefulWidget {
  String cate;
  int suid;
  int x;
  showQuestion(
    this.x,
    this.cate,
    this.suid,
  );
  @override
  _showQuestionState createState() => _showQuestionState();
}

class _showQuestionState extends State<showQuestion> {
  List quesuser = [], quesadvisor = [];
  void AdvisorQuestionDelete(var qno) async {
    var url =
        'http://sanjayagarwal.in/Finance App/AdminApp/Support/AdvisorQuestionDelete.php';
    final response = await http.post(
      url,
      body: jsonEncode(<String, String>{'qid': qno}),
    );
    var message = await jsonDecode(response.body);
    if (message == "Successfully Deleted") {
      getQuesAdvisor();
    } else {
      print(message);
    }
  }

  void UserQuestionDelete(var qno) async {
    var url =
        'http://sanjayagarwal.in/Finance App/AdminApp/Support/UserQuestionDelete.php';
    final response = await http.post(
      url,
      body: jsonEncode(<String, String>{'qid': qno}),
    );
    var message = await jsonDecode(response.body);
    if (message == "Successfully Deleted") {
      getQuesUser();
    } else {
      print(message);
    }
  }

  Future UserQuestionInsert() async {
    var url =
        'http://sanjayagarwal.in/Finance App/AdminApp/Support/UserQuestionInsert.php';
    print("****************************************************");
    print("${q.text} ** ${a.text}");
    print("****************************************************");
    final response1 = await http.post(
      url,
      body: jsonEncode(<String, String>{
        'sid': widget.suid.toString(),
        'question': q.text,
        'answer': a.text
      }),
    );
    var message1 = jsonDecode(response1.body);
    if (message1 == "Successful Insertion") {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Support()));
    } else {
      print(message1);
    }
  }

  Future AdvisorQuestionInsert() async {
    var url =
        'http://sanjayagarwal.in/Finance App/AdminApp/Support/AdvisorQuestionInsert.php';
    print("****************************************************");
    print("${q.text} ** ${a.text}");
    print("****************************************************");
    final response1 = await http.post(
      url,
      body: jsonEncode(<String, String>{
        'sid': widget.suid.toString(),
        'question': q.text,
        'answer': a.text
      }),
    );
    var message1 = jsonDecode(response1.body);
    if (message1 == "Successful Insertion") {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Support()));
    } else {
      print(message1);
    }
  }

  bool _loading;
  void getQuesUser() async {
    setState(() {
      _loading = true;
    });
    print(widget.suid.toString());
    var url =
        'http://sanjayagarwal.in/Finance App/UserApp/Support/SupportQuestion.php';
    final response = await http.post(
      url,
      body: jsonEncode(<String, String>{
        'sid': widget.suid.toString(),
      }),
    );
    var message = await jsonDecode(response.body);
    print("****************************************");
    print(message);
    print("****************************************");
    setState(() {
      quesuser = message;
      _loading = false;
    });
  }

  void getQuesAdvisor() async {
    print(widget.suid.toString());
    var url =
        'http://sanjayagarwal.in/Finance App/AdvisorApp/Support/SupportQuestionAdvisor.php';
    final response = await http.post(
      url,
      body: jsonEncode(<String, String>{
        'sid': widget.suid.toString(),
      }),
    );
    var message = await jsonDecode(response.body);
    print("****************************************");
    print(message);
    print("****************************************");
    setState(() {
      quesadvisor = message;
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

  Widget QandA(List data) {
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
              return Padding(
                padding: const EdgeInsets.all(15),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Color(0xff63E2E0),
                      width: 2.0,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Text(data[index]["question"]),
                            Text(data[index]["answer"])
                          ],
                        ),
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
                                          question == 0
                                              ? UserQuestionDelete(
                                                  data[index]['qid'])
                                              : AdvisorQuestionDelete(
                                                  data[index]['qid']);
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
              );
            },
          );
  }

  int question;
  void changes(int index) {
    setState(() {
      question = index;
    });
  }

  TextEditingController q = TextEditingController();
  TextEditingController a = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    question = widget.x;
    List questionbody = [QandA(quesuser), QandA(quesadvisor)];
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xff63E2E0),
        currentIndex: question,
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
              height: height * 0.15,
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
                      widget.cate,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ),
                ],
              ),
            ),
            RaisedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
// return object of type Dialog
                    return AlertDialog(
                      title: Text("New FAQ"),
                      content: Container(
                        height: height * 0.15,
                        child: Column(
                          children: <Widget>[
                            TextField(
                              decoration:
                                  InputDecoration(hintText: "Enter Question"),
                              controller: q,
                            ),
                            TextField(
                              decoration:
                                  InputDecoration(hintText: "Enter Answer"),
                              controller: a,
                            ),
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        FlatButton(
                          child: Text("Add"),
                          onPressed: () {
                            question == 0
                                ? UserQuestionInsert()
                                : AdvisorQuestionInsert();
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
              child: Text(' + Add New FAQ '),
              color: Color(0xff63E2E0),
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.black),
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            questionbody[question],
          ],
        ),
      ),
    );
  }
}
