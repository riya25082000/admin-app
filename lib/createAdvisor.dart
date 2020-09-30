import 'package:adminapp/HomePage.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CreateAdvisor extends StatefulWidget {
  @override
  _CreateAdvisorState createState() => _CreateAdvisorState();
}

class _CreateAdvisorState extends State<CreateAdvisor> {
  String advid = '';
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  String e, n, p;
  Future AdvisorInsert() async {
    e = email.text;
    n = name.text;
    p = phone.text;
    var url =
        'http://sanjayagarwal.in/Finance App/AdminApp/CreateAdvisor/AdvisorInsert.php';
    print("****************************************************");
    print("${name.text} ** ${email.text}** ${phone.text}");
    print("****************************************************");
    final response1 = await http.post(
      url,
      body: jsonEncode(<String, String>{
        'Email': e,
      }),
    );
    var message1 = jsonDecode(response1.body);
    print(message1);
    if (message1 != null) {
      setState(() {
        advid = message1.toString();
      });
      AdvisorDetailsInsert();
    } else {
      print(message1);
    }
  }

  Future AdvisorDetailsInsert() async {
    e = email.text;
    n = name.text;
    p = phone.text;
    var url =
        'http://sanjayagarwal.in/Finance App/AdminApp/CreateAdvisor/AdvisorDetailsInsert.php';
    print("****************************************************");
    print("${name.text} ** ${email.text}** ${phone.text}");
    print("****************************************************");
    final response1 = await http.post(
      url,
      body: jsonEncode(<String, String>{
        'AdvisorID': advid,
        'Name': n,
        'Email': e,
        'Mobile': p,
      }),
    );
    var message1 = jsonDecode(response1.body);
    print(message1);
    if (message1 == "Successful Insertion") {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    } else {
      print(message1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
          color: Color(0xff373D3F),
        ),
        centerTitle: true,
        backgroundColor: Color(0xff63E2E0),
        title: Text(
          'CREATE ADVISOR',
          style: TextStyle(
            color: Color(0xff373D3F),
          ),
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
                    child: Text("Name",
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
                        controller: name,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Enter your name'),
                        onSubmitted: (String str) {},
                      )),
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.fromLTRB(30, 20, 0, 10),
                    child: Text("Email ID",
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
                        controller: email,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Enter your Email ID'),
                        onSubmitted: (String str) {},
                      )),
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.fromLTRB(30, 20, 0, 10),
                    child: Text("Mobile No.",
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
                      controller: phone,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Enter your Mobile No.'),
                      onSubmitted: (String str) {},
                    ),
                  ),
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                    padding: EdgeInsets.all(15),
                    onPressed: () {
                      AdvisorInsert();
                    },
                    child: Text(
                      "Create Advisor",
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
