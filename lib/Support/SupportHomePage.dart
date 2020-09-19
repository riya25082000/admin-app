import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Support extends StatefulWidget {
  @override
  _SupportState createState() => _SupportState();
}

class _SupportState extends State<Support> {
  List ques = [];
  void getQues() async {
    var url =
        'http://sanjayagarwal.in/Finance App/AdminApp/Support/AdminSupport.php';
    final response = await http.post(
      url,
      body: jsonEncode(<String, String>{}),
    );
    var message = await jsonDecode(response.body);
    print("****************************************");
    print(message);
    print("****************************************");
    setState(() {
      ques = message;
    });
  }

  @override
  void initState() {
    print("****************************************");
    print("****************************************");
    getQues();
    // TODO: implement initState
    super.initState();
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
          'SUPPORT',
          style: TextStyle(color: Color(0xff373D3F)),
        ),
      ),
      body: Container(
        child: ListView.builder(
            itemCount: ques.length,
            itemBuilder: (BuildContext cntx, int index) {
              return Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Column(
                  children: <Widget>[
                    ExpansionTile(
                      title: Text(ques[index]["sname"]),
                      children: <Widget>[
                        Divider(
                          thickness: 0.8,
                          height: 1.0,
                        ),
                        ExpansionTile(
                          title: Text(ques[index]["question"]),
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(ques[index]['answer']),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Divider(
                      thickness: 0.4,
                      height: 1.0,
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
