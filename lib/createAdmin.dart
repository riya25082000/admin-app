import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'HomePage.dart';

class CreateAdmin extends StatefulWidget {
  @override
  _CreateAdminState createState() => _CreateAdminState();
}

class _CreateAdminState extends State<CreateAdmin> {
  bool _isHidden = true;
  void _toggleVisibility() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  String e, n, p, admid;
  bool _loading = false;
  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value)) {
      _loading = false;
      return 'Enter Valid Email';
    } else
      return null;
  }

  String validateName(String value) {
    if (value.length < 3)
      return 'Name must be more than 2 charater';
    else
      return null;
  }

  final _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  void _validateInputs() {
    if (_formKey.currentState.validate()) {
//    If all data are correct then save data to out variables
      _formKey.currentState.save();
      AdminCreate();
    } else {
//    If all data are not valid then start auto validation.
      setState(() {
        _autoValidate = true;
      });
    }
  }

  String validatePassword(String value) {
    if (value.isEmpty) {
      _loading = false;
      return 'Please enter a password';
    } else if (value.length < 8) {
      _loading = false;
      return 'Password must be greater than 8 alphabets';
    } else {
      return null;
    }
  }

  Future AdminCreate() async {
    var url =
        'http://sanjayagarwal.in/Finance App/AdminApp/CreateAdmin/CreateAdminAcc.php';
    print("****************************************************");
    print("${name.text} ** ${email.text}** ${password.text}");
    print("****************************************************");
    final response1 = await http.post(
      url,
      body: jsonEncode(<String, String>{
        'Name': n,
        'Email': e,
        'Password': p,
      }),
    );
    var message1 = jsonDecode(response1.body);
    print(message1);
    if (message1 == "Successful Insertion") {
      setState(() {
        admid = message1.toString();
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      });
    } else {
      print(message1);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  TextEditingController name = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Widget loadingIndicator = _loading
        ? new Container(
            width: 70.0,
            height: 70.0,
            child: new Padding(
                padding: const EdgeInsets.all(5.0),
                child: new Center(
                    child: new CircularProgressIndicator(
                  backgroundColor: Color(0xff63E2E0),
                ))),
          )
        : new Container();
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
          'CREATE ADMIN',
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
              child: Form(
                key: _formKey,
                autovalidate: _autoValidate,
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
                        child: TextFormField(
                          validator: validateName,
                          onSaved: (v1) {
                            n = v1;
                          },
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Enter your name'),
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
                        child: TextFormField(
                          validator: validateEmail,
                          onSaved: (v2) {
                            e = v2;
                          },
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Enter your Email ID'),
                        )),
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.fromLTRB(30, 20, 0, 10),
                      child: Text("Password",
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
                        validator: validatePassword,
                        onSaved: (v3) {
                          p = v3;
                        },
                        obscureText: _isHidden,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Enter your Password',
                            suffixIcon: IconButton(
                              onPressed: _toggleVisibility,
                              icon: _isHidden
                                  ? Icon(Icons.visibility)
                                  : Icon(Icons.visibility_off),
                            )),
                      ),
                    ),
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                      padding: EdgeInsets.all(15),
                      onPressed: () {
                        setState(() {
                          _loading = true;
                        });
                        _validateInputs();
                      },
                      child: Text(
                        "Create Admin",
                        style: TextStyle(
                            color: Color(0xff373D3F),
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                      elevation: 6.0,
                      color: Color(0xff63E2E0),
                    ),
                    Align(
                      child: loadingIndicator,
                      alignment: FractionalOffset.center,
                    ),
                  ],
                ),
              )),
        );
      }),
    );
  }
}
