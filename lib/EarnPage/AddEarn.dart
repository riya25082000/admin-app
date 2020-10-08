import 'package:adminapp/EarnPage/EarnMethods.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AddEarn extends StatefulWidget {
  @override
  _AddEarnState createState() => _AddEarnState();
}

class _AddEarnState extends State<AddEarn> {
  TextEditingController summary = TextEditingController();
  TextEditingController content = TextEditingController();
  TextEditingController status = TextEditingController();

  Future EarnInsert() async {
    var url1 =
        'http://sanjayagarwal.in/Finance App/AdminApp/Rewards/EarnAdd.php';
    final response = await http.post(
      url1,
      body: jsonEncode(<String, String>{
        'Summary': summary.text,
        'Content': content.text,
        'Status': status.text
      }),
    );
    print("****************************************************");
    print("${summary.text}**${content.text}** ** **${status.text}");
    print("****************************************************");
    var message1 = jsonDecode(response.body);
    if (message1 == "Successful Insertion") {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => EarnMethods()));
    } else {
      print(message1);
    }
  }

  @override
  Widget build(BuildContext context) {
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
          'ADD NEW METHOD',
          style: TextStyle(color: Color(0xff373D3F)),
        ),
      ),
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return SingleChildScrollView(
          child: Container(
              margin: EdgeInsets.only(bottom: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(30, 20, 0, 10),
                    color: Color(0xfffffff),
                    alignment: Alignment.centerLeft,
                    child: Text("Summary",
                        style: TextStyle(
                          fontSize: 25,
                          color: Color(0xff373D3F),
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  Container(
                      margin: EdgeInsets.fromLTRB(20, 20, 20, 10),
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(35),
                        color: Color(0xfffffff).withOpacity(0.9),
                      ),
                      child: TextField(
                        controller: summary,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Enter the summary'),
                        onSubmitted: (String str) {},
                      )),
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.fromLTRB(30, 20, 0, 10),
                    child: Text("Content",
                        style: TextStyle(
                          color: Color(0xff373D3F),
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        )),
                  ),
                  Container(
                      margin: EdgeInsets.fromLTRB(20, 20, 20, 10),
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(35),
                        color: Color(0xfffffff).withOpacity(0.9),
                      ),
                      child: TextField(
                        controller: content,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Enter the content'),
                        onSubmitted: (String str) {},
                      )),
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.fromLTRB(30, 20, 0, 10),
                    child: Text("Status",
                        style: TextStyle(
                          color: Color(0xff373D3F),
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(20, 20, 20, 50),
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(35),
                      color: Color(0xfffffff).withOpacity(0.9),
                    ),
                    child: TextField(
                      controller: status,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: '1 for valid, 0 for invalid'),
                      onSubmitted: (String str) {},
                    ),
                  ),
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                    padding: EdgeInsets.all(15),
                    onPressed: () {
                      EarnInsert();
                    },
                    child: Text(
                      "Add Method",
                      style: TextStyle(
                          color: Color(0xff373D3F),
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                    elevation: 6.0,
                    color: Color(0xff63E2E0),
                  ),
                ],
              )),
        );
      }),
    );
  }
}
