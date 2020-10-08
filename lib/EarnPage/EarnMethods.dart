import 'package:adminapp/EarnPage/AddEarn.dart';
import 'package:adminapp/EarnPage/EditEarn.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class EarnMethods extends StatefulWidget {
  @override
  _EarnMethodsState createState() => _EarnMethodsState();
}

class _EarnMethodsState extends State<EarnMethods> {
  bool _loading;
  List data = [];
  void getEarnWays() async {
    setState(() {
      _loading = true;
    });
    var url =
        'http://sanjayagarwal.in/Finance App/AdminApp/Rewards/getEarnDetails.php';
    final response = await http.post(
      url,
      body: jsonEncode(<String, String>{}),
    );
    var message = await jsonDecode(response.body);
    print("****************************************");
    print(message);
    print("****************************************");
    setState(() {
      data = message;
      _loading = false;
    });
  }

  void EarnMethodDelete(var tno) async {
    var url =
        'http://sanjayagarwal.in/Finance App/AdminApp/Rewards/EarnDelete.php';
    final response = await http.post(
      url,
      body: jsonEncode(<String, String>{'Tid': tno}),
    );
    var message = await jsonDecode(response.body);
    if (message == "Successfully Deleted") {
      getEarnWays();
    } else {
      print(message);
    }
  }

  @override
  void initState() {
    getEarnWays();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
          'HOW TO EARN',
          style: TextStyle(color: Color(0xff373D3F)),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RaisedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => AddEarn()));
              },
              child: Text(' + Add '),
              color: Color(0xff63E2E0),
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.black),
                borderRadius: BorderRadius.circular(30),
              ),
            ),
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
          : ListView.builder(
              physics: ScrollPhysics(),
              shrinkWrap: true,
              itemCount: data.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      Container(
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
                        width: width,
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "${index + 1}. ${data[index]['summary']}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                  Text(int.parse(data[index]['status']) == 0
                                      ? "Invalid"
                                      : "Valid"),
                                ],
                              ),
                              Text(
                                data[index]['content'],
                                style: TextStyle(fontSize: 18),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.edit),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  EditEarn(
                                                    int.parse(
                                                        data[index]['tid']),
                                                    data[index]['summary'],
                                                    data[index]['content'],
                                                    int.parse(
                                                        data[index]['status']),
                                                  )));
                                    },
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
                                                    EarnMethodDelete(
                                                        data[index]['tid']);
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
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
    );
  }
}
