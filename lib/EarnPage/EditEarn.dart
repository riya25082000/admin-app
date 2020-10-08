import 'package:flutter/material.dart';

import 'package:adminapp/EarnPage/EarnMethods.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class EditEarn extends StatefulWidget {
  int tid, tstatus;
  String tsummary, tcontent;
  EditEarn(this.tid, this.tsummary, this.tcontent, this.tstatus);
  @override
  _EditEarnState createState() => _EditEarnState(
      id: tid, summaryt: tsummary, contentt: tcontent, status: tstatus);
}

class _EditEarnState extends State<EditEarn> {
  int id, status;
  String summaryt, contentt;
  _EditEarnState({this.id, this.summaryt, this.contentt, this.status});

  Future EarnEdit() async {
    var url1 =
        'http://sanjayagarwal.in/Finance App/AdminApp/Rewards/EarnUpdate.php';
    final response = await http.post(
      url1,
      body: jsonEncode(<String, String>{
        'Summary': summaryt,
        'Content': contentt,
        'Status': status.toString(),
        'Tid': id.toString()
      }),
    );
    print("****************************************************");
    print("$summaryt**$contentt** ** **$status");
    print("****************************************************");
    var message1 = jsonDecode(response.body);
    if (message1 == "Successful Updation") {
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
          'UPDATE EXISTING METHOD',
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
                      child: TextFormField(
                        initialValue: summaryt,
                        onChanged: (v1) {
                          summaryt = v1;
                        },
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
                      child: TextFormField(
                        initialValue: contentt,
                        onChanged: (v2) {
                          contentt = v2;
                        },
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
                    child: TextFormField(
                      initialValue: status.toString(),
                      onChanged: (v3) {
                        status = int.parse(v3);
                      },
                    ),
                  ),
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                    padding: EdgeInsets.all(15),
                    onPressed: () {
                      EarnEdit();
                    },
                    child: Text(
                      "Update Method",
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
